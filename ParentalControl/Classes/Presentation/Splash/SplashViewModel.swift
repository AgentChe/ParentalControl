//
//  SplashViewModel.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

import RxSwift
import RxCocoa
import OtterScaleiOS

final class SplashViewModel {
    enum Step {
        case onboarding, main, paygate, requestPIN
    }
    
    var tryAgain: ((Error) -> (Observable<Void>))?
    
    lazy var validationComplete = PublishRelay<Void>()
    lazy var authorizationComplete = PublishRelay<Void>()
    lazy var paygateClosed = PublishRelay<Void>()
    
    lazy var validationActivity = RxActivityIndicator()
    lazy var libraryActivity = RxActivityIndicator()
    
    private lazy var sessionManager = SessionManager()
    private lazy var profileManager = ProfileManager()
    private lazy var paygateManager = PaygateManager()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
}

// MARK: Public
extension SplashViewModel {
    func step() -> Driver<Step> {
        handleValidationComplete()
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let self = self else {
                    return .never()
                }
                
                return self.library()
            }
            .flatMap { [weak self] _ -> Driver<Step> in
                guard let self = self else {
                    return .never()
                }
                
                return self.makeStep()
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}

// MARK: Private
private extension SplashViewModel {
    func handleValidationComplete() -> Observable<Void> {
        Observable
            .zip(validationComplete, authorizationComplete)
            .flatMapLatest { [weak self] _ -> Observable<Void> in
                guard let self = self else {
                    return .never()
                }
                
                let otterScaleID = OtterScale.shared.getInternalID()
            
                func source() -> Single<Void> {
                    let complete: Single<Void>
                    
                    if let cachedToken = self.sessionManager.getSession()?.userToken {
                        if cachedToken != otterScaleID {
                            complete = self.profileManager.syncTokens(oldToken: cachedToken,
                                                                      newToken: otterScaleID)
                        } else {
                            complete = .deferred { .just(Void()) }
                        }
                    } else {
                        complete = self.profileManager.login(userToken: otterScaleID)
                    }
                    
                    return complete
                }
                
                func trigger(error: Error) -> Observable<Void> {
                    guard let tryAgain = self.tryAgain?(error) else {
                        return .empty()
                    }
                    
                    return tryAgain
                }
                
                return self.observableRetrySingle
                    .retry(source: { source() },
                           trigger: { trigger(error: $0) })
                    .trackActivity(self.validationActivity)
                    .flatMap { _ -> Single<Void> in
                        let session = Session(userToken: otterScaleID)
                        self.sessionManager.store(session: session)
                        
                        return .deferred { .just(Void()) }
                    }
            }
    }
    
    func library() -> Observable<Void> {
        func source() -> Single<Void> {
            let paygate = paygateManager
                .obtainPaygate(forceUpdate: true)
                .mapToVoid()
            let profile = profileManager
                .obtainProfile(forceUpdate: true)
                .mapToVoid()

            return Single
                .zip([
//                    paygate, // TODO
                    profile
                ])
                .mapToVoid()
        }

        func trigger(error: Error) -> Observable<Void> {
            guard let tryAgain = self.tryAgain?(error) else {
                return .empty()
            }

            return tryAgain
        }

        return self.observableRetrySingle
            .retry(source: { source() },
                   trigger: { trigger(error: $0) })
            .trackActivity(libraryActivity)
    }
    
    func makeStep() -> Driver<Step> {
        let initial = Single<Step>
            .create { event in
                let step: Step

                if !OnboardingViewController.wasViewed() {
                    step = .onboarding
                } else if self.needPayment() {
                    step = .paygate
                } else if self.profileManager.isRequestPIN {
                    step = .requestPIN
                } else {
                    step = .main
                }

                event(.success(step))
                
                return Disposables.create()
            }
            .asDriver(onErrorDriveWith: .never())
        
        let afterPaygate = paygateClosed
            .map { [weak self] void -> Step in
                (self?.profileManager.isRequestPIN == true) ? .requestPIN : .main
            }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(initial, afterPaygate)
    }
    
    func needPayment() -> Bool {
        let activeSubscription = sessionManager.hasActiveSubscriptions()
        return !activeSubscription
    }
}

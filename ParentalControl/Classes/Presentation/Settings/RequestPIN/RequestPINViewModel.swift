//
//  RequestPINViewModel.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.11.2023.
//

import RxSwift
import RxCocoa

final class RequestPINViewModel {
    enum Route {
        case checkEmail(String), incorrectPINAlert, unblock
    }
    
    var tryAgain: ((Error) -> (Observable<Void>))?
    
    private lazy var profileManager = ProfileManager()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
}

// MARK: Public
extension RequestPINViewModel {
    struct Input {
        let forgotPIN: Signal<Void>
        let inputPIN: Signal<String>
        let unblockedByFaceId: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
        let emailAvailable: Driver<Bool>
    }
    
    func configure(input: Input) -> Output {
        let pin = makePIN()
        
        return Output(
            route: makeRoute(
                forgotPIN: input.forgotPIN,
                pin: pin,
                inputPIN: input.inputPIN,
                unblockedByFaceId: input.unblockedByFaceId
            ),
            emailAvailable: makeEmailAvailable()
        )
    }
}

// MARK: Private
private extension RequestPINViewModel {
    func makePIN() -> Driver<String> {
        profileManager
            .obtainProfile(forceUpdate: false)
            .compactMap { $0?.pin }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeRoute(
        forgotPIN: Signal<Void>,
        pin: Driver<String>,
        inputPIN: Signal<String>,
        unblockedByFaceId: Signal<Void>
    ) -> Driver<Route> {
        let checkEmail = forgotPIN
            .flatMapLatest { [weak self] void -> Driver<String> in
                guard let self else {
                    return .never()
                }
                
                func source() -> Single<String> {
                    self.profileManager
                        .forgotPIN()
                        .flatMap {
                            self.profileManager
                                .obtainProfile(forceUpdate: false)
                                .map { $0?.email ?? "" }
                        }
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
                    .asDriver(onErrorDriveWith: .never())
            }
            .map { Route.checkEmail($0) }
        
        let result = Driver
            .combineLatest(pin, inputPIN.asDriver(onErrorDriveWith: .never()))
            .map { pin, inputPIN -> Route in
                (pin == inputPIN) ? .unblock : .incorrectPINAlert
            }
        
        let faceId = unblockedByFaceId
            .map { Route.unblock }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(checkEmail, result, faceId)
    }
    
    func makeEmailAvailable() -> Driver<Bool> {
        profileManager
            .obtainProfile(forceUpdate: false)
            .asDriver(onErrorDriveWith: .never())
            .map { profile -> Bool in
                guard let email = profile?.email else {
                    return false
                }
                
                return !email.isEmpty
            }
    }
}

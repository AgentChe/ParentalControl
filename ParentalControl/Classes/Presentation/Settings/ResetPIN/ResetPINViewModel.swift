//
//  ResetPINViewModel.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.11.2023.
//

import RxSwift
import RxCocoa

final class ResetPINViewModel {
    enum Route {
        case checkEmail(String), pinSet
    }
    
    enum State {
        case enter(Bool)
        case set
        case confirm(Bool, String?)
    }
    
    var tryAgain: ((Error) -> (Observable<Void>))?
    
    private lazy var profileManager = ProfileManager()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
}

// MARK: Public
extension ResetPINViewModel {
    struct Input {
        let forgotPIN: Signal<Void>
        let setPIN: Signal<String>
        let inputPIN: Signal<String>
    }
    
    struct Output {
        let emailAvailable: Driver<Bool>
        let route: Driver<Route>
        let state: Driver<State>
    }
    
    func configure(input: Input) -> Output {
        Output(
            emailAvailable: makeEmailAvailable(),
            route: makeRoute(
                forgotPIN: input.forgotPIN,
                setPIN: input.setPIN
            ),
            state: makeState(inputPIN: input.inputPIN)
        )
    }
}

// MARK: Private
private extension ResetPINViewModel {
    typealias StatePIN = (state: State, pin: String)
    
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
    
    func makeRoute(forgotPIN: Signal<Void>, setPIN: Signal<String>) -> Driver<Route> {
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
        
        let pinSet = setPIN
            .flatMap { [weak self] pin -> Driver<Void> in
                guard let self else {
                    return .never()
                }
                
                func source() -> Single<Void> {
                    self.profileManager
                        .set(pin: pin)
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
            .map { Route.pinSet }
        
        return Driver
            .merge(checkEmail, pinSet)
    }
    
    func makeState(inputPIN: Signal<String>) -> Driver<State> {
        let pin = profileManager
            .obtainProfile(forceUpdate: false)
            .map { $0?.pin ?? "" }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .combineLatest(pin, inputPIN.asDriver(onErrorDriveWith: .never()))
            .scan((State.enter(true), "")) { statePIN, pins -> StatePIN in
                let (currentState, previousInput) = statePIN
                let (pinInCache, inputPIN) = pins
                
                switch currentState {
                case .enter:
                    if (pinInCache == inputPIN) {
                        return (.set, inputPIN)
                    } else {
                        return (.enter(false), inputPIN)
                    }
                case .set:
                    return (.confirm(true, nil), inputPIN)
                case .confirm:
                    if (previousInput == inputPIN) {
                        return (.confirm(true, inputPIN), inputPIN)
                    } else {
                        return (.confirm(false, nil), previousInput)
                    }
                }
            }
            .map { $0.0 }
            .startWith(.enter(true))
    }
}

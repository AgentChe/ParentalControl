//
//  PINViewModel.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import RxSwift
import RxCocoa

final class PINViewModel {
    enum Step {
        case display(PINView.Step)
        case scroll(PINView.Step)
    }
    
    private lazy var profileManager = ProfileManager()
}

// MARK: Public
extension PINViewModel {
    struct Input {
        let didSetPIN: Signal<String>
        let didSetEmail: Signal<String>
        let didSkipEmail: Signal<Void>
        let didCompletedFaceId: Signal<Void>
        let didSkipFaceId: Signal<Void>
    }
    
    struct Output {
        let step: Driver<Step>
    }
    
    func configure(input: Input) -> Output {
        Output(
            step: makeStep(
                didSetPIN: input.didSetPIN,
                didSetEmail: input.didSetEmail,
                didSkipEmail: input.didSkipEmail,
                didCompletedFaceId: input.didCompletedFaceId,
                didSkipFaceId: input.didSkipFaceId
            )
        )
    }
}

// MARK: Private
private extension PINViewModel {
    func makeStep(
        didSetPIN: Signal<String>,
        didSetEmail: Signal<String>,
        didSkipEmail: Signal<Void>,
        didCompletedFaceId: Signal<Void>,
        didSkipFaceId: Signal<Void>
    ) -> Driver<Step> {
        let initial = profileManager
            .obtainProfile(forceUpdate: false)
            .map { $0?.pin == nil ? Step.display(.pin) : Step.display(.menu) }
            .asDriver(onErrorDriveWith: .never())
        
        let setPin = didSetPIN
            .flatMap { [weak self] pin -> Signal<Void> in
                guard let self else {
                    return .never()
                }
                
                return self.profileManager
                    .set(pin: pin)
                    .asSignal(onErrorSignalWith: .never())
            }
            .map { Step.scroll(.email) }
            .asDriver(onErrorDriveWith: .never())
        
        let setEmail = didSetEmail
            .flatMap { [weak self] email -> Signal<Void> in
                guard let self else {
                    return .never()
                }
                
                return self.profileManager
                    .set(email: email)
                    .asSignal(onErrorSignalWith: .never())
            }
            .map { Step.scroll(.faceId) }
            .asDriver(onErrorDriveWith: .never())
        
        let skipEmail = didSkipEmail
            .map { Step.scroll(.faceId) }
            .asDriver(onErrorDriveWith: .never())
        
        let completedFaceId = Signal
            .merge(didCompletedFaceId, didSkipFaceId)
            .map { Step.display(.menu) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(initial, setPin, setEmail, skipEmail, completedFaceId)
    }
}

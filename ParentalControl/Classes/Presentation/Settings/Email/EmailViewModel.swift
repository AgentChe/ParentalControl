//
//  EmailViewModel.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import RxSwift
import RxCocoa

final class EmailViewModel {
    var tryAgain: ((Error) -> (Observable<Void>))?
    
    private lazy var profileManager = ProfileManager()
    
    private lazy var activity = RxActivityIndicator()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
}

// MARK: Public
extension EmailViewModel {
    struct Input {
        let didSave: Signal<String>
    }
    
    struct Output {
        let initialEmail: Driver<String?>
        let activity: Driver<Bool>
        let disposable: Disposable
    }
    
    func configure(input: Input) -> Output {
        Output(
            initialEmail: makeInitialEmail(),
            activity: activity.asDriver(),
            disposable: makeSave(didSave: input.didSave)
        )
    }
}

// MARK: Public
private extension EmailViewModel {
    func makeInitialEmail() -> Driver<String?> {
        profileManager
            .obtainProfile(forceUpdate: false)
            .map { $0?.email }
            .asDriver(onErrorJustReturn: nil)
    }
    
    func makeSave(didSave: Signal<String>) -> Disposable {
        didSave
            .flatMap { [weak self] email -> Signal<Void> in
                guard let self else {
                    return .never()
                }
                
                func source() -> Single<Void> {
                    self.profileManager
                        .set(email: email)
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
                    .trackActivity(self.activity)
                    .asSignal(onErrorSignalWith: .never())
            }
            .emit()
    }
}

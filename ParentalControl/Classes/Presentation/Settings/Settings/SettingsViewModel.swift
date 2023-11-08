//
//  SettingsViewModel.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import RxSwift
import RxCocoa

final class SettingsViewModel {
    private lazy var profileManager = ProfileManager()
}

// MARK: Public
extension SettingsViewModel {
    struct Input {}
    
    struct Output {
        let elements: Driver<[SettingsTableElement]>
    }
    
    func configure(input: Input) -> Output {
        let email = makeEmail()
        
        return Output(
            elements: makeElements(email: email)
        )
    }
}

// MARK: Private
private extension SettingsViewModel {
    func makeElements(email: Driver<String?>) -> Driver<[SettingsTableElement]> {
        email
            .map { email -> [SettingsTableElement] in
                [
                    .account(email),
                    .route
                ]
            }
    }
    
    func makeEmail() -> Driver<String?> {
        let initial = profileManager
            .obtainProfile(forceUpdate: false)
            .map { $0?.email }
            .asDriver(onErrorJustReturn: nil)
        
        let updated = ProfileMediator.shared
            .didChangeEmail
            .map { string -> String? in string }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(initial, updated)
    }
}

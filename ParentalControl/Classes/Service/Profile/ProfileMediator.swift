//
//  ProfileMediator.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import RxSwift
import RxCocoa

final class ProfileMediator {
    static let shared = ProfileMediator()
    
    private lazy var didChangeChildYearOfBirthTrigger = PublishRelay<Int>()
    private lazy var didChangeTimeLimitTrigger = PublishRelay<TimeLimit>()
    private lazy var didChangePinTrigger = PublishRelay<String>()
    private lazy var didChangeEmailTrigger = PublishRelay<String>()
    
    private init() {}
}

// MARK: Public
extension ProfileMediator {
    var didChangeChildYearOfBirth: Signal<Int> {
        didChangeChildYearOfBirthTrigger.asSignal()
    }
    
    var didChangeTimeLimit: Signal<TimeLimit> {
        didChangeTimeLimitTrigger.asSignal()
    }
    
    var didChangePin: Signal<String> {
        didChangePinTrigger.asSignal()
    }
    
    var didChangeEmail: Signal<String> {
        didChangeEmailTrigger.asSignal()
    }
    
    func didChange(childYearOfBirth: Int) {
        didChangeChildYearOfBirthTrigger.accept(childYearOfBirth)
    }
    
    func didChange(timeLimit: TimeLimit) {
        didChangeTimeLimitTrigger.accept(timeLimit)
    }
    
    func didChange(pin: String) {
        didChangePinTrigger.accept(pin)
    }
    
    func didChange(email: String) {
        didChangeEmailTrigger.accept(email)
    }
}

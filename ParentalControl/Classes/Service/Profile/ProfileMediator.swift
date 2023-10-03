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
    private lazy var didChangeScreenTimeLimitMinutesTrigger = PublishRelay<Int>()
    private lazy var didChangeScheduleTrigger = PublishRelay<WeekSchedule>()
    private lazy var didChangePinTrigger = PublishRelay<String>()
    private lazy var didChangeEmailTrigger = PublishRelay<String>()
    
    private init() {}
}

// MARK: Public
extension ProfileMediator {
    var didChangeChildYearOfBirth: Signal<Int> {
        didChangeChildYearOfBirthTrigger.asSignal()
    }
    
    var didChangeScreenTimeLimitMinutes: Signal<Int> {
        didChangeScreenTimeLimitMinutesTrigger.asSignal()
    }
    
    var didChangeSchedule: Signal<WeekSchedule> {
        didChangeScheduleTrigger.asSignal()
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
    
    func didChange(screenTimeLimitMinutes: Int) {
        didChangeScreenTimeLimitMinutesTrigger.accept(screenTimeLimitMinutes)
    }
    
    func didChange(schedule: WeekSchedule) {
        didChangeScheduleTrigger.accept(schedule)
    }
    
    func didChange(pin: String) {
        didChangePinTrigger.accept(pin)
    }
    
    func didChange(email: String) {
        didChangeEmailTrigger.accept(email)
    }
}

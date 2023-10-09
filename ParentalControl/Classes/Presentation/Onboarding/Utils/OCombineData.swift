//
//  OCombineData.swift
//  Wicca
//
//  Created by Андрей Чернышев on 23.08.2022.
//

import Foundation

struct OCombineData {
    let screenTimeLimit: TimeLimit?
    let schedule: WeekSchedule
    let pin: String?
    let email: String?
}

final class OnboardingCombineData {
    var screenTimeLimit: TimeLimit?
    var schedule: WeekSchedule?
    var pin: String?
    var email: String?
    
    func combineData() -> OCombineData? {
        guard let schedule = schedule else {
            return nil
        }
        
        return OCombineData(
            screenTimeLimit: screenTimeLimit,
            schedule: schedule,
            pin: pin,
            email: email
        )
    }
}

// MARK: OScreenTimeLimitViewDelegate
extension OnboardingCombineData: OScreenTimeLimitViewDelegate {
    func screenTimeLimitDidSelect(timeLimit: TimeLimit) {
        self.screenTimeLimit = timeLimit
    }
}

// MARK: OScheduleViewDelegate
extension OnboardingCombineData: OScheduleViewDelegate {
    func scheduleViewDidSet(schedule: WeekSchedule) {
        self.schedule = schedule
    }
}

// MARK: OPinViewDelegate
extension OnboardingCombineData: OPinViewDelegate {
    func pinViewDidSet(pin: String) {
        self.pin = pin
    }
}

// MARK: OSignUpViewDelegate
extension OnboardingCombineData: OSignUpViewDelegate {
    func signUpViewDidSet(email: String) {
        self.email = email
    }
}

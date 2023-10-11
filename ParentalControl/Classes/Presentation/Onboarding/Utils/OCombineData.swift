//
//  OCombineData.swift
//  Wicca
//
//  Created by Андрей Чернышев on 23.08.2022.
//

import Foundation

struct OCombineData {
    let timeLimit: TimeLimit?
    let pin: String?
    let email: String?
}

final class OnboardingCombineData {
    var timeLimitMinutes: Int?
    var timeLimitSchedule: WeekSchedule?
    var pin: String?
    var email: String?
    
    func combineData() -> OCombineData? {
        var timeLimit: TimeLimit? {
            guard let timeLimitMinutes, let timeLimitSchedule else {
                return nil
            }
            
            return TimeLimit(
                minutes: timeLimitMinutes,
                schedule: timeLimitSchedule
            )
        }
        
        return OCombineData(
            timeLimit: timeLimit,
            pin: pin,
            email: email
        )
    }
}

// MARK: OScreenTimeLimitViewDelegate
extension OnboardingCombineData: OScreenTimeLimitViewDelegate {
    func screenTimeLimitDidSelect(timeLimitMinutes: Int) {
        self.timeLimitMinutes = timeLimitMinutes
    }
}

// MARK: OScheduleViewDelegate
extension OnboardingCombineData: OScheduleViewDelegate {
    func scheduleViewDidSet(schedule: WeekSchedule) {
        self.timeLimitSchedule = schedule
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

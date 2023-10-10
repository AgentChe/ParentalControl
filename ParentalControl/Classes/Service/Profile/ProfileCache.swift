//
//  ProfileCache.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 10.10.2023.
//

import Foundation

final class ProfileCache {
    static let shared = ProfileCache()
    
    private lazy var userDefaults = UserDefaults(suiteName: GlobalDefinitions.groupId)
    
    private init() {}
}

// MARK: Public
extension ProfileCache {
    enum Constants {
        static let screenTimeLimit = "profile_manager_screen_time_limit_"
        static let schedule = "profile_manager_screen_schedule"
        static let pin = "profile_manager_screen_pin"
        static let email = "profile_manager_screen_email"
    }
    
    func store(screenTimeLimit: TimeLimit?) {
        guard let screenTimeLimit else {
            return
        }
        
        if let data = try? JSONEncoder().encode(screenTimeLimit) {
            userDefaults?.set(data, forKey: Constants.screenTimeLimit)
        }
    }
    
    func screenTimeLimit() -> TimeLimit? {
        var screenTimeLimit: TimeLimit?
        
        if let data = userDefaults?.data(forKey: Constants.screenTimeLimit) {
            screenTimeLimit = try? JSONDecoder().decode(TimeLimit.self, from: data)
        }
        
        return screenTimeLimit
    }
    
    func store(schedule: WeekSchedule?) {
        guard let schedule else {
            return
        }
        
        if let data = try? JSONEncoder().encode(schedule) {
            userDefaults?.set(data, forKey: Constants.schedule)
        }
    }
    
    func schedule() -> WeekSchedule? {
        var schedule: WeekSchedule?
        
        if let data = userDefaults?.data(forKey: Constants.schedule) {
            schedule = try? JSONDecoder().decode(WeekSchedule.self, from: data)
        }
        
        return schedule
    }
    
    func store(pin: String?) {
        guard let pin else {
            return
        }
        
        userDefaults?.set(pin, forKey: Constants.pin)
    }
    
    func pin() -> String? {
        userDefaults?.object(forKey: Constants.pin) as? String
    }
    
    func store(email: String?) {
        guard let email else {
            return
        }
        
        userDefaults?.set(email, forKey: Constants.email)
    }
    
    func email() -> String? {
        userDefaults?.object(forKey: Constants.email) as? String
    }
}

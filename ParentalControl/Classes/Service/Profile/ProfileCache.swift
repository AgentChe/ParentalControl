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
        static let timeLimit = "profile_manager_time_limit"
        static let pin = "profile_manager_screen_pin"
        static let email = "profile_manager_screen_email"
    }
    
    func store(timeLimit: TimeLimit?) {
        guard let timeLimit else {
            return
        }
        
        let cache = CacheData(date: Date(), object: timeLimit)
        
        if let data = try? JSONEncoder().encode(cache) {
            userDefaults?.set(data, forKey: Constants.timeLimit)
        }
        
        MonitoringService.shared.startMonitoring(timeLimit: timeLimit)
    }
    
    func timeLimit() -> CacheData<TimeLimit>? {
        var cache: CacheData<TimeLimit>?
        
        if let data = userDefaults?.data(forKey: Constants.timeLimit) {
            cache = try? JSONDecoder().decode(CacheData<TimeLimit>.self, from: data)
        }
        
        return cache
    }
    
    func store(pin: String?) {
        guard let pin else {
            return
        }
        
        let cache = CacheData(date: Date(), object: pin)
        
        if let data = try? JSONEncoder().encode(cache) {
            userDefaults?.set(data, forKey: Constants.pin)
        }
    }
    
    func pin() -> CacheData<String>? {
        var cache: CacheData<String>?
        
        if let data = userDefaults?.data(forKey: Constants.pin) {
            cache = try? JSONDecoder().decode(CacheData<String>.self, from: data)
        }
        
        return cache
    }
    
    func store(email: String?) {
        guard let email else {
            return
        }
        
        let cache = CacheData(date: Date(), object: email)
        
        if let data = try? JSONEncoder().encode(cache) {
            userDefaults?.set(data, forKey: Constants.email)
        }
    }
    
    func email() -> CacheData<String>? {
        var cache: CacheData<String>?
        
        if let data = userDefaults?.data(forKey: Constants.email) {
            cache = try? JSONDecoder().decode(CacheData<String>.self, from: data)
        }
        
        return cache
    }
}

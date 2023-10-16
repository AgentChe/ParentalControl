//
//  ContentService.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import Foundation

final class ContentService {
    static let shared = ContentService()
    
    private lazy var userDefaults = UserDefaults.standard
    
    private init() {}
}

// MARK: Public
extension ContentService {
    enum Constants {
        static let timeLimit = "content_service_time_limit"
    }
    
    func store(timeLimit: TimeLimit?) {
        guard let timeLimit else {
            return
        }
        
        let cache = CacheData(date: Date(), object: timeLimit)
        
        if let data = try? JSONEncoder().encode(cache) {
            userDefaults.set(data, forKey: Constants.timeLimit)
        }
        
        MonitoringService.shared.startMonitoring(timeLimit: timeLimit)
    }
    
    func timeLimit() -> TimeLimit? {
        var mainCache: CacheData<TimeLimit>? {
            ProfileCache.shared.timeLimit()
        }
        
        var selfCache: CacheData<TimeLimit>? {
            if let data = userDefaults.data(forKey: Constants.timeLimit) {
                return try? JSONDecoder().decode(CacheData<TimeLimit>.self, from: data)
            }
            
            return nil
        }
        
        if mainCache == nil && selfCache == nil {
            return nil
        }
        
        if let mainCache = mainCache, let selfCache = selfCache {
            return max(mainCache, selfCache).object
        }
        
        if let mainCache = mainCache {
            return mainCache.object
        }
        
        if let selfCache = selfCache {
            return selfCache.object
        }
        
        return nil
    }
}

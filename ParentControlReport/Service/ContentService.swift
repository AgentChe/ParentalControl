//
//  ContentService.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import Foundation

protocol ContentServicePorotocol: AnyObject {
    func store(timeLimit: TimeLimit?)
    func timeLimit() -> TimeLimit?
    func set(downtime: Downtime)
    func remove(downtimeId: String)
    func downtimes() -> [Downtime]
}

final class ContentService {
    enum Constants {
        static let timeLimit = "content_service_time_limit"
        static let downtimes = "content_service_downtimes"
        static let wasCreatedDefaultDowntimes = "content_service_created_default_downtimes"
    }
    
    static let shared = ContentService()
    
    private lazy var userDefaults = UserDefaults.standard
    
    private init() {
        createDefaultIfNeeded()
    }
}

// MARK: ContentServicePorotocol
extension ContentService: ContentServicePorotocol {
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
    
    func set(downtime: Downtime) {
        var downtimes = downtimes()
        
        if let index = downtimes.firstIndex(where: { $0.id == downtime.id }) {
            downtimes[index] = downtime
        } else {
            downtimes.append(downtime)
        }
        
        if let data = try? JSONEncoder().encode(downtimes) {
            userDefaults.set(data, forKey: Constants.downtimes)
        }
    }
    
    func remove(downtimeId: String) {
        var downtimes = downtimes()
        
        downtimes.removeAll(where: { $0.id == downtimeId })
        
        if let data = try? JSONEncoder().encode(downtimes) {
            userDefaults.set(data, forKey: Constants.downtimes)
        }
    }
    
    func downtimes() -> [Downtime] {
        var downtimes = [Downtime]()
        
        if
            let data = userDefaults.data(forKey: Constants.downtimes),
            let decoded = try? JSONDecoder().decode([Downtime].self, from: data) {
            downtimes = decoded
        }
        
        return downtimes
    }
}

// MARK: Private
private extension ContentService {
    func createDefaultIfNeeded() {
        guard !userDefaults.bool(forKey: Constants.wasCreatedDefaultDowntimes) else {
            return
        }
        
        let downtimes = [
            Downtime(
                name: "Downtime.Bedtime".localized,
                enable: false,
                isDefault: true
            ),
            Downtime(
                name: "Downtime.Homework".localized,
                enable: false,
                isDefault: true
            ),
            Downtime(
                name: "Downtime.School".localized,
                enable: false,
                isDefault: true
            )
        ]
        
        if let data = try? JSONEncoder().encode(downtimes) {
            userDefaults.set(data, forKey: Constants.downtimes)
        }
        
        userDefaults.set(true, forKey: Constants.wasCreatedDefaultDowntimes)
    }
}

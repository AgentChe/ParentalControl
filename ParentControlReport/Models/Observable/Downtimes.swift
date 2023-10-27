//
//  Downtimes.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

final class Downtimes: ObservableObject {
    enum Constants {
        static let downtimes = "downtimes"
        static let wasCreatedDefaultDowntimes = "created_default"
    }
    
    @Published private(set) var downtimes = [Downtime]()
    
    private lazy var userDefaults = UserDefaults.standard
    
    init() {
        createDefaultIfNeeded()
        
        downtimes = obtain()
    }
}

// MARK: Public
extension Downtimes {
    func set(downtime: Downtime) {
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
        downtimes.removeAll(where: { $0.id == downtimeId })
        
        if let data = try? JSONEncoder().encode(downtimes) {
            userDefaults.set(data, forKey: Constants.downtimes)
        }
    }
}

// MARK: Private
private extension Downtimes {
    func obtain() -> [Downtime] {
        var downtimes = [Downtime]()
        
        if
            let data = userDefaults.data(forKey: Constants.downtimes),
            let decoded = try? JSONDecoder().decode([Downtime].self, from: data) {
            downtimes = decoded
        }
        
        return downtimes
    }
    
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

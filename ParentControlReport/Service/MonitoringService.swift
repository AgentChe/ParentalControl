//
//  MonitoringService.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 16.10.2023.
//

import DeviceActivity
import ManagedSettings
import Foundation

final class MonitoringService {
    static let shared = MonitoringService()
    
    private lazy var center = DeviceActivityCenter()
    private lazy var store = ManagedSettingsStore()
    
    private lazy var timeLimitActivities: [DeviceActivityName] = [
        .timeLimitSu,
        .timeLimitMo,
        .timeLimitTu,
        .timeLimitWe,
        .timeLimitTh,
        .timeLimitFr,
        .timeLimitSa
    ]
    
    private init() {}
}

// MARK: Public
extension MonitoringService {
    func startMonitoring(timeLimit: TimeLimit) {
        center.stopMonitoring(timeLimitActivities)

        guard timeLimit.enable else {
            unblockAll()
            return
        }

        for weekdayIndex in 1...7 {
            var args: (enable: Bool, activity: DeviceActivityName) {
                switch weekdayIndex {
                case 1:
                    return (enable: timeLimit.schedule.su, activity: .timeLimitSu)
                case 2:
                    return (enable: timeLimit.schedule.mo, activity: .timeLimitMo)
                case 3:
                    return (enable: timeLimit.schedule.tu, activity: .timeLimitTu)
                case 4:
                    return (enable: timeLimit.schedule.we, activity: .timeLimitWe)
                case 5:
                    return (enable: timeLimit.schedule.th, activity: .timeLimitTh)
                case 6:
                    return (enable: timeLimit.schedule.fr, activity: .timeLimitFr)
                case 7:
                    return (enable: timeLimit.schedule.sa, activity: .timeLimitSa)
                default:
                    return (enable: false, activity: .timeLimitFr)
                }
            }

            let (enable, activity) = args

            guard enable else {
                continue
            }

            let schedule = DeviceActivitySchedule(
                intervalStart: DateComponents(hour: 0, minute: 0, second: 0, weekday: weekdayIndex),
                intervalEnd: DateComponents(hour: 23, minute: 59, second: 59, weekday: weekdayIndex),
                repeats: true
            )

            let event = DeviceActivityEvent(threshold: DateComponents(minute: timeLimit.minutes))
            let eventName = DeviceActivityEvent.Name("Time limit event for \(weekdayIndex)")

            try? center.startMonitoring(
                activity,
                during: schedule,
                events: [eventName: event]
            )
        }
    }
}

// MARK: DeviceActivityMonitor Extension
extension MonitoringService {
    func intervalDidStart(for activity: DeviceActivityName) {
        if timeLimitActivities.contains(activity) {
            unblockAll()
        }
    }
    
    func intervalDidEnd(for activity: DeviceActivityName) {
        if timeLimitActivities.contains(activity) {
            unblockAll()
        }
    }
    
    func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        if timeLimitActivities.contains(activity) {
            store.shield.applicationCategories = .all()
            store.shield.webDomainCategories = .all()
        }
    }
}

// MARK: Private
private extension MonitoringService {
    func unblockAll() {
        store.clearAllSettings()
    }
}

// MARK: Additional
private extension DeviceActivityName {
    static let timeLimitSu = Self("Time limit su")
    static let timeLimitMo = Self("Time limit mo")
    static let timeLimitTu = Self("Time limit tu")
    static let timeLimitWe = Self("Time limit we")
    static let timeLimitTh = Self("Time limit th")
    static let timeLimitFr = Self("Time limit fr")
    static let timeLimitSa = Self("Time limit sa")
}

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
    enum Constants {
        static let store_timeLimit = "store_timeLimit"
    }
    
    static let shared = MonitoringService()
    
    private lazy var center = DeviceActivityCenter()
    private lazy var timeLimitStore = ManagedSettingsStore.timeLimit
    
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
            timeLimitStore.clearAllSettings()
            return
        }
        
        monitoring(timeLimit: timeLimit)
    }
    
    func startMonitoring(downtime: Downtime) {
        stopMonitoring(downtimeId: downtime.id)
        monitoring(downtime: downtime)
    }
    
    func stopMonitoring(downtimeId: String) {
        let activities = [
            DeviceActivityName(downtimeId: downtimeId, weekday: "su"),
            DeviceActivityName(downtimeId: downtimeId, weekday: "mo"),
            DeviceActivityName(downtimeId: downtimeId, weekday: "tu"),
            DeviceActivityName(downtimeId: downtimeId, weekday: "we"),
            DeviceActivityName(downtimeId: downtimeId, weekday: "th"),
            DeviceActivityName(downtimeId: downtimeId, weekday: "fr"),
            DeviceActivityName(downtimeId: downtimeId, weekday: "sa")
        ]
        center.stopMonitoring(activities)
        
        activities.forEach { activity in
            let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: activity.rawValue))
            store.clearAllSettings()
        }
    }
}

// MARK: DeviceActivityMonitor Extension
extension MonitoringService {
    func intervalDidStart(for activity: DeviceActivityName) {
        if timeLimitActivities.contains(activity) {
            timeLimitStore.clearAllSettings()
        } else if activity.isDowntime {
            let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: activity.rawValue))
            store.shield.applicationCategories = .all()
            store.shield.webDomainCategories = .all()
        }
    }
    
    func intervalDidEnd(for activity: DeviceActivityName) {
        if timeLimitActivities.contains(activity) {
            timeLimitStore.clearAllSettings()
        } else if activity.isDowntime {
            let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: activity.rawValue))
            store.clearAllSettings()
        }
    }
    
    func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        if timeLimitActivities.contains(activity) {
            timeLimitStore.shield.applicationCategories = .all()
            timeLimitStore.shield.webDomainCategories = .all()
        }
    }
}

// MARK: Private
private extension MonitoringService {
    func monitoring(timeLimit: TimeLimit) {
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
    
    func monitoring(downtime: Downtime) {
        guard downtime.enable, let schedule = downtime.schedule, let from = downtime.from, let to = downtime.to else {
            return
        }
        
        let calendar = Calendar.current
        
        for weekdayIndex in 1...7 {
            var args: (enable: Bool, activity: DeviceActivityName) {
                switch weekdayIndex {
                case 1:
                    return (
                        enable: schedule.su,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "su")
                    )
                case 2:
                    return (
                        enable: schedule.mo,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "mo")
                    )
                case 3:
                    return (
                        enable: schedule.tu,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "tu")
                    )
                case 4:
                    return (
                        enable: schedule.we,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "we")
                    )
                case 5:
                    return (
                        enable: schedule.th,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "th")
                    )
                case 6:
                    return (
                        enable: schedule.fr,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "fr")
                    )
                case 7:
                    return (
                        enable: schedule.sa,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "sa")
                    )
                default:
                    return (
                        enable: false,
                        activity: DeviceActivityName(downtimeId: downtime.id, weekday: "sa")
                    )
                }
            }

            let (enable, activity) = args

            guard enable else {
                continue
            }
            
            var startComponents = calendar.dateComponents([.hour, .minute], from: from)
            startComponents.second = 0
            startComponents.weekday = weekdayIndex
            
            var endComponents = calendar.dateComponents([.hour, .minute], from: to)
            endComponents.second = 0
            endComponents.weekday = weekdayIndex

            let schedule = DeviceActivitySchedule(
                intervalStart: startComponents,
                intervalEnd: endComponents,
                repeats: true
            )

            try? center.startMonitoring(activity, during: schedule)
        }
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
    
    init(downtimeId: String, weekday: String) {
        self = Self(String(format: "downtime_%@_%@", downtimeId, weekday))
    }
    
    var isDowntime: Bool {
        rawValue.contains("downtime")
    }
}

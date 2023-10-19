//
//  DeviceActivityMonitorExtension.swift
//  ParentControlActivity
//
//  Created by Андрей Чернышев on 16.10.2023.
//

import Foundation
import DeviceActivity
import ManagedSettings

final class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        MonitoringService.shared.intervalDidStart(for: activity)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        MonitoringService.shared.intervalDidEnd(for: activity)
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        MonitoringService.shared.eventDidReachThreshold(event, activity: activity)
    }
}

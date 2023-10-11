//
//  MainReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import DeviceActivity
import SwiftUI

struct MainReport: DeviceActivityReportScene {
    var context: DeviceActivityReport.Context = .main
    
    let content: (MainBundle) -> MainView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> MainBundle {
        var totalActivityDuration: TimeInterval = 0
        
        for await item in data {
            for await segment in item.activitySegments {
                totalActivityDuration += segment.totalActivityDuration
            }
        }
        
        return MainBundle(
            totalActivityDuration: totalActivityDuration
        )
    }
}

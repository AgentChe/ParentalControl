//
//  ParentControlReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import DeviceActivity
import SwiftUI

@main
struct ParentControlReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        MainReport { daysActivities in
            MainView(daysActivities: daysActivities)
        }
        
        AppsBlockedReport { activity in
            AppsBlockedList(activity: activity)
        }
    }
}

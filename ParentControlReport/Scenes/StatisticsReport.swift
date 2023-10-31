//
//  StatisticsReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 18.10.2023.
//

import DeviceActivity
import SwiftUI
import ManagedSettings

struct StatisticsReport: DeviceActivityReportScene {
    var context: DeviceActivityReport.Context = .statistics
    
    let content: ([DayActivity]) -> StatisticsView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> [DayActivity] {
        []
//        var days = [DayActivity]()
//
//        for await item in data {
//            for await segment in item.activitySegments {
//                var categories = [ActivityCategory]()
//
//                for await category in segment.categories {
//                    guard
//                        let token = category.category.token,
//                        let name = category.category.localizedDisplayName
//                    else {
//                        continue
//                    }
//
//                    var activityApplications = [ActivityApplication]()
//
//                    for await application in category.applications {
//                        guard
//                            let token = application.application.token,
//                            let name = application.application.localizedDisplayName
//                        else {
//                            continue
//                        }
//
//                        let activityApplication = ActivityApplication(
//                            token: token,
//                            name: name,
//                            totalActivityDuration: application.totalActivityDuration
//                        )
//                        activityApplications.append(activityApplication)
//                    }
//
//                    let activityCategory = ActivityCategory(
//                        token: token,
//                        totalActivityDuration: category.totalActivityDuration,
//                        name: name
////                        applications: activityApplications,
////                        webHistory: []
//                    )
//                    categories.append(activityCategory)
//                }
//
//                let day = DayActivity(
//                    day: segment.dateInterval.start,
//                    categories: categories
//                )
//                days.append(day)
//            }
//        }
//
//        return days
    }
}

//
//  MainReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import DeviceActivity
import SwiftUI
import ManagedSettings

struct MainReport: DeviceActivityReportScene {
    var context: DeviceActivityReport.Context = .main
    
    let content: (DaysActivities) -> MainView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> DaysActivities {
        var days = [DayActivity]()
        
        let blockedDomains = ManagedSettingsStore.webHistory.shield.webDomains ?? []
        
        for await item in data {
            for await segment in item.activitySegments {
                var categories = [ActivityCategory]()
                var activityApplications = [ActivityApplication]()
                var webHistory = [WebHistoryItem]()
                
                for await category in segment.categories {
                    guard
                        let token = category.category.token,
                        let name = category.category.localizedDisplayName
                    else {
                        continue
                    }
                    
                    let activityCategory = ActivityCategory(
                        token: token,
                        totalActivityDuration: category.totalActivityDuration,
                        name: name
                    )
                    categories.append(activityCategory)
                    
                    for await application in category.applications {
                        guard
                            let token = application.application.token,
                            let name = application.application.localizedDisplayName
                        else {
                            continue
                        }
                        
                        let activityApplication = ActivityApplication(
                            token: token,
                            name: name,
                            totalActivityDuration: application.totalActivityDuration,
                            category: activityCategory
                        )
                        activityApplications.append(activityApplication)
                    }
                    
                    for await webDomain in category.webDomains {
                        var blocked: Bool {
                            guard let token = webDomain.webDomain.token else {
                                return false
                            }
                            
                            return blockedDomains.contains(token)
                        }
                        
                        let item = WebHistoryItem(
                            domain: webDomain.webDomain,
                            totalActivityDuration: webDomain.totalActivityDuration,
                            blocked: blocked
                        )
                        webHistory.append(item)
                    }
                }
                
                let day = DayActivity(
                    day: segment.dateInterval.start,
                    categories: categories,
                    applications: activityApplications,
                    webHistory: webHistory
                )
                days.append(day)
            }
        }
        
        return DaysActivities(days: days)
    }
}

//
//  AppsBlockedReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import DeviceActivity
import SwiftUI
import ManagedSettings

struct AppsBlockedReport: DeviceActivityReportScene {
    var context: DeviceActivityReport.Context = .appsBlocked
    
    let content: (Activity) -> AppsBlockedList
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> Activity {
        var categories = [ActivityCategory]()
        var activityApplications = [ActivityApplication]()
        var webHistory = [WebHistoryItem]()
        
        let blockedDomains = ManagedSettingsStore.webHistory.shield.webDomains ?? []
        
        for await item in data {
            for await segment in item.activitySegments {
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
                    if !categories.contains(where: { $0.token == token }) {
                        categories.append(activityCategory)
                    }
                    
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
                        if !activityApplications.contains(where: { $0.token == token }) {
                            activityApplications.append(activityApplication)
                        }
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
                        if !webHistory.contains(where: { $0.domain.token ==  item.domain.token }) {
                            webHistory.append(item)
                        }
                    }
                }
            }
        }
        
        return Activity(
            categories: categories,
            applications: activityApplications,
            webHistory: webHistory
        )
    }
}

//
//  ActivityCategory.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import ManagedSettings
import DeviceActivity
import Foundation

final class ActivityCategory: ObservableObject, Hashable {
    let token: ActivityCategoryToken
    @Published var totalActivityDuration: TimeInterval
    let name: String
    let applications: [ActivityApplication]
    @Published var webHistory: [WebHistoryItem]
    
    init(
        token: ActivityCategoryToken,
        totalActivityDuration: TimeInterval,
        name: String,
        applications: [ActivityApplication],
        webHistory: [WebHistoryItem]
    ) {
        self.token = token
        self.totalActivityDuration = totalActivityDuration
        self.name = name
        self.applications = applications
        self.webHistory = webHistory
    }
    
    static func == (lhs: ActivityCategory, rhs: ActivityCategory) -> Bool {
        lhs.token == rhs.token
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(token)
        hasher.combine(totalActivityDuration)
        hasher.combine(name)
        hasher.combine(applications)
        hasher.combine(webHistory)
    }
}

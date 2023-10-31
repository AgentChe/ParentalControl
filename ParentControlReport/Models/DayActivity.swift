//
//  DayActivity.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import DeviceActivity
import Foundation
import ManagedSettings

final class DayActivity: ObservableObject, Identifiable, Hashable {
    let id: String
    let day: Date
    let categories: [ActivityCategory]
    let applications: [ActivityApplication]
    @Published var webHistory: [WebHistoryItem]
    
    init(
        id: String = UUID().uuidString,
        day: Date,
        categories: [ActivityCategory],
        applications: [ActivityApplication],
        webHistory: [WebHistoryItem]
    ) {
        self.id = id
        self.day = day
        self.categories = categories
        self.applications = applications
        self.webHistory = webHistory
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DayActivity, rhs: DayActivity) -> Bool {
        lhs.id == rhs.id
    }
}

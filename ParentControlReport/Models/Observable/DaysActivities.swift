//
//  DaysActivities.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import SwiftUI
import ManagedSettings

final class DaysActivities: ObservableObject {
    @Published var days: [DayActivity]
    
    private lazy var webHistoryStore = ManagedSettingsStore.webHistory
    
    init(days: [DayActivity]) {
        self.days = days
    }
}

// MARK: Public
extension DaysActivities {
    func update(item: WebHistoryItem) {
        guard let token = item.domain.token else {
            return
        }
        
        var domains = webHistoryStore.shield.webDomains ?? []
        
        if item.blocked {
            domains.remove(token)
        } else {
            domains.insert(token)
        }
        
        webHistoryStore.shield.webDomains = domains
        
        days.forEach { day in
            day.webHistory.forEach { webHistoryItem in
                if webHistoryItem.domain.token == item.domain.token {
                    webHistoryItem.blocked.toggle()
                }
            }
        }
        
        objectWillChange.send()
    }
}

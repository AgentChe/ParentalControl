//
//  WebHistoryItem.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import Foundation
import ManagedSettings

final class WebHistoryItem: ObservableObject, Identifiable, Hashable {
    let id: String
    let domain: WebDomain
    @Published var totalActivityDuration: TimeInterval
    @Published var blocked: Bool
    
    init(
        id: String = UUID().uuidString,
        domain: WebDomain,
        totalActivityDuration: TimeInterval,
        blocked: Bool
    ) {
        self.id = id
        self.domain = domain
        self.totalActivityDuration = totalActivityDuration
        self.blocked = blocked
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(domain)
        hasher.combine(totalActivityDuration)
        hasher.combine(blocked)
    }
    
    static func == (lhs: WebHistoryItem, rhs: WebHistoryItem) -> Bool {
        lhs.id == rhs.id
    }
}

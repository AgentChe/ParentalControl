//
//  ActivityApplication.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import Foundation
import ManagedSettings

struct ActivityApplication: Hashable, Identifiable {
    let id: String
    let token: ApplicationToken
    let name: String
    let totalActivityDuration: TimeInterval
    weak var category: ActivityCategory?
    
    init(
        id: String = UUID().uuidString,
        token: ApplicationToken,
        name: String,
        totalActivityDuration: TimeInterval,
        category: ActivityCategory?
    ) {
        self.id = id
        self.token = token
        self.name = name
        self.totalActivityDuration = totalActivityDuration
        self.category = category
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(token)
        hasher.combine(name)
        hasher.combine(totalActivityDuration)
    }
}

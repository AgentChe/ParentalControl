//
//  ActivityCategory.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import ManagedSettings
import DeviceActivity
import Foundation

final class ActivityCategory: Hashable, Identifiable {
    let id: String
    let token: ActivityCategoryToken
    let totalActivityDuration: TimeInterval
    let name: String
    
    init(
        id: String = UUID().uuidString,
        token: ActivityCategoryToken,
        totalActivityDuration: TimeInterval,
        name: String
    ) {
        self.id = id
        self.token = token
        self.totalActivityDuration = totalActivityDuration
        self.name = name
    }
    
    static func == (lhs: ActivityCategory, rhs: ActivityCategory) -> Bool {
        lhs.token == rhs.token
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(token)
        hasher.combine(totalActivityDuration)
        hasher.combine(name)
    }
}

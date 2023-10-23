//
//  Downtime.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import Foundation

struct Downtime: Codable, Hashable {
    let id: String
    let name: String
    var from: Date?
    var to: Date?
    var schedule: WeekSchedule?
    var enable: Bool
    var isDefault: Bool
    
    init(
        id: String = UUID().uuidString,
        name: String,
        from: Date? = nil,
        to: Date? = nil,
        schedule: WeekSchedule? = nil,
        enable: Bool = true,
        isDefault: Bool = false
    ) {
        self.id = id
        self.name = name
        self.from = from
        self.to = to
        self.schedule = schedule
        self.enable = enable
        self.isDefault = isDefault
    }
}

// MARK: Public
extension Downtime {
    var isEmpty: Bool {
        (from == nil) || (to == nil) || (schedule == nil)
    }
}

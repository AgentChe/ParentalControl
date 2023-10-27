//
//  Downtime.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import Foundation

final class Downtime: ObservableObject, Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name, from, to, schedule, enable, isDefault
    }
    
    let id: String
    let name: String
    @Published var from: Date?
    @Published var to: Date?
    @Published var schedule: WeekSchedule?
    @Published var enable: Bool
    let isDefault: Bool
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        from = try? container.decode(Date.self, forKey: .from)
        to = try? container.decode(Date.self, forKey: .to)
        schedule = try? container.decode(WeekSchedule.self, forKey: .schedule)
        enable = try container.decode(Bool.self, forKey: .enable)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try? container.encode(from, forKey: .from)
        try? container.encode(to, forKey: .to)
        try? container.encode(schedule, forKey: .schedule)
        try container.encode(enable, forKey: .enable)
        try container.encode(isDefault, forKey: .isDefault)
    }
}

// MARK: Public
extension Downtime {
    var isEmpty: Bool {
        (from == nil) || (to == nil) || (schedule == nil)
    }
}

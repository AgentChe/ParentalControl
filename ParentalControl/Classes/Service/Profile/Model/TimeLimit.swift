//
//  TimeLimit.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.10.2023.
//

struct TimeLimit: Codable, Hashable {
    var minutes: Int
    var schedule: WeekSchedule
    var enable: Bool
}

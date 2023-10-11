//
//  TimeLimit.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.10.2023.
//

struct TimeLimit: Codable, Hashable {
    let minutes: Int
    let schedule: WeekSchedule
    let enable: Bool
}

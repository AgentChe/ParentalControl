//
//  WeekSchedule.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

struct WeekSchedule: Codable, Hashable {
    let su: Bool
    let mo: Bool
    let tu: Bool
    let we: Bool
    let th: Bool
    let fr: Bool
    let sa: Bool
}

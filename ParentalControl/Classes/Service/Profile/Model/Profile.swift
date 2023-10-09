//
//  Profile.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

struct Profile: Codable, Hashable {
    let screenTimeLimit: TimeLimit?
    let schedule: WeekSchedule
    let pin: String?
    let email: String?
}

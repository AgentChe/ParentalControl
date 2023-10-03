//
//  Profile.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

struct Profile: Codable, Hashable {
    let screenTimeLimitMinutes: Int?
    let schedule: WeekSchedule
    let pin: String?
    let email: String?
}

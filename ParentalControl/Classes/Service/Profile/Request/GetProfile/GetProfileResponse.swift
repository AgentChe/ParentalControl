//
//  GetProfileResponse.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

enum GetProfileResponse {
    static func map(from response: Any) -> Profile? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let scheduleJSON = data["schedule"] as? [String: Any]
        else {
            return nil
        }
        
        let schedule = WeekSchedule(
            su: scheduleJSON["su"] as? Bool ?? false,
            mo: scheduleJSON["mo"] as? Bool ?? false,
            tu: scheduleJSON["tu"] as? Bool ?? false,
            we: scheduleJSON["we"] as? Bool ?? false,
            th: scheduleJSON["th"] as? Bool ?? false,
            fr: scheduleJSON["fr"] as? Bool ?? false,
            sa: scheduleJSON["sa"] as? Bool ?? false
        )
        
        return Profile(
            screenTimeLimitMinutes: data["screen_time_limit_minutes"] as? Int,
            schedule: schedule,
            pin: data["pin"] as? String,
            email: data["email"] as? String
        )
    }
}

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
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        return Profile(
            pin: data["pin"] as? String,
            email: data["email"] as? String
        )
    }
}

//
//  SetRequest.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import Alamofire

struct SetRequest: APIRequestBody {
    let userToken: String
    let timeLimitMinutes: Int?
    let timeLimitSchedule: WeekSchedule?
    let pin: String?
    let email: String?

    var url: String {
        GlobalDefinitions.domain + "/api/users/set"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let timeLimitMinutes = timeLimitMinutes {
            params["screen_time_limit_minutes"] = timeLimitMinutes
        }
        
        if let timeLimitSchedule = timeLimitSchedule {
            let scheduleJSON = [
                "su": timeLimitSchedule.su,
                "mo": timeLimitSchedule.mo,
                "tu": timeLimitSchedule.tu,
                "we": timeLimitSchedule.we,
                "th": timeLimitSchedule.th,
                "fr": timeLimitSchedule.fr,
                "sa": timeLimitSchedule.sa
            ]
            params["schedule"] = scheduleJSON
        }
        
        if let pin = pin {
            params["pin"] = pin
        }
        
        if let email = email {
            params["email"] = email
        }
        
        return params
    }
}

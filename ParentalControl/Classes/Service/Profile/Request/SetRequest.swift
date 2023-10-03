//
//  SetRequest.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import Alamofire

struct SetRequest: APIRequestBody {
    let userToken: String
    let screenTimeLimitMinutes: Int?
    let schedule: WeekSchedule?
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
        
        if let screenTimeLimitMinutes = screenTimeLimitMinutes {
            params["screen_time_limit_minutes"] = screenTimeLimitMinutes
        }
        
        if let schedule = schedule {
            let scheduleJSON = [
                "su": schedule.su,
                "mo": schedule.mo,
                "tu": schedule.tu,
                "we": schedule.we,
                "th": schedule.th,
                "fr": schedule.fr,
                "sa": schedule.sa
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

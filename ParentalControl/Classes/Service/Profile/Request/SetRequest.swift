//
//  SetRequest.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import Alamofire

struct SetRequest: APIRequestBody {
    let userToken: String
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
        
        if let pin = pin {
            params["pin"] = pin
        }
        
        if let email = email {
            params["email"] = email
        }
        
        return params
    }
}

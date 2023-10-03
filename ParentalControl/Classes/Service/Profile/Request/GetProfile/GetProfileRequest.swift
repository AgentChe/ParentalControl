//
//  GetProfileRequest.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import Alamofire

struct GetProfileRequest: APIRequestBody {
    let userToken: String

    var url: String {
        GlobalDefinitions.domain + "/api/users/show"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "user_token": userToken
        ]
    }
}

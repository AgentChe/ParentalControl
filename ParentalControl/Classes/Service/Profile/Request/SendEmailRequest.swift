//
//  SendEmailRequest.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.11.2023.
//

import Alamofire

struct SendEmailRequest: APIRequestBody {
    let userToken: String

    var url: String {
        GlobalDefinitions.domain + "/api/users/send_email"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
    }
}

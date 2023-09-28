//
//  RestAPITransport.swift
//  Soccer
//
//  Created by Андрей Чернышев on 11.03.2022.
//

import RxSwift
import Alamofire

final class RestAPITransport {
    func callServerApi(requestBody: APIRequestBody) -> Single<Any> {
        Single.create { single in
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 30
            
            let encodedUrl = requestBody.url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            let request = manager.request(encodedUrl,
                                          method: requestBody.method,
                                          parameters: requestBody.parameters,
                                          encoding: requestBody.encoding,
                                          headers: requestBody.headers)
                .validate(statusCode: [200, 201])
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let json):
                        single(.success(json))
                    case .failure(let error):
                        single(.failure(NetworkError(.serverNotAvailable, underlyingError: error)))
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func formBody(data: Data, request: APIRequestBody) -> Single<Any> {
        Single<Any>.create { single in
            let to = URL(string: request.url)!
            let headers = request.headers
            
            let request = AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "file", fileName: String(format: "%@%@.jpeg", UUID().uuidString, String(Date().timeIntervalSinceNow)), mimeType: "image/jpeg")
            }, to: to, headers: headers)
            
            request
                .validate(statusCode: [200, 201])
                .response { response in
                    if let error = response.error {
                        single(.failure(NetworkError(.serverNotAvailable, underlyingError: error)))
                    } else if let data = response.data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            single(.success(json))
                        } catch let error {
                            single(.failure(NetworkError(.serverNotAvailable, underlyingError: error)))
                        }
                    } else {
                        single(.failure(NetworkError(.serverNotAvailable)))
                    }
                }
            
            return Disposables.create()
        }
    }
}

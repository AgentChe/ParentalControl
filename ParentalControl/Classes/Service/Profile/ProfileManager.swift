//
//  ProfileManager.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

import RxSwift

protocol ProfileManagerProtocol {
    func set(
        timeLimit: TimeLimit?,
        pin: String?,
        email: String?
    ) -> Single<Void>
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?>
    func syncTokens(oldToken: String, newToken: String) -> Single<Void>
    func login(userToken: String) -> Single<Void>
}

final class ProfileManager {
    private lazy var defaultRequestWrapper = DefaultRequestWrapper()
    
    private lazy var sessionManager = SessionManager()
}

// MARK: ProfileManagerProtocol
extension ProfileManager: ProfileManagerProtocol {
    func set(
        timeLimit: TimeLimit?,
        pin: String?,
        email: String?
    ) -> Single<Void> {
        guard let userToken = sessionManager.getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetRequest(
            userToken: userToken,
            timeLimitMinutes: timeLimit?.minutes,
            timeLimitSchedule: timeLimit?.schedule,
            pin: pin,
            email: email
        )
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: { [weak self] in
                self?.store(timeLimit: timeLimit)
                self?.store(pin: pin)
                self?.store(email: email)
            })
    }
    
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?> {
        Single
            .zip(
                cachedTimeLimit(),
                cachedPin(),
                cachedEmail()
            )
            .map { timeLimit, pin, email -> Profile? in
                return Profile(
                    timeLimit: timeLimit,
                    pin: pin,
                    email: email
                )
            }
    }
    
    func syncTokens(oldToken: String, newToken: String) -> Single<Void> {
        let request = SyncTokensRequest(oldToken: oldToken,
                                        newToken: newToken)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
    }
    
    func login(userToken: String) -> Single<Void> {
        let request = LoginRequest(userToken: userToken)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
    }
}

// MARK: Private
private extension ProfileManager {
    func store(timeLimit: TimeLimit?) {
        ProfileCache.shared.store(timeLimit: timeLimit)
        
        if let timeLimit = timeLimit {
            ProfileMediator.shared.didChange(timeLimit: timeLimit)
        }
    }
    
    func cachedTimeLimit() -> Single<TimeLimit?> {
        Single<TimeLimit?>.create { single in
            let timeLimit = ProfileCache.shared.timeLimit()?.object
            single(.success(timeLimit))
            
            return Disposables.create()
        }
    }
    
    func store(pin: String?) {
        ProfileCache.shared.store(pin: pin)
        
        if let pin = pin {
            ProfileMediator.shared.didChange(pin: pin)
        }
    }
    
    func cachedPin() -> Single<String?> {
        Single<String?>.create { single in
            let pin = ProfileCache.shared.pin()?.object
            single(.success(pin))
            
            return Disposables.create()
        }
    }
    
    func store(email: String?) {
        ProfileCache.shared.store(email: email)
        
        if let email = email {
            ProfileMediator.shared.didChange(email: email)
        }
    }
    
    func cachedEmail() -> Single<String?> {
        Single<String?>.create { single in
            let email = ProfileCache.shared.email()?.object
            single(.success(email))
            
            return Disposables.create()
        }
    }
}

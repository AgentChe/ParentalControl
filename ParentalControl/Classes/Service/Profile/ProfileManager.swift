//
//  ProfileManager.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

import RxSwift

protocol ProfileManagerProtocol {
    func set(
        screenTimeLimit: TimeLimit?,
        schedule: WeekSchedule?,
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
        screenTimeLimit: TimeLimit?,
        schedule: WeekSchedule?,
        pin: String?,
        email: String?
    ) -> Single<Void> {
        guard let userToken = sessionManager.getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetRequest(
            userToken: userToken,
            screenTimeLimit: screenTimeLimit,
            schedule: schedule,
            pin: pin,
            email: email
        )
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: { [weak self] in
                self?.store(screenTimeLimit: screenTimeLimit)
                self?.store(schedule: schedule)
                self?.store(pin: pin)
                self?.store(email: email)
            })
    }
    
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?> {
        Single
            .zip(
                cachedScreenTimeLimit(),
                cachedSchedule(),
                cachedPin(),
                cachedEmail()
            )
            .map { screenTimeLimit, schedule, pin, email -> Profile? in
                guard let schedule else {
                    return nil
                }
                
                return Profile(
                    screenTimeLimit: screenTimeLimit,
                    schedule: schedule,
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
    func store(screenTimeLimit: TimeLimit?) {
        ProfileCache.shared.store(screenTimeLimit: screenTimeLimit)
        
        if let screenTimeLimit = screenTimeLimit {
            ProfileMediator.shared.didChange(screenTimeLimit: screenTimeLimit)
        }
    }
    
    func cachedScreenTimeLimit() -> Single<TimeLimit?> {
        Single<TimeLimit?>.create { single in
            let screenTimeLimit = ProfileCache.shared.screenTimeLimit()
            single(.success(screenTimeLimit))
            
            return Disposables.create()
        }
    }
    
    func store(schedule: WeekSchedule?) {
        ProfileCache.shared.store(schedule: schedule)
        
        if let schedule = schedule {
            ProfileMediator.shared.didChange(schedule: schedule)
        }
    }
    
    func cachedSchedule() -> Single<WeekSchedule?> {
        Single<WeekSchedule?>.create { single in
            let schedule = ProfileCache.shared.schedule()
            single(.success(schedule))
            
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
            let pin = ProfileCache.shared.pin()
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
            let email = ProfileCache.shared.email()
            single(.success(email))
            
            return Disposables.create()
        }
    }
}

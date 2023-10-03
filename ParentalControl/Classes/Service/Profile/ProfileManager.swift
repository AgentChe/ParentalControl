//
//  ProfileManager.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

import RxSwift

protocol ProfileManagerProtocol {
    func set(
        screenTimeLimitMinutes: Int?,
        schedule: WeekSchedule?,
        pin: String?,
        email: String?
    ) -> Single<Void>
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?>
    func syncTokens(oldToken: String, newToken: String) -> Single<Void>
    func login(userToken: String) -> Single<Void>
}

final class ProfileManager {
    enum Constants {
        static let screenTimeLimitMinutes = "profile_manager_screen_time_limit_minutes"
        static let schedule = "profile_manager_screen_schedule"
        static let pin = "profile_manager_screen_pin"
        static let email = "profile_manager_screen_email"
    }
    
    private lazy var defaultRequestWrapper = DefaultRequestWrapper()
    
    private lazy var sessionManager = SessionManager()
}

// MARK: ProfileManagerProtocol
extension ProfileManager: ProfileManagerProtocol {
    func set(
        screenTimeLimitMinutes: Int?,
        schedule: WeekSchedule?,
        pin: String?,
        email: String?
    ) -> Single<Void> {
        guard let userToken = sessionManager.getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetRequest(
            userToken: userToken,
            screenTimeLimitMinutes: screenTimeLimitMinutes,
            schedule: schedule,
            pin: pin,
            email: email
        )
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: { [weak self] in
                self?.store(screenTimeLimitMinutes: screenTimeLimitMinutes)
                self?.store(schedule: schedule)
                self?.store(pin: pin)
                self?.store(email: email)
            })
    }
    
    func obtainProfile(forceUpdate: Bool) -> Single<Profile?> {
        Single
            .zip(
                cachedScreenTimeLimitMinutes(),
                cachedSchedule(),
                cachedPin(),
                cachedEmail()
            )
            .map { screenTimeLimitMinutes, schedule, pin, email -> Profile? in
                guard let schedule else {
                    return nil
                }
                
                return Profile(
                    screenTimeLimitMinutes: screenTimeLimitMinutes,
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
    func store(screenTimeLimitMinutes: Int?) {
        guard let screenTimeLimitMinutes else {
            return
        }
        
        UserDefaults.standard.set(screenTimeLimitMinutes, forKey: Constants.screenTimeLimitMinutes)
        
        ProfileMediator.shared.didChange(screenTimeLimitMinutes: screenTimeLimitMinutes)
    }
    
    func cachedScreenTimeLimitMinutes() -> Single<Int?> {
        Single<Int?>.create { single in
            let screenTimeLimitMinutes = UserDefaults.standard.object(forKey: Constants.screenTimeLimitMinutes) as? Int
            
            single(.success(screenTimeLimitMinutes))
            
            return Disposables.create()
        }
    }
    
    func store(schedule: WeekSchedule?) {
        guard let schedule else {
            return
        }
        
        if let data = try? JSONEncoder().encode(schedule) {
            UserDefaults.standard.set(data, forKey: Constants.schedule)
        }
        
        ProfileMediator.shared.didChange(schedule: schedule)
    }
    
    func cachedSchedule() -> Single<WeekSchedule?> {
        Single<WeekSchedule?>.create { single in
            var schedule: WeekSchedule?
            
            if let data = UserDefaults.standard.data(forKey: Constants.schedule) {
                schedule = try? JSONDecoder().decode(WeekSchedule.self, from: data)
            }
            
            single(.success(schedule))
            
            return Disposables.create()
        }
    }
    
    func store(pin: String?) {
        guard let pin else {
            return
        }
        
        UserDefaults.standard.set(pin, forKey: Constants.pin)
        
        ProfileMediator.shared.didChange(pin: pin)
    }
    
    func cachedPin() -> Single<String?> {
        Single<String?>.create { single in
            let pin = UserDefaults.standard.object(forKey: Constants.pin) as? String
            
            single(.success(pin))
            
            return Disposables.create()
        }
    }
    
    func store(email: String?) {
        guard let email else {
            return
        }
        
        UserDefaults.standard.set(email, forKey: Constants.email)
        
        ProfileMediator.shared.didChange(email: email)
    }
    
    func cachedEmail() -> Single<String?> {
        Single<String?>.create { single in
            let email = UserDefaults.standard.object(forKey: Constants.email) as? String
            
            single(.success(email))
            
            return Disposables.create()
        }
    }
}

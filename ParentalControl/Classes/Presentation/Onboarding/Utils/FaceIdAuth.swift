//
//  FaceIdAuth.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import LocalAuthentication
import RxSwift
import RxCocoa

final class FaceIdAuthMediator {
    static let shared = FaceIdAuthMediator()
    
    private lazy var didChangeStatusTrigger = PublishRelay<Bool>()
    
    private init() {}
    
    func change(value: Bool) {
        didChangeStatusTrigger.accept(value)
    }
    
    var didChangeStatus: Signal<Bool> {
        didChangeStatusTrigger.asSignal()
    }
}

final class FaceIdAuth {
    enum Constants {
        static let faceIdAuthKey = "face_id_auth_key"
    }
    
    private weak var vc: UIViewController?
    
    init(vc: UIViewController?) {
        self.vc = vc
    }
}

// MARK: Public
extension FaceIdAuth {
    static var isEnable: Bool {
        UserDefaults.standard.bool(forKey: Constants.faceIdAuthKey)
    }
    
    func invalidate() {
        UserDefaults.standard.set(false, forKey: Constants.faceIdAuthKey)
        FaceIdAuthMediator.shared.change(value: false)
    }
    
    func auth(completion: (() -> Void)? = nil) {
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            let alert = UIAlertController(
                title: "Onboarding.FaceId.Unavailable.Title".localized,
                message: "Onboarding.FaceId.Unavailable.Text".localized,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel)
            alert.addAction(okAction)
            
            vc?.present(alert, animated: true)
            
            return
        }
        
        let reason = "Onboarding.FaceId.SubTitle".localized
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
            DispatchQueue.main.async { [weak self] in
                if success {
                    completion?()
                    UserDefaults.standard.set(true, forKey: Constants.faceIdAuthKey)
                    FaceIdAuthMediator.shared.change(value: true)
                } else {
                    let alert = UIAlertController(
                        title: "Onboarding.FaceId.Failed.Title".localized,
                        message: "Onboarding.FaceId.Failed.Text".localized,
                        preferredStyle: .alert
                    )
                    
                    let okAction = UIAlertAction(title: "OK".localized, style: .cancel)
                    alert.addAction(okAction)
                    
                    self?.vc?.present(alert, animated: true)
                }
            }
        }
    }
}

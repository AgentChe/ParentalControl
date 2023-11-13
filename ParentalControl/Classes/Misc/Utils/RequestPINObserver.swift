//
//  RequestPINObserver.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 13.11.2023.
//

import UIKit

final class RequestPINObserver {
    static let shared = RequestPINObserver()
    
    private lazy var isFirstCallback = true
    
    private lazy var notificationCenter = NotificationCenter.default
    private lazy var profileManager = ProfileManager()
    
    private init() {}
}

// MARK: Public
extension RequestPINObserver {
    func startObserve() {
        notificationCenter.addObserver(self, selector: #selector(willDeactivateNotification), name: UIScene.willDeactivateNotification, object: nil)
    }
    
    func launched() {
        isFirstCallback = false
    }
}

// MARK: Private
private extension RequestPINObserver {
    @objc
    func willDeactivateNotification() {
        guard !isFirstCallback, profileManager.isRequestPIN else {
            return
        }
        
        UIApplication.shared.keyWindow?.rootViewController = RequestPINViewController.make(mode: .root)
    }
}

//
//  RequestReview.swift
//  Soccer
//
//  Created by Андрей Чернышев on 10.11.2022.
//

import StoreKit

enum RequestReview {
    enum Constants {
        static let requested = "requets_review_requested"
    }
    
    static func requestIfNeeded() {
        guard
            !UserDefaults.standard.bool(forKey: Constants.requested),
            let scene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
        else {
            return
        }

        AmplitudeManager.shared
            .logEvent(name: "Rating Request")

        DispatchQueue.main.async {
            SKStoreReviewController.requestReview(in: scene)
            
            UserDefaults.standard.set(true, forKey: Constants.requested)
        }
    }
}

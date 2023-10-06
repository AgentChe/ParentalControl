//
//  FamilyControlsManager.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import FamilyControls

final class FamilyControlsManager {
    static let shared = FamilyControlsManager()
    
    private init() {}
}

// MARK: Public
extension FamilyControlsManager {
    func requestAuthorization() {
        Task {
            try? await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        }
    }
}

//
//  Selections.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 31.10.2023.
//

import SwiftUI
import DeviceActivity
import FamilyControls
import Combine
import ManagedSettings

final class Selections: ObservableObject {
    enum Constants {
        static let cacheKey = "selections_activity_selection"
    }
    
    @Published var activitySelection = FamilyActivitySelection(includeEntireCategory: true)

    private lazy var userDefaults = UserDefaults(suiteName: GlobalDefinitions.groupId)

    private lazy var encoder = PropertyListEncoder()
    private lazy var decoder = PropertyListDecoder()

    private var cancellables = Set<AnyCancellable>()

    init() {
        activitySelection = savedSelection() ?? FamilyActivitySelection(includeEntireCategory: true)

        $activitySelection.sink { [weak self] selection in
            self?.saveSelection(selection: selection)
            self?.monitoring(selection: selection)
        }
        .store(in: &cancellables)
    }
}

// MARK: Public
extension Selections {
    var applicationsTokens: [ApplicationToken] {
        var result = [ApplicationToken]()
        activitySelection.applicationTokens.forEach { result.append($0) }
        return result
    }
}

// MARK: Private
private extension Selections {
    func saveSelection(selection: FamilyActivitySelection) {
        userDefaults?.set(try? encoder.encode(selection), forKey: Constants.cacheKey)
    }

    func savedSelection() -> FamilyActivitySelection? {
        guard let data = userDefaults?.data(forKey: Constants.cacheKey) else {
            return nil
        }

        return try? decoder.decode(FamilyActivitySelection.self, from: data)
    }
    
    func monitoring(selection: FamilyActivitySelection) {
        let store = ManagedSettingsStore.appsBlocked
        store.shield.applications = selection.applicationTokens
        store.shield.webDomains = selection.webDomainTokens
    }
}

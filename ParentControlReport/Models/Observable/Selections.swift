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
    enum Activity {
        case appsBlocked, timeLimit
        
        var key: String {
            switch self {
            case .appsBlocked:
                return "apps_blocked"
            case .timeLimit:
                return "time_limit" 
            }
        }
    }

    @Published var activitySelection = FamilyActivitySelection(includeEntireCategory: true)

    private lazy var userDefaults = UserDefaults(suiteName: GlobalDefinitions.groupId)

    private lazy var encoder = PropertyListEncoder()
    private lazy var decoder = PropertyListDecoder()

    private var cancellables = Set<AnyCancellable>()
    
    private let activity: Activity

    init(activity: Activity) {
        self.activity = activity
        
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
    var isEmpty: Bool {
        activitySelection.applications.isEmpty
    }
    
    var applicationsTokens: [ApplicationToken] {
        var result = [ApplicationToken]()
        activitySelection.applicationTokens.forEach { result.append($0) }
        return result
    }
}

// MARK: Private
private extension Selections {
    func saveSelection(selection: FamilyActivitySelection) {
        userDefaults?.set(try? encoder.encode(selection), forKey: activity.key)
    }

    func savedSelection() -> FamilyActivitySelection? {
        guard let data = userDefaults?.data(forKey: activity.key) else {
            return nil
        }

        return try? decoder.decode(FamilyActivitySelection.self, from: data)
    }
    
    func monitoring(selection: FamilyActivitySelection) {
        switch activity {
        case .appsBlocked:
            let store = ManagedSettingsStore.appsBlocked
            store.shield.applications = selection.applicationTokens
            store.shield.webDomains = selection.webDomainTokens
        case .timeLimit:
            break // TODO
        }
    }
}

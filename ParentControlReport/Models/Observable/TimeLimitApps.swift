//
//  TimeLimitApps.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 02.11.2023.
//

import SwiftUI
import FamilyControls
import Combine
import ManagedSettings

final class TimeLimitApps: ObservableObject {
    enum Constants {
        static let activitySelection = "time_limit_apps_activity_selection"
        static let from = "time_limit_apps_from"
        static let to = "time_limit_apps_to"
        static let schedule = "time_limit_apps_schedule"
    }
    
    @Published var activitySelection = FamilyActivitySelection(includeEntireCategory: true)
    @Published var from: Date?
    @Published var to: Date?
    @Published var schedule = WeekSchedule()
    
    private lazy var userDefaults = UserDefaults(suiteName: GlobalDefinitions.groupId)

    private lazy var encoder = PropertyListEncoder()
    private lazy var decoder = PropertyListDecoder()

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.activitySelection = savedSelection() ?? FamilyActivitySelection(includeEntireCategory: true)
        self.from = savedFrom()
        self.to = savedTo()
        self.schedule = savedSchedule() ?? WeekSchedule()
        
        $activitySelection.sink { [weak self] selection in
            self?.saveSelection(selection: selection)
        }
        .store(in: &cancellables)
        
        $from.sink { [weak self] from in
            self?.saveFrom(date: from)
        }
        .store(in: &cancellables)
        
        $to.sink { [weak self] to in
            self?.saveTo(date: to)
        }
        .store(in: &cancellables)
        
        $schedule.sink { [weak self] schedule in
            self?.save(schedule: schedule)
        }
        .store(in: &cancellables)
    }
}

// MARK: Public
extension TimeLimitApps {
    var isEnable: Bool {
        !applicationsTokens.isEmpty
        && (from != nil)
        && (to != nil)
        && schedule.isSelected
    }
    
    var applicationsTokens: [ApplicationToken] {
        var result = [ApplicationToken]()
        activitySelection.applicationTokens.forEach { result.append($0) }
        return result
    }
}

// MARK: Private
private extension TimeLimitApps {
    func saveSelection(selection: FamilyActivitySelection) {
        userDefaults?.set(try? encoder.encode(selection), forKey: Constants.activitySelection)
    }

    func savedSelection() -> FamilyActivitySelection? {
        guard let data = userDefaults?.data(forKey: Constants.activitySelection) else {
            return nil
        }

        return try? decoder.decode(FamilyActivitySelection.self, from: data)
    }
    
    func saveFrom(date: Date?) {
        userDefaults?.set(date, forKey: Constants.from)
    }
    
    func savedFrom() -> Date? {
        userDefaults?.value(forKey: Constants.from) as? Date
    }
    
    func saveTo(date: Date?) {
        userDefaults?.set(date, forKey: Constants.to)
    }
    
    func savedTo() -> Date? {
        userDefaults?.value(forKey: Constants.to) as? Date
    }
    
    func save(schedule: WeekSchedule) {
        userDefaults?.set(try? encoder.encode(schedule), forKey: Constants.schedule)
    }
    
    func savedSchedule() -> WeekSchedule? {
        guard let data = userDefaults?.data(forKey: Constants.schedule) else {
            return nil
        }
        
        return try? decoder.decode(WeekSchedule.self, from: data)
    }
}

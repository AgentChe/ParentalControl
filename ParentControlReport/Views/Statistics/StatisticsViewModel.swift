//
//  StatisticsViewModel.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import SwiftUI
import DeviceActivity
import ManagedSettings

final class StatisticsViewModel: ObservableObject {
    @Published var period = PeriodSegmentView.Period.week
    
    private let daysActivities: [DayActivity]
    
    init(daysActivities: [DayActivity]) {
        self.daysActivities = daysActivities
    }
}

// MARK: Public
extension StatisticsViewModel {
    var elements: [StatisticsListElement] {
        var elements = [StatisticsListElement]()
        
        let calendar = Calendar.current
        let currentDay = calendar.startOfDay(for: Date())
        let days = daysActivities.filter { day -> Bool in
            switch period {
            case .today:
                return calendar.startOfDay(for: day.day) == currentDay
            case .week:
                guard let startDate = calendar.date(byAdding: .day, value: -7, to: currentDay) else {
                    return false
                }

                return calendar.startOfDay(for: day.day) >= startDate
            case .month:
                return true
            }
        }
        
        var totalActivityDuration: TimeInterval = 0
        
        var appsActivities = [ApplicationToken: (ActivityCategory, ActivityApplication, TimeInterval)]()
        days.forEach { day in
            day.categories.forEach { category in
                category.applications.forEach { application in
                    let appsActivity = appsActivities[application.token]
                    
                    appsActivities[application.token] = (
                        appsActivity?.0 ?? category,
                        appsActivity?.1 ?? application,
                        (appsActivity?.2 ?? 0) + application.totalActivityDuration
                    )
                    
                    totalActivityDuration += application.totalActivityDuration
                }
            }
        }
        
        appsActivities
            .sorted(by: { lhs, rhs -> Bool in
                lhs.value.1.name < rhs.value.1.name
            })
            .forEach { key, value in
                var score: Float {
                    guard totalActivityDuration != 0 else {
                        return 0
                    }
                    
                    return Float(value.2 / totalActivityDuration)
                }
                
                let element = ApplicationElement(
                    application: value.1,
                    category: value.0.name,
                    activityDuration: value.2,
                    activityScore: score
                )
                elements.append(.application(element))
            }
        
        return elements
    }
}

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
    
    private let statistics: Statistics
    
    init(statistics: Statistics) {
        self.statistics = statistics
    }
}

// MARK: Public
extension StatisticsViewModel {
    var elements: [StatisticsListElement] {
        var elements = [StatisticsListElement]()
        
        var appsActivities = [ApplicationToken: (ActivityCategory, ActivityApplication, TimeInterval)]()
        statistics.days.forEach { day in
            day.categories.forEach { category in
                category.applications.forEach { application in
                    let appsActivity = appsActivities[application.token]
                    
                    appsActivities[application.token] = (
                        appsActivity?.0 ?? category,
                        appsActivity?.1 ?? application,
                        (appsActivity?.2 ?? 0) + application.totalActivityDuration
                    )
                }
            }
        }
        
        appsActivities
            .sorted(by: { lhs, rhs -> Bool in
                lhs.value.1.name < rhs.value.1.name
            })
            .forEach { key, value in
                var score: Float {
                    guard statistics.totalActivityDuration != 0 else {
                        return 0
                    }
                    
                    return Float(value.2 / statistics.totalActivityDuration)
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

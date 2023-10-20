//
//  StatisticsListElement.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import Foundation

enum StatisticsListElement: Hashable {
    case chart(ChartActivityElement)
    case application(ApplicationElement)
}

struct ChartActivityElement: Hashable {
    let period: PeriodSegmentView.Period
    let daysActivities: [DayActivity]
}

struct ApplicationElement: Hashable {
    let application: ActivityApplication
    let category: String
    let activityDuration: TimeInterval
    let activityScore: Float
}

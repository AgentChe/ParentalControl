//
//  MainViewModel.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 13.10.2023.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var elements: [MainElement] = []
    
    @State var timeLimitEnable: TimeLimitEnableObject
    @State var timeLimitTime: TimeObject
    @State var timeLimitSchedule: ScheduleObject
    
    private let bundle: MainBundle
    private let downtimes: [Downtime]
    
    init(bundle: MainBundle) {
        self.bundle = bundle
        
        let timeLimit = ContentService.shared.timeLimit()
        timeLimitEnable = TimeLimitEnableObject(enable: timeLimit?.enable ?? false)
        timeLimitTime = TimeObject(
            hour: (timeLimit?.minutes ?? 0) / 60,
            minute: (timeLimit?.minutes ?? 0) % 60
        )
        timeLimitSchedule = ScheduleObject(schedule: timeLimit?.schedule)
        
        downtimes = ContentService.shared.downtimes()
        
        makeElements()
    }
    
    func makeElements() {
        var result = [MainElement]()

        if timeLimitEnable.enable {
            let element = TimeLimitElement(
                totalActivityDuration: bundle.totalActivityDuration,
                timeLimit: timeLimitTime.totalMinutes
            )
            result.append(.timeLimit(element))
        } else {
            let element = SetTimeLimitElement(totalActivityDuration: bundle.totalActivityDuration)
            result.append(.setTimeLimit(element))
        }
        
        result.append(.downtimes)
        
        downtimes.forEach { downtime in
            result.append(.downtime(downtime))
        }

        elements = result
    }
}

enum MainElement: Identifiable {
    case setTimeLimit(SetTimeLimitElement)
    case timeLimit(TimeLimitElement)
    case downtimes
    case downtime(Downtime)
    
    var id: String {
        switch self {
        case .setTimeLimit(let element):
            return element.id
        case .timeLimit(let element):
            return element.id
        case .downtimes:
            return "downtimes"
        case .downtime(let downtime):
            return downtime.id
        }
    }
}

struct SetTimeLimitElement: Identifiable {
    let id: String = UUID().uuidString
    let totalActivityDuration: TimeInterval
}

struct TimeLimitElement: Identifiable {
    let id: String = UUID().uuidString
    let totalActivityDuration: TimeInterval
    let timeLimit: Int
}

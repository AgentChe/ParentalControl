//
//  MainViewModel.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 13.10.2023.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var elements = [MainListElement]()
    
    @State var timeLimitEnable: TimeLimitEnableObject
    @State var timeLimitTime: TimeObject
    @State var timeLimitSchedule: ScheduleObject
    
    private let bundle: MainBundle
    
    init(bundle: MainBundle) {
        self.bundle = bundle
        
        let timeLimit = ContentService.shared.timeLimit()
        timeLimitEnable = TimeLimitEnableObject(enable: timeLimit?.enable ?? false)
        timeLimitTime = TimeObject(
            hour: (timeLimit?.minutes ?? 0) / 60,
            minute: (timeLimit?.minutes ?? 0) % 60
        )
        timeLimitSchedule = ScheduleObject(schedule: timeLimit?.schedule)
        
        createElements()
    }
    
    private func createElements() {
        var result = [MainListElement]()

        if timeLimitEnable.enable {
            let value = MainListValue.timeLimit(
                totalActivityDuration: bundle.totalActivityDuration,
                timeLimit: timeLimitTime.totalMinutes
            )
            let element = MainListElement(value: value)
            result.append(element)
        } else {
            let value = MainListValue.setTimeLimit(bundle.totalActivityDuration)
            let element = MainListElement(value: value)
            result.append(element)
        }

        elements = result
    }
}

final class MainListElement: Identifiable, ObservableObject {
    let id = UUID().uuidString
    @Published var value: MainListValue
    
    init(value: MainListValue) {
        self.value = value
    }
}

enum MainListValue {
    case setTimeLimit(TimeInterval)
    case timeLimit(totalActivityDuration: TimeInterval, timeLimit: Int)
}

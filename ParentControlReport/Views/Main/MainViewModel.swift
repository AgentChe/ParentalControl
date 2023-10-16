//
//  MainViewModel.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 13.10.2023.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var elements = [MainListElement]()
    
    private let bundle: MainBundle
    
    init(bundle: MainBundle) {
        self.bundle = bundle
        
        createElements()
    }
    
    func update(timeLimit: TimeLimit) {
        createElements(timeLimit: timeLimit)
    }
    
    private func createElements(timeLimit: TimeLimit? = ContentService.shared.timeLimit()) {
        var result = [MainListElement]()

        if let timeLimit, timeLimit.enable {
            let value = MainListValue.timeLimit(
                totalActivityDuration: bundle.totalActivityDuration,
                timeLimit: timeLimit.minutes
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

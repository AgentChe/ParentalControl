//
//  MainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import SwiftUI

private struct MainListElement: Identifiable {
    let id = UUID().uuidString
    let value: MainListValue
}

private enum MainListValue {
    case setTimeLimit(TimeInterval)
    case timeLimit(totalActivityDuration: TimeInterval, timeLimit: Int)
}

struct MainView: View {
    let bundle: MainBundle
    
    @State private var elements: [MainListElement] = []
    
    init(bundle: MainBundle) {
        self.bundle = bundle
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(elements) { element in
                    switch element.value {
                    case .setTimeLimit(let totalActivityDuration):
                        SetTimeLimitCell(totalActivity: totalActivityDuration)
                    case .timeLimit(let totalActivityDuration, let timeLimit):
                        TimeLimitCell(totalActivity: totalActivityDuration, timeLimit: timeLimit)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            var result = [MainListElement]()
            
            if let timeLimit = ContentService.shared.timeLimit() {
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
}

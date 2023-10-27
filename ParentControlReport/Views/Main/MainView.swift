//
//  MainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import SwiftUI

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

struct MainView: View {
    @State private var timeLimitViewPresenting = false
    @State private var downtimesPresenting = false
    @State private var editDowntime: Downtime?
    
    @State private var timeLimitEnable: TimeLimitEnableObject
    @State private var timeLimitTime: TimeObject
    @State private var timeLimitSchedule: WeekSchedule
    
    @StateObject private var downtimes = Downtimes()
    
    private let bundle: MainBundle
    
    init(bundle: MainBundle) {
        self.bundle = bundle
        
        let timeLimit = ContentService.shared.timeLimit()
        timeLimitEnable = TimeLimitEnableObject(enable: timeLimit?.enable ?? false)
        timeLimitTime = TimeObject(
            hour: (timeLimit?.minutes ?? 0) / 60,
            minute: (timeLimit?.minutes ?? 0) % 60
        )
        timeLimitSchedule = timeLimit?.schedule ?? WeekSchedule()
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(elements) { element in
                    switch element {
                    case .setTimeLimit(let object):
                        SetTimeLimitCell(totalActivity: object.totalActivityDuration)
                            .sheet(isPresented: $timeLimitViewPresenting) {
                                TimeLimitView(
                                    isPresented: $timeLimitViewPresenting,
                                    enable: $timeLimitEnable,
                                    schedule: $timeLimitSchedule,
                                    time: $timeLimitTime
                                )
                            }
                            .onTapGesture {
                                timeLimitViewPresenting.toggle()
                            }
                    case .timeLimit(let object):
                        TimeLimitCell(
                            totalActivity: object.totalActivityDuration,
                            timeLimit: object.timeLimit
                        )
                        .sheet(isPresented: $timeLimitViewPresenting) {
                            TimeLimitView(
                                isPresented: $timeLimitViewPresenting,
                                enable: $timeLimitEnable,
                                schedule: $timeLimitSchedule,
                                time: $timeLimitTime
                            )
                        }
                        .onTapGesture {
                            timeLimitViewPresenting.toggle()
                        }
                    case .downtimes:
                        DowntimesMainCell()
                            .sheet(isPresented: $downtimesPresenting) {
                                DowntimesView()
                            }
                            .onTapGesture {
                                downtimesPresenting.toggle()
                            }
                            .environmentObject(downtimes)
                    case .downtime(let downtime):
                        DowntimeCell(downtime: downtime, didSelect: { selected in
                            editDowntime = selected
                        }, didChange: { changed in
                            downtimes.set(downtime: changed)
                        })
                        .sheet(item: $editDowntime) { downtime in
                            EditDowntimeView(downtime: downtime)
                        }
                        .environmentObject(downtimes)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

// MARK: Private
private extension MainView {
    var elements: [MainElement] {
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
        
        downtimes.downtimes.forEach { downtime in
            result.append(.downtime(downtime))
        }

        return result
    }
}

//
//  MainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import SwiftUI
import ManagedSettings

enum MainElement: Identifiable {
    case setTimeLimit(SetTimeLimitElement)
    case timeLimit(TimeLimitElement)
    case downtimes
    case downtime(Downtime)
    case title(String)
    case instantBlock
    case recentActivitySeeMore
    case emptyRecentActivity
    case application(ApplicationElement)
    case webHistorySeeMore
    case emptyWebHistory
    case webHistory(WebHistoryItem)
    
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
        case .title(let title):
            return title
        case .instantBlock:
            return "instant_block"
        case .recentActivitySeeMore:
            return "recent_activity_see_more"
        case .emptyRecentActivity:
            return "empty_recent_activity"
        case .application(let element):
            return element.id
        case .webHistorySeeMore:
            return "web_history_see_more"
        case .emptyWebHistory:
            return "empty_web_history"
        case .webHistory(let item):
            return item.id
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
    @State private var webHistoryPresented = false
    
    @State private var timeLimitEnable: TimeLimitEnableObject
    @State private var timeLimitTime: TimeObject
    @State private var timeLimitSchedule: WeekSchedule
    
    @StateObject private var downtimes = Downtimes()
    @ObservedObject private var daysActivities: DaysActivities
    
    init(daysActivities: DaysActivities) {
        self.daysActivities = daysActivities
        
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
                    case .title(let title):
                        TitleCell(title: title)
                    case .instantBlock:
                        InstantBlockCell()
                    case .recentActivitySeeMore:
                        SeeMoreCell(element: .recentActivity)
                    case .emptyRecentActivity:
                        RecentActivityEmpty()
                    case .application(let element):
                        ApplicationCell(element: element)
                    case .webHistorySeeMore:
                        SeeMoreCell(element: .webHistory)
                            .sheet(isPresented: $webHistoryPresented) {
                                WebHistoryView()
                                    .environmentObject(daysActivities)
                            }
                            .onTapGesture {
                                webHistoryPresented = true
                            }
                    case .emptyWebHistory:
                        WebHistoryEmptyView()
                    case .webHistory(let item):
                        WebDomainView(item: item)
                            .listRowInsets(EdgeInsets(
                                top: 8.scale,
                                leading: 16.scale,
                                bottom: 8.scale,
                                trailing: 16.scale
                            ))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
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
                totalActivityDuration: totalActivityDurationOnToday(),
                timeLimit: timeLimitTime.totalMinutes
            )
            result.append(.timeLimit(element))
        } else {
            let element = SetTimeLimitElement(totalActivityDuration: totalActivityDurationOnToday())
            result.append(.setTimeLimit(element))
        }
        
        result.append(.downtimes)
        
        downtimes.downtimes.forEach { downtime in
            result.append(.downtime(downtime))
        }
        
        result.append(.title("Downtime.Apps".localized))
        result.append(.instantBlock)
        
        result.append(contentsOf: applicationsElements())
        
        result.append(contentsOf: webHistoryElements())

        return result
    }
    
    func totalActivityDurationOnToday() -> TimeInterval {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        guard let todayActivity = daysActivities.days.first(where: { calendar.startOfDay(for: $0.day) == today }) else {
            return 0
        }
        
        var totalActivityDuration = TimeInterval(0)
        
        todayActivity.categories.forEach { category in
            totalActivityDuration += category.totalActivityDuration
        }
        
        return totalActivityDuration
    }
    
    func applicationsElements() -> [MainElement] {
        var result = [ApplicationElement]()
        
        var totalActivityDuration: TimeInterval = 0
        
        var appsActivities = [ApplicationToken: (ActivityCategory, ActivityApplication, TimeInterval)]()
        daysActivities.days.forEach { day in
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
                result.append(element)
            }
        
        var elements = [MainElement.recentActivitySeeMore]
        
        if result.isEmpty {
            elements.append(.emptyRecentActivity)
        } else {
            for item in Array(result.prefix(3)) {
                elements.append(.application(item))
            }
        }
        
        return elements
    }
    
    func webHistoryElements() -> [MainElement] {
        var result = [WebHistoryItem]()
        
        daysActivities.days.forEach { day in
            day.categories.forEach { category in
                category.webHistory.forEach { item in
                    if let index = result.firstIndex(where: {
                        $0.domain.token == item.domain.token
                    }) {
                        result[index].totalActivityDuration += item.totalActivityDuration
                    } else {
                        result.append(item)
                    }
                }
            }
        }
        
        var elements = [MainElement.webHistorySeeMore]
        
        if result.isEmpty {
            elements.append(.emptyWebHistory)
        } else {
            for item in Array(result.prefix(3)) {
                elements.append(.webHistory(item))
            }
        }
        
        return elements
    }
}

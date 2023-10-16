//
//  TimeLimitView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import SwiftUI

struct TimeLimitView: View {
    @Binding var isPresented: Bool
    @Binding var enable: TimeLimitEnableObject
    @Binding var schedule: ScheduleObject
    @Binding var time: TimeObject
    
    @State private var elements = [TimeLimitListElement]()
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                Text("TimeLimit.Title".localized)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.medium(size: 20.scale)))
                    .padding(.top, 16.scale)
                
                List {
                    ForEach(elements) { element in
                        switch element.value {
                        case .enable:
                            TimeLimitEnableCell(enable: enable)
                        case .schedule:
                            TimeLimitWeekdaysCell(schedule: schedule)
                        case .selectTime:
                            SelectTimeCell(timeObject: time)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.top, 8.scale)
                
                Spacer()
                
                Button(action: {
                    let updated = TimeLimit(
                        minutes: time.totalMinutes,
                        schedule: schedule.schedule,
                        enable: enable.enable
                    )
                    
                    ContentService.shared.store(timeLimit: updated)
                    
                    isPresented = false
                }, label: {
                    Text("TimeLimit.Save".localized)
                        .padding(EdgeInsets(
                            top: 12.scale,
                            leading: 90.scale,
                            bottom: 12.scale,
                            trailing: 90.scale
                        ))
                        .background(Color(Appearance.primary))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                .padding(.bottom, 16.scale)
            }
        }
        .onAppear {
            var result = [TimeLimitListElement]()
            
            let enableElement = TimeLimitListElement(value: .enable)
            result.append(enableElement)
            
            let scheduleElement = TimeLimitListElement(value: .schedule)
            result.append(scheduleElement)
            
            let selectTimeElement = TimeLimitListElement(value: .selectTime)
            result.append(selectTimeElement)
            
            elements = result
        }
    }
}

private struct TimeLimitListElement: Identifiable {
    let id = UUID().uuidString
    let value: TimeLimitListValue
}

private enum TimeLimitListValue {
    case enable
    case schedule
    case selectTime
}

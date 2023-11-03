//
//  SetAppsTimeLimit.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 02.11.2023.
//

import SwiftUI
import FamilyControls

struct SetAppsTimeLimit: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var timeLimitApps: TimeLimitApps
    
    @StateObject private var localTimeLimit: TimeLimitApps
    @StateObject private var time: DowntimeTimeView.Time
    
    @State private var familyPickerPresented = false
    
    init() {
        let timeLimit = TimeLimitApps()
        self._localTimeLimit = StateObject(wrappedValue: timeLimit)
        self._time = StateObject(wrappedValue: DowntimeTimeView.Time(
            from: timeLimit.from,
            to: timeLimit.to)
        )
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                Text("TimeLimit.Title".localized)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.medium(size: 20.scale)))
                    .padding(.top, 16.scale)
                
                ScrollView {
                    TimeLimitAppsView(rule: .empty)
                        .frame(width: 359.scale, height: localTimeLimit.isEnable ? 102.scale : 84.scale)
                        .padding(.top, 16.scale)
                        .environmentObject(localTimeLimit)
                        .familyActivityPicker(
                            isPresented: $familyPickerPresented,
                            selection: $localTimeLimit.activitySelection
                        )
                        .onTapGesture {
                            familyPickerPresented = true
                        }
                    
                    DowntimeTimeView()
                        .environmentObject(time)
                        .padding(EdgeInsets(t: 8.scale, l: 8.scale, tr: 8.scale))
                    
                    TimeLimitWeekdaysCell(schedule: localTimeLimit.schedule)
                }
                .padding(.top, 8.scale)
                
                Spacer()
                
                Button(action: {
                    save()
                }, label: {
                    Text("TimeLimit.Save".localized)
                        .padding([.leading, .trailing], 90.scale)
                        .padding([.top, .bottom], 12.scale)
                        .background(Color(Appearance.primary))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                .padding(.bottom, 32.scale)
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: Private
private extension SetAppsTimeLimit {
    func save() {
        timeLimitApps.activitySelection = localTimeLimit.activitySelection
        timeLimitApps.from = time.from
        timeLimitApps.to = time.to
        timeLimitApps.schedule = localTimeLimit.schedule
        
        MonitoringService.shared.monitoring(timeLimitApps: timeLimitApps)
        
        dismiss()
    }
}

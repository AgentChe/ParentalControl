//
//  AddDowntime.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 27.10.2023.
//

import SwiftUI

struct AddDowntime: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var downtimes: Downtimes
    
    @State private var name: String = ""
    @StateObject private var time = DowntimeTimeView.Time()
    @StateObject private var schedule = WeekSchedule()
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                ScrollView {
                    DowntimeName(name: $name)
                    
                    DowntimeTimeView()
                        .padding(EdgeInsets(t: 24.scale, l: 8.scale, tr: 8.scale))
                        .environmentObject(time)
                    
                    DowntimeScheduleView()
                        .environmentObject(schedule)
                }
                
                Button(action: {
                    save()
                }, label: {
                    Text("Downtime.Save".localized)
                        .padding(.top, 12.scale)
                        .padding(.bottom, 12.scale)
                        .frame(width: 210.scale)
                        .background(Color(Appearance.primary.withAlphaComponent(disableSave ? 0.4 : 1)))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(disableSave ? 0.4 : 1)))
                        .cornerRadius(20.scale)
                })
                .disabled(disableSave)
            }
        }
    }
}

// MARK: Private
private extension AddDowntime {
    func save() {
        let downtime = Downtime(
            name: name,
            from: time.from,
            to: time.to,
            schedule: schedule
        )
        downtimes.set(downtime: downtime)
        
        dismiss()
    }
    
    var disableSave: Bool {
        name.isEmpty
        || (time.from == nil)
        || (time.to == nil)
        || ((time.to ?? Date()) <= (time.from ?? Date()))
        || !schedule.isSelected
    }
}

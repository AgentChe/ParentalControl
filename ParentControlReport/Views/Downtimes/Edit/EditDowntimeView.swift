//
//  EditDowntimeView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct EditDowntimeView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var downtimes: Downtimes
    
    @State private var enable: Bool
    @StateObject private var time: DowntimeTimeView.Time
    @StateObject private var schedule: WeekSchedule
    
    @State private var isConfirmRemovePresented = false
    
    private let downtime: Downtime
    
    init(downtime: Downtime) {
        self._enable = State(initialValue: downtime.enable)
        self._time = StateObject(wrappedValue: DowntimeTimeView.Time(
            from: downtime.from,
            to: downtime.to)
        )
        if let schedule = downtime.schedule {
            self._schedule = StateObject(wrappedValue: schedule)
        } else {
            self._schedule = StateObject(wrappedValue: WeekSchedule())
        }
        self.downtime = downtime
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                ScrollView {
                    DowntimeEnableView(
                        enable: $enable,
                        name: downtime.name
                    )
                    
                    DowntimeTimeView()
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
                
                Button(action: {
                    isConfirmRemovePresented.toggle()
                }, label: {
                    Text("Downtime.Remove".localized)
                        .padding(.top, 12.scale)
                        .padding(.bottom, 12.scale)
                        .frame(width: 210.scale)
                        .background(Color(Appearance.background2))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                .sheet(isPresented: $isConfirmRemovePresented) {
                    ConfirmAlert(
                        title: "Downtime.Remove.Confirm.Title".localized,
                        subTitle: "Downtime.Remove.Confirm.SubTitle".localized,
                        confirmTitle: "Downtime.Remove.Confirm.Remove".localized,
                        cancelTitle: "Downtime.Remove.Confirm.Cancel".localized,
                        isPresented: $isConfirmRemovePresented,
                        confirmAction: {
                            downtimes.remove(downtimeId: downtime.id)
                            dismiss()
                        }
                    )
                    .presentationDetents([.height(292.scale)])
                }
            }
        }
    }
}

// MARK: Private
private extension EditDowntimeView {
    func save() {
        downtime.enable = enable
        downtime.from = time.from
        downtime.to = time.to
        downtime.schedule = schedule
        downtimes.set(downtime: downtime)
        
        dismiss()
    }
    
    var disableSave: Bool {
        (time.from == nil)
        || (time.to == nil)
        || ((time.to ?? Date()) <= (time.from ?? Date()))
        || !schedule.isSelected
    }
}

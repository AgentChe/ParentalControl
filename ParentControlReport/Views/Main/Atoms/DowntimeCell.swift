//
//  DowntimeCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct DowntimeCell: View {
    let downtime: Downtime
    @State var enable: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.background2))
            
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.white))
                .padding(EdgeInsets(
                    top: 3.scale,
                    leading: 3.scale,
                    bottom: 6.scale,
                    trailing: 3.scale
                ))
            
            if enable {
                enableView
            } else {
                disableView
            }
        }
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 16.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}

// MARK: Private
private extension DowntimeCell {
    var disableView: some View {
        HStack {
            VStack {
                Text(downtime.name)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Downtime.NotSet".localized)
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Toggle(isOn: $enable) {}
                .tint(Color(Appearance.secondary))
        }
        .padding(16.scale)
    }
    
    var enableView: some View {
        VStack {
            HStack {
                VStack {
                    Text(downtime.name)
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let from = downtime.from?.time, let to = downtime.to?.time {
                        Text(String(format: "Downtime.FromTo".localized, from, to))
                            .foregroundColor(Color(Appearance.secondary))
                            .font(Font(Fonts.Satoshi.medium(size: 20.scale)))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Spacer()
                
                Toggle(isOn: $enable) {}
                    .tint(Color(Appearance.secondary))
            }
            
            if let schedule = downtime.schedule {
                HStack(spacing: 4.scale) {
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.Su".localized,
                        marked: schedule.su
                    )
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.Mo".localized,
                        marked: schedule.mo
                    )
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.Tu".localized,
                        marked: schedule.tu
                    )
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.We".localized,
                        marked: schedule.we
                    )
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.Th".localized,
                        marked: schedule.th
                    )
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.Fr".localized,
                        marked: schedule.fr
                    )
                    WeekdayReadOnlyView(
                        title: "Onboarding.Weekday.Sa".localized,
                        marked: schedule.sa
                    )
                }
            }
        }
        .padding(16.scale)
    }
}

// MARK: Additional
private extension Date {
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM"
        return formatter.string(from: self)
    }
}

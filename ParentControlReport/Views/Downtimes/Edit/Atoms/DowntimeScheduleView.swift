//
//  DowntimeScheduleView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 25.10.2023.
//

import SwiftUI

struct DowntimeScheduleView: View {
    @EnvironmentObject private var schedule: WeekSchedule
    
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
            
            VStack {
                HStack {
                    Text("Downtime.Weekdays".localized)
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack(spacing: 4.scale) {
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.Su".localized,
                        marked: $schedule.su
                    )
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.Mo".localized,
                        marked: $schedule.mo
                    )
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.Tu".localized,
                        marked: $schedule.tu
                    )
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.We".localized,
                        marked: $schedule.we
                    )
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.Th".localized,
                        marked: $schedule.th
                    )
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.Fr".localized,
                        marked: $schedule.fr
                    )
                    WeekdayButtonSUI(
                        title: "Onboarding.Weekday.Sa".localized,
                        marked: $schedule.sa
                    )
                }
            }
            .padding(16.scale)
        }
        .padding(EdgeInsets(
            top: 24.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}


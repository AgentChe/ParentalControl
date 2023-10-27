//
//  TimeLimitWeekdaysCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import SwiftUI

struct TimeLimitWeekdaysCell: View {
    @ObservedObject var schedule: WeekSchedule
    
    var body: some View {
        ZStack {
            Color(Appearance.background2)
                .cornerRadius(20.scale)
            
            ZStack {
                Color(Appearance.white)
                    .cornerRadius(20.scale)
                
                VStack {
                    HStack {
                        Text("TimeLimit.Weekdays".localized)
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black))
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(
                        top: 16.scale,
                        leading: 16.scale,
                        bottom: 0,
                        trailing: 16.scale
                    ))
                    
                    HStack(spacing: 4.scale) {
                        WeekdayButton(
                            title: "Onboarding.Weekday.Su".localized,
                            marked: $schedule.su
                        )
                        WeekdayButton(
                            title: "Onboarding.Weekday.Mo".localized,
                            marked: $schedule.mo
                        )
                        WeekdayButton(
                            title: "Onboarding.Weekday.Tu".localized,
                            marked: $schedule.tu
                        )
                        WeekdayButton(
                            title: "Onboarding.Weekday.We".localized,
                            marked: $schedule.we
                        )
                        WeekdayButton(
                            title: "Onboarding.Weekday.Th".localized,
                            marked: $schedule.th
                        )
                        WeekdayButton(
                            title: "Onboarding.Weekday.Fr".localized,
                            marked: $schedule.fr
                        )
                        WeekdayButton(
                            title: "Onboarding.Weekday.Sa".localized,
                            marked: $schedule.sa
                        )
                    }
                    .padding(16.scale)
                }
            }
            .padding(EdgeInsets(
                top: 3.scale,
                leading: 3.scale,
                bottom: 9.scale,
                trailing: 3.scale
            ))
        }
        .padding(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
}

//
//  PeriodSegmentView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import SwiftUI

struct PeriodSegmentView: View {
    enum Period: CaseIterable {
        case today, week, month
        
        var title: String {
            switch self {
            case .today:
                return "Statistics.Filter.Today".localized
            case .week:
                return "Statistics.Filter.Week".localized
            case .month:
                return "Statistics.Filter.1M".localized
            }
        }
    }
    
    @Binding var period: Period
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.white))
            
            HStack {
                SegmentButton(
                    period: .today,
                    selectedPeriod: {
                        period
                    },
                    action: {
                        period = .today
                    }
                )

                SegmentButton(
                    period: .week,
                    selectedPeriod: {
                        period
                    },
                    action: {
                        period = .week
                    }
                )

                SegmentButton(
                    period: .month,
                    selectedPeriod: {
                        period
                    },
                    action: {
                        period = .month
                    }
                )
            }
        }
    }
}

// MARK: Private
private struct SegmentButton: View {
    let period: PeriodSegmentView.Period
    let selectedPeriod: () -> PeriodSegmentView.Period
    let action: () -> Void
    
    var body: some View {
        if selectedPeriod() == period {
            ZStack {
                RoundedRectangle(cornerRadius: 20.scale)
                    .foregroundColor(Color(Appearance.secondary))
                    .padding(2.scale)
                
                Button(action: {
                    action()
                }, label: {
                    Text(period.title)
                        .foregroundColor(Color(Appearance.white))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        } else {
            Button(action: {
                action()
            }, label: {
                Text(period.title)
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.4)))
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
            })
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

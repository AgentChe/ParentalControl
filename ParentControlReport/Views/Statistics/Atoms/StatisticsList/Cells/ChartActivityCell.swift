//
//  ChartActivityCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import SwiftUI

struct ChartActivityCell: View {
    let element: ChartActivityElement
    
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
            
            VStack(alignment: .leading) {
                Text(element.totalActivityDuration.formatted)
                    .font(Font(Fonts.Satoshi.medium(size: 32.scale)))
                    .foregroundColor(Color(Appearance.black))
                
                Text(element.period.long)
                    .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.4)))
                
                ActivityCategoriesChart(element: element)
                    .frame(height: 155.scale)
                    .background(Color.clear)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(element.categories, id: \.self) {
                            ActivityCategoryCell(element: $0)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16.scale)
        }
        .listRowInsets(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 16.scale,
            trailing: 8.scale
        ))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

// MARK: Additional
private extension ChartActivityElement {
    var totalActivityDuration: TimeInterval {
        daysActivities
            .map { dayActivity -> TimeInterval in
                dayActivity.categories
                    .reduce(0) { $0 + $1.totalActivityDuration }
            }
            .reduce(0) { $0 + $1 }
    }
}

// MARK: Additional
private extension TimeInterval {
    var formatted: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter.string(from: self) ?? ""
    }
}

// MARK: Additional
private extension PeriodSegmentView.Period {
    var long: String {
        switch self {
        case .today:
            return "Statistics.Filter.Today".localized
        case .week:
            return "Statistics.Filter.Week".localized
        case .month:
            return "Statistics.Filter.1M.Long".localized
        }
    }
}


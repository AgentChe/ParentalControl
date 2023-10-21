//
//  ActivityCategoriesChart.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 21.10.2023.
//

import SwiftUI
import Charts
import ManagedSettings

struct ItemPlottable: Plottable {
    typealias PrimitivePlottable = String
    
    var primitivePlottable: String
    
    init?(primitivePlottable: String) {
        self.primitivePlottable = primitivePlottable
    }
}

struct ChartItem {
    let date: String
    let plottable: ItemPlottable
    let duration: TimeInterval
}

struct ActivityCategoriesChart: View {
    private var items = [ChartItem]()
    private var colors = [String: Color]()
    
    init(element: ChartActivityElement) {
        element.categories.forEach {
            colors[$0.name] = $0.color
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        element.daysActivities.forEach { dayActivity in
            let date = formatter.string(from: dayActivity.day)
            
            dayActivity.categories.forEach { category in
                let item = ChartItem(
                    date: date,
                    plottable: ItemPlottable(primitivePlottable: category.name)!,
                    duration: category.totalActivityDuration
                )
                items.append(item)
            }
        }
    }
    
    var body: some View {
        Chart {
            ForEach(items, id: \.date) { item in
                BarMark(
                    x: .value("Date", item.date),
                    y: .value("Duration", item.duration)
                )
                .foregroundStyle(by: .value("Value", item.plottable))
            }
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale { (plottable: ItemPlottable) in
            colors[plottable.primitivePlottable] ?? Color(
                red: Double.random(in: 0...255) / 255,
                green: Double.random(in: 0...255) / 255,
                blue: Double.random(in: 0...255) / 255
            )
        }
    }
}

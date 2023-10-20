//
//  StatisticsList.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import SwiftUI

struct StatisticsList: View {
    let elements: [StatisticsListElement]
    
    var body: some View {
        List {
            ForEach(elements, id: \.self) { element in
                switch element {
                case .chart(let element):
                    ChartActivityCell(element: element)
                case .application(let element):
                    ApplicationCell(element: element)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

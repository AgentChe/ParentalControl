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
                case .application(let element):
                    ApplicationCell(element: element)
                        .listRowInsets(EdgeInsets(
                            top: 8.scale,
                            leading: 8.scale,
                            bottom: 8.scale,
                            trailing: 8.scale
                        ))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

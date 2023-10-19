//
//  StatisticsView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 18.10.2023.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    
    init(statistics: Statistics) {
        viewModel = StatisticsViewModel(statistics: statistics)
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                PeriodSegmentView(period: $viewModel.period)
                    .frame(height: 38.scale)
                    .padding(EdgeInsets(
                        top: 12.scale,
                        leading: 20.scale,
                        bottom: 16.scale,
                        trailing: 20.scale
                    ))
                
                StatisticsList(elements: viewModel.elements)
            }
        }
    }
}

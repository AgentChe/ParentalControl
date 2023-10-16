//
//  MainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import SwiftUI

// TODO:
// 4. Устанавливать ограничения в соответствии с time limit
struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel
    @State private var timeLimitViewPresenting = false
    
    init(bundle: MainBundle) {
        viewModel = MainViewModel(bundle: bundle)
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(viewModel.elements) { element in
                    switch element.value {
                    case .setTimeLimit(let totalActivityDuration):
                        SetTimeLimitCell(totalActivity: totalActivityDuration)
                            .sheet(isPresented: $timeLimitViewPresenting) {
                                TimeLimitView(
                                    isPresented: $timeLimitViewPresenting,
                                    enable: viewModel.$timeLimitEnable,
                                    schedule: viewModel.$timeLimitSchedule,
                                    time: viewModel.$timeLimitTime
                                )
                            }
                            .onTapGesture {
                                timeLimitViewPresenting.toggle()
                            }
                    case .timeLimit(let totalActivityDuration, let timeLimit):
                        TimeLimitCell(totalActivity: totalActivityDuration, timeLimit: timeLimit)
                            .sheet(isPresented: $timeLimitViewPresenting) {
                                TimeLimitView(
                                    isPresented: $timeLimitViewPresenting,
                                    enable: viewModel.$timeLimitEnable,
                                    schedule: viewModel.$timeLimitSchedule,
                                    time: viewModel.$timeLimitTime
                                )
                            }
                            .onTapGesture {
                                timeLimitViewPresenting.toggle()
                            }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

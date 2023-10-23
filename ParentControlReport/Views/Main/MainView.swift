//
//  MainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel
    
    @State private var timeLimitViewPresenting = false
    @State private var downtimesPresenting = false
    @State private var editDowntimePresenting = false
    
    init(bundle: MainBundle) {
        viewModel = MainViewModel(bundle: bundle)
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(viewModel.elements) { element in
                    switch element {
                    case .setTimeLimit(let object):
                        SetTimeLimitCell(totalActivity: object.totalActivityDuration)
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
                    case .timeLimit(let object):
                        TimeLimitCell(
                            totalActivity: object.totalActivityDuration,
                            timeLimit: object.timeLimit
                        )
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
                    case .downtimes:
                        DowntimesMainCell()
                            .sheet(isPresented: $downtimesPresenting) {
                                DowntimesView()
                            }
                            .onTapGesture {
                                downtimesPresenting.toggle()
                            }
                    case .downtime(let downtime):
                        DowntimeCell(downtime: downtime, didSelect: {
                            editDowntimePresenting.toggle()
                        }, didChange: { enable in
                            // TODO
                        })
                        .sheet(isPresented: $editDowntimePresenting) {
                            EditDowntimeView(
                                isPresented: $editDowntimePresenting,
                                downtime: downtime
                            )
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

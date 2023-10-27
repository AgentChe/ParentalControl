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
    @State private var editDowntime: Downtime?
    
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
                            .environmentObject(viewModel.downtimes)
                    case .downtime(let downtime):
                        DowntimeCell(downtime: downtime, didSelect: { selected in
                            editDowntime = selected
                        }, didChange: { changed in
                            viewModel.downtimes.set(downtime: changed)
                        })
                        .sheet(item: $editDowntime) { downtime in
                            EditDowntimeView(downtime: downtime)
                        }
                        .environmentObject(viewModel.downtimes)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

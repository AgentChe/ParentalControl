//
//  DowntimesView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct DowntimesView: View {
    @EnvironmentObject private var downtimes: Downtimes
    
    @State private var editDowntime: Downtime?
    @State private var isAddPresented = false
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                List(downtimes.downtimes, id: \.id) { downtime in
                    DowntimeCell(downtime: downtime, didSelect: { selected in
                        editDowntime = selected
                    }, didChange: { changed in
                        downtimes.set(downtime: changed)
                    })
                    .sheet(item: $editDowntime) { downtime in
                        EditDowntimeView(downtime: downtime)
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: {
                    isAddPresented.toggle()
                }, label: {
                    Text("Downtime.Add")
                        .padding(EdgeInsets(
                            top: 12.scale,
                            leading: 32.scale,
                            bottom: 12.scale,
                            trailing: 32.scale
                        ))
                        .background(Color(Appearance.primary))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                .sheet(isPresented: $isAddPresented) {
                    AddDowntime()
                }
            }
        }
    }
}

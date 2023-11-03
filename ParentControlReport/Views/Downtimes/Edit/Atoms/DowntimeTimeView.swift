//
//  DowntimeTimeView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct DowntimeTimeView: View {
    final class Time: ObservableObject {
        @Published var from: Date?
        @Published var to: Date?
        
        init(from: Date? = nil, to: Date? = nil) {
            self.from = from
            self.to = to
        }
    }
    
    @EnvironmentObject private var time: Time
    
    @State private var isFromSheetPresenting = false
    @State private var isToSheetPresenting = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Downtime.SpecificTime".localized)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
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
                
                VStack {
                    DowntimeTimeButton(
                        title: "Downtime.From".localized,
                        date: $time.from,
                        action: {
                            isFromSheetPresenting.toggle()
                        }
                    )
                    .padding(EdgeInsets(
                        top: 16.scale,
                        leading: 16.scale,
                        bottom: 0,
                        trailing: 16.scale
                    ))
                    .sheet(isPresented: $isFromSheetPresenting) {
                        DateSheet(
                            title: "Downtime.DateSheet.Start.Title".localized,
                            subTitle: "Downtime.DateSheet.Start.SubTitle".localized,
                            time: $time.from,
                            isPresenting: $isFromSheetPresenting
                        )
                        .presentationDetents([.height(400.scale)])
                    }
                    
                    Divider()
                        .foregroundColor(Color(Appearance.background2))
                        .padding(.leading, 16.scale)
                        .padding(.trailing, 3.scale)
                    
                    DowntimeTimeButton(
                        title: "Downtime.To".localized,
                        date: $time.to,
                        action: {
                            isToSheetPresenting.toggle()
                        }
                    )
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 16.scale,
                        bottom: 16.scale,
                        trailing: 16.scale
                    ))
                    .sheet(isPresented: $isToSheetPresenting) {
                        DateSheet(
                            title: "Downtime.DateSheet.End.Title".localized,
                            subTitle: "Downtime.DateSheet.End.SubTitle".localized,
                            time: $time.to,
                            isPresenting: $isToSheetPresenting
                        )
                        .presentationDetents([.height(400.scale)])
                    }
                }
            }
        }
        .background(Color(Appearance.background))
    }
}

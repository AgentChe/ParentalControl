//
//  SelectTimeCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import SwiftUI

final class TimeObject: ObservableObject {
    @Published fileprivate var hour: Int
    @Published fileprivate var minute: Int
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    var totalMinutes: Int {
        (hour * 60) + minute
    }
}

struct SelectTimeCell: View {
    @ObservedObject var timeObject: TimeObject
    
    @State private var opened = false
    
    var body: some View {
        opened ? AnyView(openedView) : AnyView(closedView)
    }
}

// MARK: Private
private extension SelectTimeCell {
    var closedView: some View {
        ZStack {
            Color(Appearance.background2)
                .cornerRadius(20.scale)
            
            ZStack {
                Color(Appearance.white)
                    .cornerRadius(20.scale)
                
                HStack {
                    Text("TimeLimit.TimeLimit".localized)
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                    
                    Spacer()
                    
                    Text(timeObject.formattedTime)
                        .padding(EdgeInsets(
                            top: 12.scale,
                            leading: 32.scale,
                            bottom: 12.scale,
                            trailing: 32.scale
                        ))
                        .background(Color(Appearance.background2))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                        .onTapGesture {
                            opened.toggle()
                        }
                }
                .padding(16.scale)
            }
            .padding(EdgeInsets(
                top: 3.scale,
                leading: 3.scale,
                bottom: 9.scale,
                trailing: 3.scale
            ))
        }
        .padding(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
    
    var openedView: some View {
        ZStack {
            Color(Appearance.background2)
                .cornerRadius(20.scale)
            
            ZStack {
                Color(Appearance.white)
                    .cornerRadius(20.scale)
                
                VStack {
                    HStack {
                        Text("TimeLimit.TimeLimit".localized)
                            .foregroundColor(Color(Appearance.black))
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        
                        Spacer()
                        
                        Text(timeObject.formattedTime)
                            .padding(EdgeInsets(
                                top: 12.scale,
                                leading: 32.scale,
                                bottom: 12.scale,
                                trailing: 32.scale
                            ))
                            .background(Color(Appearance.background2))
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black))
                            .cornerRadius(20.scale)
                            .onTapGesture {
                                opened.toggle()
                            }
                    }
                    .padding(16.scale)
                    
                    TimePickerView(
                        selectedHour: $timeObject.hour,
                        selectedMinute: $timeObject.minute
                    )
                    .padding(.bottom, 16.scale)
                }
            }
            .padding(EdgeInsets(
                top: 3.scale,
                leading: 3.scale,
                bottom: 9.scale,
                trailing: 3.scale
            ))
        }
        .padding(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
}

// MARK: Private
private extension TimeObject {
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(totalMinutes * 60)) ?? ""
    }
}

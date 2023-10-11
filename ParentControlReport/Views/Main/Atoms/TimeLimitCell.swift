//
//  TimeLimitCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 10.10.2023.
//

import SwiftUI

struct TimeLimitCell: View {
    let totalActivity: TimeInterval
    let timeLimit: Int
    
    var body: some View {
        ZStack {
            Color(Appearance.background2)
                .cornerRadius(20.scale)
            
            ZStack {
                Color(Appearance.white)
                    .cornerRadius(20.scale)
                
                VStack {
                    Text(formatted(time: totalActivity, style: .abbreviated))
                        .font(Font(Fonts.Satoshi.medium(size: 50.scale)))
                        .foregroundColor(Color(Appearance.black))
                    
                    Text("Home.TimeLimit.ScreenTime".localized)
                        .font(Font(Fonts.Satoshi.regular(size: 20.scale)))
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    
                    HStack {
                        Text("Home.TimeLimit.Used".localized)
                            .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                            .frame(alignment: .leading)
                        
                        Spacer()
                        
                        Text("Home.TimeLimit.Limit".localized)
                            .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                            .frame(alignment: .trailing)
                    }
                    .padding(EdgeInsets(
                        top: 24.scale,
                        leading: 16.scale,
                        bottom: 0,
                        trailing: 16.scale
                    ))
                    
                    HStack {
                        Text(formatted(time: totalActivity, style: .positional))
                            .font(Font(Fonts.Satoshi.bold(size: 24.scale)))
                            .foregroundColor(Color(Appearance.black))
                            .frame(alignment: .leading)
                        
                        Spacer()
                        
                        Text(formatted(time: TimeInterval(timeLimit), style: .positional))
                            .font(Font(Fonts.Satoshi.bold(size: 24.scale)))
                            .foregroundColor(Color(Appearance.black))
                            .frame(alignment: .trailing)
                    }
                    .padding(EdgeInsets(
                        top: 4.scale,
                        leading: 16.scale,
                        bottom: 0,
                        trailing: 16.scale
                    ))
                    
                    ProgressView(value: totalActivity, total: TimeInterval(timeLimit))
                        .cornerRadius(4.5.scale)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(Color(Appearance.secondary))
                        .padding(EdgeInsets(
                            top: 0,
                            leading: 16.scale,
                            bottom: 0,
                            trailing: 16.scale
                        ))
                    
                    VStack {
                        Text("Home.TimeLimit.AdjustTime")
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
                    }
                    .padding(.top, 24.scale)
                }
                .padding(EdgeInsets(
                    top: 32.scale,
                    leading: 0,
                    bottom: 32.scale,
                    trailing: 0
                ))
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
private extension TimeLimitCell {
    func formatted(time: TimeInterval, style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = style
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: time) ?? ""
    }
}

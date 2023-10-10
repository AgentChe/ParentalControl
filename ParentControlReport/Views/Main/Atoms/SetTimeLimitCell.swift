//
//  SetTimeLimitCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 10.10.2023.
//

import SwiftUI

struct SetTimeLimitCell: View {
    let totalActivity: TimeInterval
    
    var body: some View {
        ZStack {
            Color(Appearance.background2)
                .cornerRadius(20.scale)
            
            ZStack {
                Color(Appearance.white)
                    .cornerRadius(20.scale)
                
                VStack {
                    Text(time())
                        .font(Font(Fonts.Satoshi.medium(size: 60.scale)))
                        .foregroundColor(Color(Appearance.black))
                    
                    Text("Home.TimeLimit.ScreenTime".localized)
                        .font(Font(Fonts.Satoshi.regular(size: 20.scale)))
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    
                    Text("Home.TimeLimit.SetTimeLimit")
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
    }
}

// MARK: Private
private extension SetTimeLimitCell {
    func time() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: totalActivity) ?? ""
    }
}

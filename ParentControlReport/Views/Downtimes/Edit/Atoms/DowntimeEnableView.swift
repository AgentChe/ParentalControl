//
//  DowntimeEnableView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct DowntimeEnableView: View {
    @Binding var enable: Bool
    let name: String
    
    var body: some View {
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
            
            Toggle(isOn: $enable) {
                Text(name)
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                    .foregroundColor(Color(Appearance.black))
            }
            .tint(Color(Appearance.secondary))
            .padding(16.scale)
        }
        .padding(EdgeInsets(
            top: 32.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}

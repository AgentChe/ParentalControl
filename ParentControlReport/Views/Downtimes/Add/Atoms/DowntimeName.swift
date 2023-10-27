//
//  DowntimeName.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 27.10.2023.
//

import SwiftUI

struct DowntimeName: View {
    @Binding var name: String
    
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
            
            TextField("", text: $name)
                .placeholder(when: name.isEmpty) {
                    Text("Downtime.EnterName".localized)
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.4)))
                        .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                }
                .foregroundColor(Color(Appearance.black))
                .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
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

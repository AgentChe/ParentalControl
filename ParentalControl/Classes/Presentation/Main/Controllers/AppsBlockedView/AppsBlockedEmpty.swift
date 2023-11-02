//
//  AppsBlockedEmpty.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI

struct AppsBlockedEmpty: View {
    var body: some View {
        VStack {
            Image("AppsBlocked.Empty")
                .resizable()
                .frame(width: 175.scale, height: 122.scale)
            
            Text("AppsBlocked.Empty.Title".localized)
                .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                .foregroundColor(Color(Appearance.black))
                .padding(EdgeInsets(
                    top: 15.scale,
                    leading: 82.scale,
                    bottom: 0,
                    trailing: 82.scale
                ))
                .multilineTextAlignment(.center)
            
            Text("AppsBlocked.Empty.SubTitle".localized)
                .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                .padding(EdgeInsets(
                    top: 0,
                    leading: 82.scale,
                    bottom: 0,
                    trailing: 82.scale
                ))
                .multilineTextAlignment(.center)
        }
    }
}

//
//  RecentActivityEmpty.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import SwiftUI

struct RecentActivityEmpty: View {
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                Image("Main.RecentActivity.Empty")
                    .resizable()
                    .frame(width: 60.scale, height: 60.scale, alignment: .center)
                
                Text("Main.RecentActivity.Empty.Title".localized)
                    .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                    .foregroundColor(Color(Appearance.black))
                
                Text("Main.RecentActivity.Empty.SubTitle".localized)
                    .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 32.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}

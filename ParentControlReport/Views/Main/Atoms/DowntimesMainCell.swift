//
//  DowntimesMainCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct DowntimesMainCell: View {
    var body: some View {
        HStack {
            VStack {
                Text("Downtime".localized)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Downtime.SetAvailable".localized)
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Image("Downtimes.Settings")
                .resizable()
                .frame(width: 32.scale, height: 32.scale, alignment: .center)
        }
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 26.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}

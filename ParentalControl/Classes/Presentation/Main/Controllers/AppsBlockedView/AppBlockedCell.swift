//
//  AppBlockedCell.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 02.11.2023.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct AppBlockedCell: View {
    let token: ApplicationToken
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.background2))
            
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(Color(Appearance.black))
                .padding([.top, .leading, .trailing], 3.scale)
                .padding(.bottom, 6.scale)
            
            Label(token)
                .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                .foregroundColor(Color(Appearance.black))
                .labelStyle(.titleOnly)
        }
        .listRowInsets(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 16.scale,
            trailing: 8.scale
        ))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

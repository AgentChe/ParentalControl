//
//  TitleCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import SwiftUI

struct TitleCell: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(Appearance.black))
                .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 32.scale)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}

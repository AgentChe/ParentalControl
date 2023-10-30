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
        Text(title)
            .foregroundColor(Color(Appearance.black))
            .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(Appearance.background))
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

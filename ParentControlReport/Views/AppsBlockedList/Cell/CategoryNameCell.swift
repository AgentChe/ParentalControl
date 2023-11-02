//
//  CategoryNameCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI

struct CategoryNameCell: View {
    let category: ActivityCategory
    
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
            
            Text(category.name)
                .foregroundColor(Color(Appearance.black))
                .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                .padding(16.scale)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 8.scale,
            trailing: 8.scale
        ))
    }
}

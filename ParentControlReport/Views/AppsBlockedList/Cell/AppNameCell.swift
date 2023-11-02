//
//  AppNameCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI
import FamilyControls

struct AppNameCell: View {
    let application: ActivityApplication
    
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
            
            HStack {
                Label(application.token)
                    .labelStyle(.iconOnly)
                    .frame(width: 40.scale, height: 40.scale)
                    .padding(EdgeInsets())
                
                VStack(alignment: .leading) {
                    Text(application.name)
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .padding(EdgeInsets())
                    
                    if let name = application.category?.name {
                        Text(name)
                            .foregroundColor(Color(Appearance.black))
                            .font(Font(Fonts.Satoshi.regular(size: 12.scale)))
                            .padding(EdgeInsets(
                                top: 4.scale,
                                leading: 8.scale,
                                bottom: 4.scale,
                                trailing: 8.scale
                            ))
                            .background(
                                RoundedRectangle(cornerRadius: 12.scale)
                                    .foregroundColor(Color(Appearance.background))
                            )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8.scale)
                
                Spacer()
            }
            .padding(16.scale)
        }
        .listRowInsets(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 8.scale,
            trailing: 8.scale
        ))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

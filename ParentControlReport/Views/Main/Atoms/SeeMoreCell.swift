//
//  SeeMoreCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import SwiftUI

struct SeeMoreCell: View {
    enum SeeMore {
        case recentActivity
        case webHistory
        
        var title: String {
            switch self {
            case .recentActivity:
                return "Downtime.RecentActivity".localized
            case .webHistory:
                return "Downtime.WebHistory".localized
            }
        }
    }
    
    let element: SeeMore
    
    var body: some View {
        HStack {
            Text(element.title)
                .foregroundColor(Color(Appearance.black))
                .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Downtime.SeeMore".localized)
                .padding(EdgeInsets(
                    top: 4.scale,
                    leading: 12.scale,
                    bottom: 4.scale,
                    trailing: 12.scale
                ))
                .background(Color(Appearance.background2))
                .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                .foregroundColor(Color(Appearance.black))
                .cornerRadius(20.scale)
        }
        .padding(.top, 32.scale)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 0,
            leading: 8.scale,
            bottom: 8.scale,
            trailing: 8.scale
        ))
    }
}

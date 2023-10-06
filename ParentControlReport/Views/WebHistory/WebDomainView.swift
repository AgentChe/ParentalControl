//
//  WebDomainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import SwiftUI

struct WebDomainView: View {
    let item: WebHistoryItem
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(item.blocked ? "WebHistory.Blocked" : "WebHistory.Enabled")
                        .resizable()
                        .frame(width: 24.scale, height: 24.scale, alignment: .center)
                    
                    Text(item.domain.webDomain.domain ?? "")
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(item.blocked ? Appearance.textRed : Appearance.textBlue))
                    
                    Spacer()
                }
                
                HStack {
                    Text(Self.formatter.string(from: Date(timeIntervalSince1970: item.domain.totalActivityDuration)))
                        .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Image("WebHistory.Menu")
                .resizable()
                .frame(width: 24.scale, height: 24.scale, alignment: .center)
        }
        .padding(16.scale)
    }
}

//
//  WebHistoryEmptyView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import SwiftUI

struct WebHistoryEmptyView: View {
    var body: some View {
        VStack {
            Image("WebHistory.Empty")
                .resizable()
                .frame(width: 343.scale, height: 104.scale, alignment: .center)
            
            Text("WebHistory.Empty.Title".localized)
                .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                .foregroundColor(Color(Appearance.black))
            
            Text("WebHistory.Empty.SubTitle".localized)
                .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
        }
    }
}

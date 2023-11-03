//
//  WeekdayButtonSUI.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import SwiftUI

struct WeekdayButtonSUI: View {
    let title: String
    
    @Binding var marked: Bool
    
    var body: some View {
        ZStack {
            if marked {
                Circle()
                    .background(Circle())
                    .foregroundColor(Color(Appearance.background2))
            }
            
            Text(title)
                .foregroundColor(Color(Appearance.black))
                .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
        }
        .frame(width: 42.scale, height: 42.scale)
        .onTapGesture {
            marked.toggle()
        }
    }
}

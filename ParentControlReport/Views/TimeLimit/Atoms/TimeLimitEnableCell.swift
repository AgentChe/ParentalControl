//
//  TimeLimitEnableCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import SwiftUI

final class TimeLimitEnableObject: ObservableObject {
    @Published var enable: Bool
    
    init(enable: Bool) {
        self.enable = enable
    }
}

struct TimeLimitEnableCell: View {
    @ObservedObject var enable: TimeLimitEnableObject
    
    var body: some View {
        ZStack {
            Color(Appearance.background2)
                .cornerRadius(20.scale)
            
            ZStack {
                Color(Appearance.white)
                    .cornerRadius(20.scale)
                
                Toggle(isOn: $enable.enable) {
                    Text("TimeLimit.Enable.Title".localized)
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                }
                .tint(Color(Appearance.secondary))
                .padding(16.scale)
            }
            .padding(EdgeInsets(
                top: 3.scale,
                leading: 3.scale,
                bottom: 9.scale,
                trailing: 3.scale
            ))
        }
        .padding(EdgeInsets(
            top: 8.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }
}

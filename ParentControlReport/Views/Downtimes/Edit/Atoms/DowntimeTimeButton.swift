//
//  DowntimeTimeButton.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct DowntimeTimeButton: View {
    let title: String
    @Binding var date: Date?
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(title)
                    .foregroundColor(Color(Appearance.black))
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                
                Spacer()
                
                Text(date.formatted())
                    .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                    .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                
                Image("Downtimes.Arrow.Right")
                    .resizable()
                    .frame(width: 24.scale, height: 24.scale, alignment: .center)
                
            }
        })
    }
}

// MARK: Additional
private extension Date? {
    func formatted() -> String {
        guard let date = self else {
            return "Downtime.NotSet".localized
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

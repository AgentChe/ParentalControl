//
//  ActivityCategoryCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 20.10.2023.
//

import SwiftUI

struct ActivityCategoryCell: View {
    let element: CategoryElement
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.scale)
                .foregroundColor(element.color.opacity(0.2))
            
            VStack {
                Text(element.name)
                    .foregroundColor(element.color)
                    .font(Font(Fonts.Satoshi.medium(size: 13.scale)))
                
                Text(element.activityDuration.formatted)
                    .foregroundColor(element.color)
                    .font(Font(Fonts.Satoshi.medium(size: 13.scale)))
            }
            .padding(14.scale)
        }
    }
}

// MARK: Additional
private extension TimeInterval {
    var formatted: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter.string(from: self) ?? ""
    }
}

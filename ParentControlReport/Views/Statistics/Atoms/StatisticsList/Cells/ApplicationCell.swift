//
//  ApplicationCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import SwiftUI
import FamilyControls

struct ApplicationCell: View {
    let element: ApplicationElement
    
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
            
            VStack {
                HStack {
                    Label(element.application.token)
                        .labelStyle(.iconOnly)
                        .frame(width: 32.scale, height: 32.scale)
                        .padding(EdgeInsets())
                    
                    VStack(alignment: .leading) {
                        Text(element.application.name)
                            .foregroundColor(Color(Appearance.black))
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                            .padding(EdgeInsets())
                        
                        Text(element.category)
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8.scale)
                    
                    Spacer()
                }
                
                HStack {
                    ProgressView(value: element.activityScore, total: 1)
                        .cornerRadius(4.5.scale)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(Color(Appearance.third))
                        .frame(width: 232.scale)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                    
                    Spacer()
                    
                    Text(element.durationFormatted)
                        .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                }
                .padding(.top, 16.scale)
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

// MARK: Additional
private extension ApplicationElement {
    var durationFormatted: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter.string(from: activityDuration) ?? ""
    }
}

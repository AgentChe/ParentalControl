//
//  AppsActionSheet.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI

struct AppsActionSheet: View {
    @Binding var presented: Bool
    let didTapAppsBlocked: () -> Void
    let didTapTimeLimit: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Button(action: {
                    presented = false
                    
                    didTapAppsBlocked()
                }, label: {
                    Text("Apps.AppsBlocked".localized)
                        .frame(width: 343.scale)
                        .padding(.top, 12.scale)
                        .padding(.bottom, 12.scale)
                        .background(Color(Appearance.background))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                
                Button(action: {
                    presented = false
                    
                    didTapTimeLimit()
                }, label: {
                    Text("Apps.TimeLimit".localized)
                        .frame(width: 343.scale)
                        .padding(.top, 12.scale)
                        .padding(.bottom, 12.scale)
                        .background(Color(Appearance.background))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                
                Button(action: {
                    presented = false
                }, label: {
                    Image("Apps.Close")
                        .resizable()
                        .frame(width: 59.scale, height: 59.scale)
                })
                .padding(.top, 12.scale)
                .padding(.bottom, 8.scale)
            }
        }
        .frame(width: 375.scale)
        .background(Color(Appearance.black.withAlphaComponent(0.5)))
    }
}

//
//  ConfirmAlert.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 26.10.2023.
//

import SwiftUI

struct ConfirmAlert: View {
    let title: String?
    let subTitle: String?
    let confirmTitle: String?
    let cancelTitle: String?
    @Binding var isPresented: Bool
    let confirmAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                if let title = title {
                    Text(title)
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                        .padding(EdgeInsets(
                            top: 32.scale,
                            leading: 32.scale,
                            bottom: 0,
                            trailing: 32.scale
                        ))
                }
                
                if let subTitle {
                    Text(subTitle)
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                        .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                        .padding(EdgeInsets(
                            top: 0,
                            leading: 48.scale,
                            bottom: 28.scale,
                            trailing: 48.scale
                        ))
                }
                
                if let confirmTitle {
                    Button(action: {
                        confirmAction?()
                        isPresented.toggle()
                    }, label: {
                        Text(confirmTitle)
                            .padding(.top, 12.scale)
                            .padding(.bottom, 12.scale)
                            .frame(width: 210.scale)
                            .background(Color(Appearance.primary))
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black))
                            .cornerRadius(20.scale)
                    })
                }
                
                if let cancelTitle {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Text(cancelTitle)
                            .padding(.top, 12.scale)
                            .padding(.bottom, 12.scale)
                            .frame(width: 210.scale)
                            .background(Color(Appearance.background2))
                            .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                            .foregroundColor(Color(Appearance.black))
                            .cornerRadius(20.scale)
                    })
                    .padding(.top, 12.scale)
                }
                
                Spacer()
            }
        }
    }
}

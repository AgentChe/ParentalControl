//
//  EditDowntimeView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

struct EditDowntimeView: View {
    @Binding var isPresented: Bool
    
    @ObservedObject private var viewModel: EditDowntimeViewModel
    
    init(isPresented: Binding<Bool>, downtime: Downtime) {
        _isPresented = isPresented
        viewModel = EditDowntimeViewModel(downtime: downtime)
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                Button(action: {
                    // TODO
                }, label: {
                    Text("Downtime.Save".localized)
                        .padding(EdgeInsets(
                            top: 12.scale,
                            leading: 32.scale,
                            bottom: 12.scale,
                            trailing: 32.scale
                        ))
                        .background(Color(Appearance.background2))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
                
                Button(action: {
                    // TODO
                }, label: {
                    Text("Downtime.Remove".localized)
                        .padding(EdgeInsets(
                            top: 12.scale,
                            leading: 32.scale,
                            bottom: 12.scale,
                            trailing: 32.scale
                        ))
                        .background(Color(Appearance.background2))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .foregroundColor(Color(Appearance.black))
                        .cornerRadius(20.scale)
                })
            }
        }
    }
}

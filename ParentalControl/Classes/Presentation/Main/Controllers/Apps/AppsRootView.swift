//
//  AppsRootView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI

struct AppsRootView: View {
    @State private var actionSheetPresented = false
    @State private var appsBlockedPresented = false
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        actionSheetPresented = true
                    }, label: {
                        Image("Apps.Select")
                            .resizable()
                            .frame(width: 40.scale, height: 40.scale)
                    })
                }
                .padding(.trailing, 16.scale)
                .padding(.top, 16.scale)
                
                InstantBlockCell()
                    .frame(width: 359.scale, height: 80.scale)
                    .padding(.top, 16.scale)
                
                Spacer()
            }
            .sheet(isPresented: $appsBlockedPresented, content: {
                AppsBlockedView()
            })
            
            if actionSheetPresented {
                AppsActionSheet(presented: $actionSheetPresented, didTapAppsBlocked: {
                    appsBlockedPresented = true
                }, didTapTimeLimit: {
                    
                })
            }
        }
    }
}

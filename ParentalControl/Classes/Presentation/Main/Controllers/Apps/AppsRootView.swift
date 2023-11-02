//
//  AppsRootView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI

struct AppsRootView: View {
    @ObservedObject private var appsBlockedSelections = Selections(activity: .appsBlocked)
    
    @State private var appsBlockedPickerPresented = false
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                InstantBlockCell()
                    .frame(width: 359.scale, height: 80.scale)
                    .padding(.top, 32.scale)
                
                AppsBlockedView()
                    .frame(width: 359.scale, height: appsBlockedSelections.applicationsTokens.isEmpty ? 84.scale : 102.scale)
                    .padding(.top, 16.scale)
                    .environmentObject(appsBlockedSelections)
                    .familyActivityPicker(
                        isPresented: $appsBlockedPickerPresented,
                        selection: $appsBlockedSelections.activitySelection
                    )
                    .onTapGesture {
                        appsBlockedPickerPresented = true
                    }
                
                Spacer()
            }
        }
    }
}

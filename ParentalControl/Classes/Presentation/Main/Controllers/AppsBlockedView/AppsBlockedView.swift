//
//  AppsBlockedView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI
import DeviceActivity

struct AppsBlockedView: View {
    @State private var selectionsPickerPresented = false
    
    @ObservedObject private var selections = Selections(activity: .appsBlocked)
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Apps.AppsBlocked".localized)
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.medium(size: 20.scale)))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        selectionsPickerPresented = true
                    }, label: {
                        Image("AppsBlocked.Add")
                            .resizable()
                            .frame(width: 24.scale, height: 24.scale)
                    })
                    .familyActivityPicker(
                        isPresented: $selectionsPickerPresented,
                        selection: $selections.activitySelection
                    )
                }
                .padding([.top, .leading, .trailing], 16.scale)
                
                if selections.isEmpty {
                    Spacer()
                    
                    AppsBlockedEmpty()
                    
                    Spacer()
                } else {
                    DeviceActivityReport(.appsBlocked, filter: DeviceActivityFilter(
                        segment: .weekly(during: DateInterval(
                            start: Calendar.current.date(byAdding: .month, value: -3, to: Date())!,
                            end: Date()
                        )),
                        users: .all,
                        devices: .init([.iPhone]),
                        applications: selections.activitySelection.applicationTokens,
                        categories: selections.activitySelection.categoryTokens,
                        webDomains: selections.activitySelection.webDomainTokens
                    ))
                }
            }
            .background(Color(Appearance.background))
        }
    }
}

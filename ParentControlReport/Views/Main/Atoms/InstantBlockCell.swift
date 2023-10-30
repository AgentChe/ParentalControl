//
//  InstantBlockCell.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import SwiftUI
import ManagedSettings

struct InstantBlockCell: View {
    @State private var appsBlocked: Bool
    
    private let store: ManagedSettingsStore
    
    init() {
        let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: "instant_block_store"))
        
        self.store = store
        self.appsBlocked = store.shield.applicationCategories == .all()
        
    }
    
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
            
            HStack {
                VStack {
                    Text("Downtime.InstantBlock.Title".localized)
                        .foregroundColor(Color(Appearance.black))
                        .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Downtime.InstantBlock.SubTitle".localized)
                        .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                        .font(Font(Fonts.Satoshi.regular(size: 16.scale)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                Toggle(isOn: $appsBlocked.onUpdate {
                    if appsBlocked {
                        store.shield.applicationCategories = .all()
                        store.shield.webDomainCategories = .all()
                    } else {
                        store.clearAllSettings()
                    }
                }) {}
                .labelsHidden()
                .tint(Color(Appearance.secondary))
            }
            .padding(16.scale)
        }
        .background(Color(Appearance.background))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(
            top: 16.scale,
            leading: 8.scale,
            bottom: 0,
            trailing: 8.scale
        ))
    }
}

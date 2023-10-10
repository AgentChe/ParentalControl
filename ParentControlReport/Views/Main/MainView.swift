//
//  MainView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 09.10.2023.
//

import SwiftUI

struct MainView: View {
    @State var pin = ProfileCache.shared.pin() ?? "nil"
    
    var body: some View {
        Text(pin)
        
        Button("Tap", action: {
            ProfileCache.shared.store(pin: "asdasds")
            pin = "asdasds"
        })
    }
}

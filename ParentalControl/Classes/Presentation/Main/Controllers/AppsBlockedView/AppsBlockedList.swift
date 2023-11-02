//
//  AppsBlockedList.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 02.11.2023.
//

import SwiftUI
import ManagedSettings

struct AppsBlockedList: View {
    let applicationsTokens: [ApplicationToken]
    
    var body: some View {
        List {
            ForEach(applicationsTokens, id: \.self) { token in
                AppBlockedCell(token: token)
            }
        }
        .listStyle(PlainListStyle())
    }
}

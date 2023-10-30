//
//  WebHistoryView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import SwiftUI

struct WebHistoryView: View {
    let items: [WebHistoryItem]
    
    var body: some View {
        items.isEmpty ? AnyView(empty) : AnyView(list)
    }
}

// MARK: Private
private extension WebHistoryView {
    var empty: some View {
        WebHistoryEmptyView()
    }
    
    var list: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(items) { item in
                    WebDomainView(item: item)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

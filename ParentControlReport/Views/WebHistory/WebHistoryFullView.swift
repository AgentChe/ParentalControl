//
//  WebHistoryFullView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import SwiftUI

struct WebHistoryFullView: View {
    let items: [WebHistoryItem]
    
    var body: some View {
        items.isEmpty ? AnyView(empty) : AnyView(list)
    }
}

// MARK: Private
private extension WebHistoryFullView {
    var empty: some View {
        ZStack {
            Color(Appearance.background)
            WebHistoryEmptyView()
        }
    }
    
    var list: some View {
        ZStack {
            Color(Appearance.background)
            List {
                ForEach(items) { item in
                    WebDomainView(item: item)
                        .background(Color(Appearance.white))
                        .cornerRadius(20.scale)
                        .listRowInsets(EdgeInsets(
                            top: 8.scale,
                            leading: 16.scale,
                            bottom: 8.scale,
                            trailing: 16.scale
                        ))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

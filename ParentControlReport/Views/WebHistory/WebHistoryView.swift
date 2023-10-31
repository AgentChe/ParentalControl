//
//  WebHistoryView.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import SwiftUI

struct WebHistoryView: View {
    @EnvironmentObject var daysActivities: DaysActivities
    
    var body: some View {
//        webHistory.items.isEmpty ? AnyView(empty) : AnyView(list)
        list
    }
}

// MARK: Private
private extension WebHistoryView {
    var empty: some View {
        WebHistoryEmptyView()
    }
    
//    var list: some View {
//        ZStack {
//            Color(Appearance.background)
//
//            List {
//                ForEach(webHistory.items) { item in
//                    WebDomainView(item: item)
//                }
//            }
//            .listStyle(PlainListStyle())
//        }
//    }
    
    var list: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(daysActivities.days) { day in
                    Text(day.day.description)
                }
            }
        }
    }
}

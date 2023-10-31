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
    
    var list: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                ForEach(daysActivities.days) { day in
                    if !day.webHistory.isEmpty {
                        Section(content: {
                            ForEach(day.webHistory) { item in
                                WebDomainView(item: item) { changed in
                                    daysActivities.update(item: changed)
                                }
                            }
                        }, header: {
                            Text(day.day.formatted)
                                .foregroundColor(Color(Appearance.black.withAlphaComponent(0.6)))
                                .font(Font(Fonts.Satoshi.medium(size: 16.scale)))
                        })
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

// MARK: Additional
private extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: self)
    }
}

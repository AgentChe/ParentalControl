//
//  AppsBlockedList.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import SwiftUI

struct AppsBlockedList: View {
    private let model: Model
    
    init(activity: Activity) {
        model = Model(activity: activity)
    }
    
    var body: some View {
        ZStack {
            Color(Appearance.background)
            
            List {
                if !model.categories.isEmpty {
                    Section(content: {
                        ForEach(model.categories) { category in
                            CategoryNameCell(category: category)
                        }
                    }, header: {
                        Text("AppsBlocked.Categories".localized)
                            .foregroundColor(Color(Appearance.black))
                            .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                    })
                }
                
                if !model.applications.isEmpty {
                    Section(content: {
                        ForEach(model.applications) { application in
                            AppNameCell(application: application)
                        }
                    }, header: {
                        Text("AppsBlocked.Apps".localized)
                            .foregroundColor(Color(Appearance.black))
                            .font(Font(Fonts.Satoshi.bold(size: 20.scale)))
                    })
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

private struct Model {
    var categories = [ActivityCategory]()
    var applications = [ActivityApplication]()
    
    init(activity: Activity) {
        let selections = Selections(activity: .appsBlocked)
        
        selections.activitySelection.categories.forEach { selected in
            if let category = activity.categories.first(where: { $0.token == selected.token }) {
                categories.append(category)
            }
        }
        
        selections.activitySelection.applications.forEach { selected in
            if let application = activity.applications.first(where: { $0.token == selected.token }) {
                applications.append(application)
            }
        }
    }
}

//
//  DayActivity.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import DeviceActivity
import Foundation
import ManagedSettings

final class DayActivity: ObservableObject, Identifiable, Hashable {
    let id: String
    let day: Date
    @Published var categories: [ActivityCategory]
    
    init(
        id: String = UUID().uuidString,
        day: Date,
        categories: [ActivityCategory]
    ) {
        self.id = id
        self.day = day
        self.categories = categories
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DayActivity, rhs: DayActivity) -> Bool {
        lhs.id == rhs.id
    }
}

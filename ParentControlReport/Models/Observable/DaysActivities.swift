//
//  DaysActivities.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import SwiftUI

final class DaysActivities: ObservableObject {
    @Published var days: [DayActivity]
    
    init(days: [DayActivity]) {
        self.days = days
    }
}

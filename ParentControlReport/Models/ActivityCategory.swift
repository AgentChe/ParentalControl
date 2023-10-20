//
//  ActivityCategory.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import ManagedSettings
import DeviceActivity
import Foundation

struct ActivityCategory:Hashable {
    let token: ActivityCategoryToken
    let totalActivityDuration: TimeInterval
    let name: String
    let applications: [ActivityApplication]
}

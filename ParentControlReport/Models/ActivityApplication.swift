//
//  ActivityApplication.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 19.10.2023.
//

import Foundation
import ManagedSettings

struct ActivityApplication: Hashable {
    let token: ApplicationToken
    let name: String
    let totalActivityDuration: TimeInterval
}

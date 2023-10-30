//
//  WebHistoryItem.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import Foundation
import ManagedSettings

struct WebHistoryItem: Identifiable, Hashable {
    let id = UUID().uuidString
    let domain: WebDomain
    var totalActivityDuration: TimeInterval
    var blocked: Bool
}

//
//  WebHistoryItem.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import Foundation
import ManagedSettings

struct WebHistoryItem: Identifiable {
    let id = UUID().uuidString
    let domain: WebDomain
    let totalActivityDuration: TimeInterval
    var blocked: Bool
}

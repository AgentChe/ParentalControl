//
//  WebHistoryItem.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import Foundation
import DeviceActivity

struct WebHistoryItem: Identifiable {
    let id = UUID().uuidString
    let domain: DeviceActivityData.WebDomainActivity
    let blocked: Bool
}

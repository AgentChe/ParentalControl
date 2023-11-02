//
//  Activity.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 01.11.2023.
//

import Foundation

struct Activity: Hashable {
    let categories: [ActivityCategory]
    let applications: [ActivityApplication]
    let webHistory: [WebHistoryItem]
}

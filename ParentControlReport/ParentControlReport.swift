//
//  ParentControlReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import DeviceActivity
import SwiftUI

@main
struct ParentControlReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        WebHistoryTruncatReport { items in
            WebHistoryTruncatView(items: items)
        }
        WebHistoryFullReport { items in
            WebHistoryFullView(items: items)
        }
    }
}

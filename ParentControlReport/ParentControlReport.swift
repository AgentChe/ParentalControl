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
        WebHistoryReport { items in
            WebHistoryView(items: items)
        }
        
        StatisticsReport { daysActivities in
            StatisticsView(daysActivities: daysActivities)
        }
        
        MainReport { bundle in
            MainView(bundle: bundle)
        }
    }
}

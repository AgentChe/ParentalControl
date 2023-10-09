//
//  WebHistoryTruncatReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import DeviceActivity
import SwiftUI
import ManagedSettings

struct WebHistoryTruncatReport: DeviceActivityReportScene {
    var context: DeviceActivityReport.Context = .webHistoryTruncat
    
    let content: ([WebHistoryItem]) -> WebHistoryTruncatView
    
    private let store = ManagedSettingsStore()
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> [WebHistoryItem] {
        var result = [WebHistoryItem]()
        
        
        
        return result
    }
}

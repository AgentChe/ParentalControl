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
        
        for await item in data {
            for await segment in item.activitySegments {
                for await category in segment.categories {
                    for await domain in category.webDomains {
                        var blocked: Bool {
                            guard let token = domain.webDomain.token else {
                                return false
                            }
                            
                            let domains = store.shield.webDomains ?? []
                            
                            return domains.contains(token)
                        }
                        
                        let item = WebHistoryItem(
                            domain: domain,
                            blocked: blocked
                        )
                        result.append(item)
                    }
                }
            }
        }
        
        return result
    }
}

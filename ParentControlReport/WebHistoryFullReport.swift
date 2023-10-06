//
//  WebHistoryFullReport.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import DeviceActivity
import SwiftUI
import ManagedSettings

struct WebHistoryFullReport: DeviceActivityReportScene {
    var context: DeviceActivityReport.Context = .webHistoryFull
    
    let content: ([WebHistoryItem]) -> WebHistoryFullView
    
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

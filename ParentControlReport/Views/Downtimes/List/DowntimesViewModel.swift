//
//  DowntimesViewModel.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

final class DowntimesViewModel: ObservableObject {
    @Published var downtimes = [Downtime]()
    
    private lazy var contentService = ContentService.shared
    
    init() {
        downtimes = contentService.downtimes()
    }
}

// MARK: Public
extension DowntimesViewModel {
    
}

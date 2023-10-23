//
//  EditDowntimeViewModel.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 23.10.2023.
//

import SwiftUI

final class EditDowntimeViewModel: ObservableObject {
    private let downtimeId: String
    
    private lazy var contentService = ContentService.shared
    
    init(downtime: Downtime) {
        downtimeId = downtime.id
    }
}

// MARK: Public
extension EditDowntimeViewModel {
    func remove() {
        contentService.remove(downtimeId: downtimeId)
    }
}

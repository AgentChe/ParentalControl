//
//  DeviceActivityReport.Context+Extension.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import SwiftUI
import DeviceActivity

extension DeviceActivityReport.Context {
    static let main = Self("Main")
    static let statistics = Self("Statistics")
    static let webHistory = Self("Web history")
}

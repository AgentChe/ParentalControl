//
//  ManagedSettingsStore+Extenstion.swift
//  ParentControlReport
//
//  Created by Андрей Чернышев on 30.10.2023.
//

import ManagedSettings

extension ManagedSettingsStore {
    static let timeLimit = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: "store_timeLimit"))
    static let webHistory = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: "web_history"))
    static let instantBlock = ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: "instant_block_store"))
}

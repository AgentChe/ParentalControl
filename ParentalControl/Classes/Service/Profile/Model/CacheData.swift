//
//  CacheData.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 11.10.2023.
//

import Foundation

struct CacheData<O: Codable>: Codable, Comparable {
    let date: Date
    let object: O
    
    static func < (lhs: CacheData<O>, rhs: CacheData<O>) -> Bool {
        lhs.date < rhs.date
    }
    
    static func == (lhs: CacheData<O>, rhs: CacheData<O>) -> Bool {
        lhs.date == rhs.date
    }
}

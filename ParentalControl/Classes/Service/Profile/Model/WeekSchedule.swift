//
//  WeekSchedule.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import Foundation

final class WeekSchedule: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case su, mo, tu, we, th, fr, sa
    }
    
    @Published var su: Bool
    @Published var mo: Bool
    @Published var tu: Bool
    @Published var we: Bool
    @Published var th: Bool
    @Published var fr: Bool
    @Published var sa: Bool
    
    init(
        su: Bool = false,
        mo: Bool = false,
        tu: Bool = false,
        we: Bool = false,
        th: Bool = false,
        fr: Bool = false,
        sa: Bool = false
    ) {
        self.su = su
        self.mo = mo
        self.tu = tu
        self.we = we
        self.th = th
        self.fr = fr
        self.sa = sa
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        su = try container.decode(Bool.self, forKey: .su)
        mo = try container.decode(Bool.self, forKey: .mo)
        tu = try container.decode(Bool.self, forKey: .tu)
        we = try container.decode(Bool.self, forKey: .we)
        th = try container.decode(Bool.self, forKey: .th)
        fr = try container.decode(Bool.self, forKey: .fr)
        sa = try container.decode(Bool.self, forKey: .sa)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(su, forKey: .su)
        try container.encode(mo, forKey: .mo)
        try container.encode(tu, forKey: .tu)
        try container.encode(we, forKey: .we)
        try container.encode(th, forKey: .th)
        try container.encode(fr, forKey: .fr)
        try container.encode(sa, forKey: .sa)
    }
    
    var isSelected: Bool {
        [su, mo, tu, we, th, fr, sa].contains(where: { $0 })
    }
}

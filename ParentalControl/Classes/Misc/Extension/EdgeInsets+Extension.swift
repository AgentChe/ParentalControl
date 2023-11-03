//
//  EdgeInsets+Extension.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.11.2023.
//

import SwiftUI

extension EdgeInsets {
    init(value: CGFloat) {
        self = .init(top: value, leading: value, bottom: value, trailing: value)
    }
    
    init(
        t: CGFloat = 0,
        l: CGFloat = 0,
        b: CGFloat = 0,
        tr: CGFloat = 0
    ) {
        self = .init(top: t, leading: l, bottom: b, trailing: tr)
    }
}

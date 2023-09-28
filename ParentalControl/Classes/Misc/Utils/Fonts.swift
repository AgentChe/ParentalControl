//
//  Fonts.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct Fonts {
    // MARK: Satoshi
    struct Satoshi {
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "Satoshi-Medium", size: size)!
        }
        
        static func black(size: CGFloat) -> UIFont {
            UIFont(name: "Satoshi-Black", size: size)!
        }
        
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "Satoshi-Bold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "Satoshi-Regular", size: size)!
        }
    }
}

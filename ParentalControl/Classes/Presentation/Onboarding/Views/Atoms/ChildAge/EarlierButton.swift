//
//  EarlierButton.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import UIKit

final class EarlierButton: UIButton {
    var marked = false {
        didSet {
            update()
        }
    }
    
    var text: String? {
        didSet {
            setAttributedTitle(text?.attributed(with: attrs), for: .normal)
        }
    }
    
    private lazy var attrs = TextAttributes()
        .textColor(Appearance.black)
        .font(Fonts.Satoshi.regular(size: 16.scale))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension EarlierButton {
    func update() {
        backgroundColor = marked ? Appearance.textBlue : Appearance.background2
    }
}

//
//  YearButton.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

final class YearButton: UIButton {
    lazy var marked = false {
        didSet {
            update()
        }
    }
    
    var year: Int?
    
    private lazy var selectedAttrs = TextAttributes()
        .textColor(Appearance.textBlue)
        .font(Fonts.Satoshi.regular(size: 24.scale))
    private lazy var deselectedAttrs = TextAttributes()
        .textColor(Appearance.black)
        .font(Fonts.Satoshi.regular(size: 24.scale))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension YearButton {
    func setup(year: Int) {
        self.year = year
        
        let attrs = marked ? selectedAttrs : deselectedAttrs
        setAttributedTitle("\(year)".attributed(with: attrs), for: .normal)
    }
}

// MARK: Private
private extension YearButton {
    func update() {
        layer.borderWidth = marked ? 1.scale : 0
        layer.borderColor = marked ? Appearance.textBlue.cgColor : UIColor.clear.cgColor
        
        var text: String {
            guard let year else {
                return ""
            }
            
            return "\(year)"
        }
        
        let attrs = marked ? selectedAttrs : deselectedAttrs
        setAttributedTitle(text.attributed(with: attrs), for: .normal)
    }
}

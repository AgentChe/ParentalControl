//
//  ScreenTimeLimitPickerCell.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

final class ScreenTimeLimitPickerCell: UIView {
    lazy var label = makeLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(Appearance.black)
        .font(Fonts.Satoshi.bold(size: 40.scale))
        .lineHeight(48.scale)
        .textAlignment(.center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension ScreenTimeLimitPickerCell {
    func setup(value: String) {
        label.attributedText = value.attributed(with: attrs)
    }
}

// MARK: Make constraints
private extension ScreenTimeLimitPickerCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Make constraints
private extension ScreenTimeLimitPickerCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

//
//  TabItemView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import UIKit

final class TabItemView: UIButton {
    var marked = false {
        didSet {
            update()
        }
    }
    
    lazy var iconView = makeImageView()
    lazy var label = makeLabel()
    
    private let key: String
    
    private lazy var selectedAttrs = TextAttributes()
        .textColor(Appearance.fourth)
        .font(Fonts.Satoshi.bold(size: 13.scale))
        .lineHeight(15.6.scale)
        .textAlignment(.center)
    private lazy var deselectedAttrs = TextAttributes()
        .textColor(Appearance.black)
        .font(Fonts.Satoshi.bold(size: 13.scale))
        .lineHeight(15.6.scale)
        .textAlignment(.center)
    
    init(key: String) {
        self.key = key
        
        super.init(frame: .zero)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabItemView {
    func update() {
        let attrs = marked ? selectedAttrs : deselectedAttrs
        label.attributedText = key.localized.attributed(with: attrs)
        
        let iconName = key + (marked ? ".Selected" : ".Deselected")
        iconView.image = UIImage(named: iconName)
        
        alpha = marked ? 1 : 0.5
    }
}

// MARK: Make constraints
private extension TabItemView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24.scale),
            iconView.heightAnchor.constraint(equalToConstant: 24.scale),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 5.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TabItemView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

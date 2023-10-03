//
//  WeekdayButton.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 29.09.2023.
//

import UIKit

final class WeekdayButton: UIButton {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    
    lazy var marked = false {
        didSet {
            update()
        }
    }
    
    private let title: String
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 56.scale, height: 56.scale)
    }
}

// MARK: Private
private extension WeekdayButton {
    func initialize() {
        layer.cornerRadius = 20.scale
    }
    
    func update() {
        backgroundColor = marked ? Appearance.third : Appearance.background2
    }
}

// MARK: Make constraints
private extension WeekdayButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3.scale),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3.scale),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 3.scale),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WeekdayButton {
    func makeContainer() -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = Appearance.white
        view.layer.cornerRadius = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.regular(size: 20.scale))
            .lineHeight(28.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.isUserInteractionEnabled = false
        view.attributedText = title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}

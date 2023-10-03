//
//  OEmailView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 29.09.2023.
//

import UIKit

final class OEmailView: UIView {
    lazy var container = makeContainer()
    lazy var textField = makeTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OEmailView {
    func initialize() {
        layer.cornerRadius = 20.scale
        backgroundColor = Appearance.background2
        isUserInteractionEnabled = false
    }
}

// MARK: Make constraints
private extension OEmailView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3.scale),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3.scale),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 3.scale),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            textField.topAnchor.constraint(equalTo: container.topAnchor),
            textField.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OEmailView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.white
        view.layer.cornerRadius = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField() -> PaddingTextField {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.regular(size: 16.scale))
            .lineHeight(22.4.scale)
        let placeholderAttrs = TextAttributes()
            .textColor(Appearance.black.withAlphaComponent(0.4))
            .font(Fonts.Satoshi.regular(size: 16.scale))
            .lineHeight(22.4.scale)
        
        let view = PaddingTextField()
        view.textPadding = UIEdgeInsets(top: 16.scale, left: 16.scale, bottom: 16.scale, right: 16.scale)
        view.keyboardType = .emailAddress
        view.defaultTextAttributes = attrs.dictionary
        view.attributedPlaceholder = "Onboarding.SignUp.Placeholder".localized.attributed(with: placeholderAttrs)
        view.backgroundColor = UIColor.clear
        view.borderStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}

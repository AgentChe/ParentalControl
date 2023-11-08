//
//  SettingsAccountCell.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

final class SettingsAccountCell: UITableViewCell {
    var didTapEmail: (() -> Void)?
    var didTapPIN: (() -> Void)?
    
    lazy var shadow = makeShadow()
    lazy var container = makeContainer()
    lazy var emailButton = makeEmailButton()
    lazy var pinButton = makePinButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SettingsAccountCell {
    func setup(element: String?) {
        var placeholder: String {
            guard let element, !element.isEmpty else {
                return "Settings.NotSet".localized
            }
            
            return element
        }
        emailButton.setup(value: placeholder)
    }
}

// MARK: Private
private extension SettingsAccountCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    @objc
    func emailTapped() {
        didTapEmail?()
    }
    
    @objc
    func pinTapped() {
        didTapPIN?()
    }
}

// MARK: Make constraints
private extension SettingsAccountCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            shadow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            shadow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            shadow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.scale),
            shadow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: shadow.leadingAnchor, constant: 3.scale),
            container.trailingAnchor.constraint(equalTo: shadow.trailingAnchor, constant: -3.scale),
            container.topAnchor.constraint(equalTo: shadow.topAnchor, constant: 3.scale),
            container.bottomAnchor.constraint(equalTo: shadow.bottomAnchor, constant: -6.scale)
        ])
        
        NSLayoutConstraint.activate([
            emailButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            emailButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            emailButton.topAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pinButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            pinButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            pinButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor),
            pinButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SettingsAccountCell {
    func makeShadow() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.background2
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.white
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        shadow.addSubview(view)
        return view
    }
    
    func makeEmailButton() -> TitleValueButton {
        let view = TitleValueButton(title: "Settings.Email".localized)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
    
    func makePinButton() -> TitleValueButton {
        let view = TitleValueButton(
            title: "Settings.PIN".localized,
            separatorHidden: true
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(pinTapped), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
}

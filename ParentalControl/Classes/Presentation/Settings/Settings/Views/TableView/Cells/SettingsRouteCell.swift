//
//  SettingsRouteCell.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

final class SettingsRouteCell: UITableViewCell {
    var didTapPath: ((String) -> Void)?
    
    lazy var shadow = makeShadow()
    lazy var container = makeContainer()
    lazy var contactUsButton = makeContactUsButton()
    lazy var termsOfUseButton = makeTermsOfUseButton()
    lazy var privacyPolicyButton = makePrivacyPolicyButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SettingsRouteCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    @objc
    func tapped(sender: UIButton) {
        if sender === contactUsButton {
            didTapPath?(GlobalDefinitions.contactUsUrl)
        } else if sender === termsOfUseButton {
            didTapPath?(GlobalDefinitions.termsOfServiceUrl)
        } else if sender === privacyPolicyButton {
            didTapPath?(GlobalDefinitions.privacyPolicyUrl)
        }
    }
}

// MARK: Make constraints
private extension SettingsRouteCell {
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
            contactUsButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            contactUsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            contactUsButton.topAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            termsOfUseButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            termsOfUseButton.topAnchor.constraint(equalTo: contactUsButton.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            privacyPolicyButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            privacyPolicyButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            privacyPolicyButton.topAnchor.constraint(equalTo: termsOfUseButton.bottomAnchor),
            privacyPolicyButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SettingsRouteCell {
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
    
    func makeContactUsButton() -> TitleValueButton {
        let view = TitleValueButton(title: "Settings.ContactUs".localized)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
    
    func makeTermsOfUseButton() -> TitleValueButton {
        let view = TitleValueButton(title: "Settings.TermsOfUse".localized)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
    
    func makePrivacyPolicyButton() -> TitleValueButton {
        let view = TitleValueButton(
            title: "Settings.PrivacyPolicy".localized,
            separatorHidden: true
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
}

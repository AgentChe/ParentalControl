//
//  PINSignUpView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class PINSignUpView: UIView {
    var didSetEmail: ((String) -> Void)?
    var didSkip: (() -> Void)?
    
    lazy var skipButton = makeSkipButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var emailView = makeEmailView()
    lazy var continueButton = makeContinueButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToThis() {
        emailView.textField.becomeFirstResponder()
    }
}

// MARK: Private
private extension PINSignUpView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func didTapContinue() {
        if let text = emailView.textField.text {
            didSetEmail?(text)
        }
    }
    
    @objc
    func skipTapped() {
        didSkip?()
    }
}

// MARK: Make constraints
private extension PINSignUpView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 87.scale : 50.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 160.scale : 96.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            emailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            emailView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            emailView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            continueButton.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 24.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PINSignUpView {
    func makeSkipButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.bold(size: 32.scale))
            .lineHeight(38.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.SignUp.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black.withAlphaComponent(0.6))
            .font(Fonts.Satoshi.regular(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.SignUp.SubTitle".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeEmailView() -> OEmailView {
        let view = OEmailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Onboarding.SignUp.ContinueButton".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 27.5.scale
        view.backgroundColor = Appearance.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        addSubview(view)
        return view
    }
}

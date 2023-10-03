//
//  OSignUpView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 29.09.2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol OSignUpViewDelegate: AnyObject {
    func signUpViewDidSet(email: String)
}

final class OSignUpView: OSlideView {
    weak var mainDelegate: OSignUpViewDelegate?
    
    lazy var skipButton = makeSkipButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var emailView = makeEmailView()
    lazy var continueButton = makeContinueButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        emailView.textField.becomeFirstResponder()
    }
}

// MARK: Private
private extension OSignUpView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func didTapContinue() {
        if let text = emailView.textField.text {
            mainDelegate?.signUpViewDidSet(email: text)
        }
        
        onNext()
    }
}

// MARK: Make constraints
private extension OSignUpView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 67.scale : 30.scale)
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
private extension OSignUpView {
    func makeSkipButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
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

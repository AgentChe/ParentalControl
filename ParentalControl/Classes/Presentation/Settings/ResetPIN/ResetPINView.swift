//
//  ResetPINView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.11.2023.
//

import UIKit

final class ResetPINView: UIView {
    var pinDidSet: ((String) -> Void)?
    
    lazy var titleLabel = makeLabel()
    lazy var code1Field = makePinField()
    lazy var code2Field = makePinField()
    lazy var code3Field = makePinField()
    lazy var code4Field = makePinField()
    lazy var forgotButton = makeForgotButton()
    lazy var emailNotSetLabel = makeEmailNotSetLabel()
    
    lazy var titleAttrs = TextAttributes()
        .textColor(Appearance.black)
        .font(Fonts.Satoshi.bold(size: 20.scale))
        .lineHeight(28.scale)
        .textAlignment(.center)
    
    lazy var codesFields = [
        code1Field,
        code2Field,
        code3Field,
        code4Field
    ]
    
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
private extension ResetPINView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func didInputCode(inField: UITextField) {
        if let nextField = nextField(from: inField) {
            nextField.becomeFirstResponder()
            return
        }
        
        inField.resignFirstResponder()
        
        let pin = codesFields
            .map { $0.textField.text ?? "" }
            .joined()
        
        pinDidSet?(pin)
    }
    
    func nextField(from: UITextField) -> UITextField? {
        guard let index = codesFields.firstIndex(where: { $0.textField === from }) else {
            return nil
        }
        
        let nextIndex = index + 1
        
        guard codesFields.indices.contains(nextIndex) else {
            return nil
        }
        
        return codesFields[nextIndex].textField
    }
}

// MARK: Make constraints
private extension ResetPINView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ScreenSize.isIphoneXFamily ? 90.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            code1Field.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.scale),
            code1Field.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            code2Field.leadingAnchor.constraint(equalTo: code1Field.trailingAnchor, constant: 12.scale),
            code2Field.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            code3Field.leadingAnchor.constraint(equalTo: code2Field.trailingAnchor, constant: 12.scale),
            code3Field.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            code4Field.leadingAnchor.constraint(equalTo: code3Field.trailingAnchor, constant: 12.scale),
            code4Field.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            forgotButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            forgotButton.topAnchor.constraint(equalTo: code1Field.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            emailNotSetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            emailNotSetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            emailNotSetLabel.topAnchor.constraint(equalTo: code1Field.bottomAnchor, constant: 24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ResetPINView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePinField() -> PinField {
        let view = PinField()
        view.textField.addTarget(self, action: #selector(didInputCode(inField:)), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeForgotButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.secondary)
            .font(Fonts.Satoshi.bold(size: 16.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("ResetPIN.ForgotPIN".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeEmailNotSetLabel() -> PaddingLabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black.withAlphaComponent(0.6))
            .font(Fonts.Satoshi.regular(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.center)
        
        let view = PaddingLabel()
        view.insets = UIEdgeInsets(top: 16.scale, left: 16.scale, bottom: 16.scale, right: 16.scale)
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.backgroundColor = Appearance.background2
        view.attributedText = "ResetPIN.EmailNotSet".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

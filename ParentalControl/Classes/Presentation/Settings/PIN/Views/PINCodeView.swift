//
//  PINCodeView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

final class PINCodeView: UIView {
    var pinDidSet: ((String) -> Void)?
    
    lazy var titleLabel = makeTitleLabel()
    lazy var code1Field = makePinField()
    lazy var code2Field = makePinField()
    lazy var code3Field = makePinField()
    lazy var code4Field = makePinField()
    lazy var subTitleLabel = makeSubTitleLabel()
    
    private lazy var codesFields = [
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
    
    func moveToThis() {
        code1Field.textField.becomeFirstResponder()
    }
}

// MARK: Private
private extension PINCodeView {
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
private extension PINCodeView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 124.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            code1Field.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.scale),
            code1Field.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 67.scale)
        ])
        
        NSLayoutConstraint.activate([
            code2Field.leadingAnchor.constraint(equalTo: code1Field.trailingAnchor, constant: 12.scale),
            code2Field.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 67.scale)
        ])
        
        NSLayoutConstraint.activate([
            code3Field.leadingAnchor.constraint(equalTo: code2Field.trailingAnchor, constant: 12.scale),
            code3Field.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 67.scale)
        ])
        
        NSLayoutConstraint.activate([
            code4Field.leadingAnchor.constraint(equalTo: code3Field.trailingAnchor, constant: 12.scale),
            code4Field.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 67.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PINCodeView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Pin.Title".localized.attributed(with: attrs)
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
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black.withAlphaComponent(0.6))
            .font(Fonts.Satoshi.regular(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Pin.SubTitle".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

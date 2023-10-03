//
//  PinField.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 29.09.2023.
//

import UIKit

final class PinField: UIView {
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
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 70.scale, height: 70.scale)
    }
}

// MARK: UITextFieldDelegate
extension PinField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundColor = Appearance.third
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundColor = Appearance.background2
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Int(string) != nil
    }
}

// MARK: Private
private extension PinField {
    func initialize() {
        layer.cornerRadius = 20.scale
        backgroundColor = Appearance.background2
        isUserInteractionEnabled = false
    }
}

// MARK: Make constraints
private extension PinField {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3.scale),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3.scale),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 3.scale),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PinField {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.white
        view.layer.cornerRadius = 20.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField() -> DisableTextField {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 32.scale))
            .lineHeight(38.4.scale)
            .textAlignment(.center)
        
        let view = DisableTextField()
        view.delegate = self
        view.keyboardType = .decimalPad
        view.defaultTextAttributes = attrs.dictionary
        view.backgroundColor = UIColor.clear
        view.borderStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}

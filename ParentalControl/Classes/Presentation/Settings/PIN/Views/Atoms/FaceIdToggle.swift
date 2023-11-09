//
//  FaceIdToggle.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

final class FaceIdToggle: UIButton {
    var didChangeToggle: ((Bool) -> Void)?
    
    lazy var placeholderLabel = makeTitleLabel()
    lazy var switchView = makeSwitchView()
    
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
private extension FaceIdToggle {
    func initialize() {
        backgroundColor = Appearance.white
    }
    
    @objc
    func toggleChanged() {
        didChangeToggle?(switchView.isOn)
    }
}

// MARK: Make constraints
private extension FaceIdToggle {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80.scale),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension FaceIdToggle {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = "PIN.Menu.FaceID".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSwitchView() -> UISwitch {
        let view = UISwitch()
        view.onTintColor = Appearance.secondary
        view.thumbTintColor = Appearance.white
        view.tintColor = Appearance.background2
        view.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

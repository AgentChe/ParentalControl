//
//  EmailView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

final class EmailView: UIView {
    lazy var emailView = makeEmaiView()
    lazy var saveButton = makeSaveButton()
    lazy var preloader = makePreloader()
    
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
private extension EmailView {
    func initialize() {
        backgroundColor = Appearance.background
    }
}

// MARK: Make constraints
private extension EmailView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            emailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            emailView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            emailView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            saveButton.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 24.scale),
            saveButton.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            preloader.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension EmailView {
    func makeEmaiView() -> OEmailView {
        let view = OEmailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSaveButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Email.Button".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 27.5.scale
        view.backgroundColor = Appearance.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreloader() -> Spinner {
        let view = Spinner(size: CGSize(width: 45.scale, height: 45.scale))
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

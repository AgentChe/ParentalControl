//
//  TitleValueButton.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

final class TitleValueButton: UIButton {
    lazy var placeholderLabel = makeTitleLabel()
    lazy var valueLabel = makeValueLabel()
    lazy var arrowView = makeArrowView()
    lazy var separator = makeSeparator()
    
    private lazy var valueAttrs = TextAttributes()
        .textColor(Appearance.black.withAlphaComponent(0.6))
        .font(Fonts.Satoshi.medium(size: 16.scale))
        .lineHeight(22.4.scale)
        .textAlignment(.right)
    
    private let title: String
    private var value: String?
    private let arrowHidden: Bool
    private let separatorHidden: Bool
    
    init(
        title: String,
        value: String? = nil,
        arrowHidden: Bool = false,
        separatorHidden: Bool = false
    ) {
        self.title = title
        self.value = value
        self.arrowHidden = arrowHidden
        self.separatorHidden = separatorHidden
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TitleValueButton {
    func setup(value: String?) {
        self.value = value
        
        valueLabel.attributedText = value?.attributed(with: valueAttrs)
    }
}

// MARK: Private
private extension TitleValueButton {
    func initialize() {
        backgroundColor = Appearance.white
    }
}

// MARK: Make constraints
private extension TitleValueButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor, constant: 16.scale),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: arrowHidden ? -16.scale : -56.scale),
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            arrowView.widthAnchor.constraint(equalToConstant: 24.scale),
            arrowView.heightAnchor.constraint(equalToConstant: 24.scale),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            arrowView.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TitleValueButton {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = title.attributed(with: attrs)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeValueLabel() -> UILabel {
        let view = UILabel()
        view.attributedText = value?.attributed(with: valueAttrs)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeArrowView() -> UIImageView {
        let view = UIImageView()
        view.isHidden = arrowHidden
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Settings.Arrow.Right")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.isHidden = separatorHidden
        view.backgroundColor = Appearance.background2
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

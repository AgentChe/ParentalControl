//
//  PaygateView.swift
//  Manga
//
//  Created by Андрей Чернышев on 02.09.2022.
//

import UIKit

final class PaygateView: UIView {
    lazy var closeButton = makeCloseButton()
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var cell1 = makeCell()
    lazy var cell2 = makeCell()
    lazy var cell3 = makeCell()
    lazy var leftOptionButton = makeProductButton()
    lazy var rightOptionButton = makeProductButton()
    lazy var securedImageView = makeSecuredImageView()
    lazy var securedLabel = makeSecuredLabel()
    lazy var continueButton = makeContinueButton()
    lazy var termsOfServiceButton = makeTermsOfServiceButton()
    lazy var privacyPolicyButton = makePrivacyPolicyButton()
    lazy var restoreButton = makeRestoreButton()
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

// MARK: Public
extension PaygateView {
    func setup(questionsCount: Int) {
        cell1.setup(text: "Paygate.Cell1".localized)
        cell2.setup(text: String(format: "Paygate.Cell2".localized, questionsCount))
        cell3.setup(text: "Paygate.Cell3".localized)
    }
}

// MARK: Private
private extension PaygateView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func productTapped(sender: UIButton) {
        guard let productButton = sender as? PaygateProductButton else {
            return
        }
        
        [leftOptionButton, rightOptionButton].forEach { $0.isChecked = false }
        
        productButton.isChecked = true
    }
}

// MARK: Make constraints
private extension PaygateView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 49.scale : 31.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 120.scale : 90.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 170.scale : 127.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 70.scale : 39.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 20.scale : 13.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell1.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell1.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 12.scale),
            cell1.heightAnchor.constraint(equalToConstant: 22.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell2.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell2.topAnchor.constraint(equalTo: cell1.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 10.scale : 8.scale),
            cell2.heightAnchor.constraint(equalToConstant: 22.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell3.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell3.topAnchor.constraint(equalTo: cell2.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 10.scale : 8.scale),
            cell3.heightAnchor.constraint(equalToConstant: 44.scale)
        ])
        
        NSLayoutConstraint.activate([
            leftOptionButton.widthAnchor.constraint(equalToConstant: 161.scale),
            leftOptionButton.heightAnchor.constraint(equalToConstant: 185.scale),
            leftOptionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            leftOptionButton.topAnchor.constraint(equalTo: cell3.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            rightOptionButton.widthAnchor.constraint(equalToConstant: 161.scale),
            rightOptionButton.heightAnchor.constraint(equalToConstant: 185.scale),
            rightOptionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            rightOptionButton.topAnchor.constraint(equalTo: cell3.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 55.scale),
            continueButton.topAnchor.constraint(equalTo: leftOptionButton.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 20.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            securedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            securedLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 12.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            termsOfServiceButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            termsOfServiceButton.widthAnchor.constraint(equalTo: privacyPolicyButton.widthAnchor, multiplier: 1),
            termsOfServiceButton.heightAnchor.constraint(equalToConstant: 16.scale),
            termsOfServiceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -34.scale : -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            privacyPolicyButton.leadingAnchor.constraint(equalTo: termsOfServiceButton.trailingAnchor),
            privacyPolicyButton.widthAnchor.constraint(equalTo: restoreButton.widthAnchor, multiplier: 1),
            privacyPolicyButton.heightAnchor.constraint(equalToConstant: 16.scale),
            privacyPolicyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -34.scale : -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.leadingAnchor.constraint(equalTo: privacyPolicyButton.trailingAnchor),
            restoreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            restoreButton.heightAnchor.constraint(equalToConstant: 16.scale),
            restoreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -34.scale : -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            preloader.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateView {
    func makeCloseButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.alpha = 0.3
        view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: ScreenSize.isIphoneXFamily ? "Paygate.Image.X" : "Paygate.Image.8")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.black(size: 25.scale))
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Paygate.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell() -> PaygateInfoCell {
        let view = PaygateInfoCell()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProductButton() -> PaygateProductButton {
        let view = PaygateProductButton()
        view.backgroundColor = UIColor.clear
        view.layer.borderWidth = 2.scale
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(productTapped(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeSecuredImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.Secured")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSecuredLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.regular(size: 13.scale))
        
        let view = UILabel()
        view.attributedText = "Paygate.Secured".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 15.scale))
            .letterSpacing(-0.17.scale)
        
        let view = UIButton()
        view.setAttributedTitle("Continue".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = Appearance.primary
        view.layer.cornerRadius = 27.5.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTermsOfServiceButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 13.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate.TermsOfUse".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePrivacyPolicyButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 13.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate.PrivacyPolicy".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRestoreButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 13.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate.RestorePurchases".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor.clear
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

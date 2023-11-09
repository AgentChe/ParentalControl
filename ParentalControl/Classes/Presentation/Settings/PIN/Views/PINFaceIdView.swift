//
//  PINFaceIdView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import LocalAuthentication

final class PINFaceIdView: UIView {
    var didSkip: (() -> Void)?
    var didCompleted: (() -> Void)?
    
    lazy var skipButton = makeSkipButton()
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var continueButton = makeContinueButton()
    
    private let faceIdAuth: FaceIdAuth
    
    init(vc: UIViewController?) {
        self.faceIdAuth = FaceIdAuth(vc: vc)
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PINFaceIdView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func didTapContinue() {
        faceIdAuth.auth { [weak self] in
            self?.didCompleted?()
        }
    }
    
    @objc
    func didTapSkip() {
        didSkip?()
    }
}

// MARK: Make constraints
private extension PINFaceIdView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 87.scale : 50.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 72.scale),
            imageView.heightAnchor.constraint(equalToConstant: 72.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 321.scale : 160.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            continueButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PINFaceIdView {
    func makeSkipButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Onboarding.FaceId")
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
        view.attributedText = "Onboarding.FaceId.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.FaceId.SubTitle".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Onboarding.FaceId.ContinueButton".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 27.5.scale
        view.backgroundColor = Appearance.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        addSubview(view)
        return view
    }
}

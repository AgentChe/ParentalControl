//
//  OWelcomeView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

final class OWelcomeView: OSlideView {
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var dot1View = makeDotView(selected: number == 1)
    lazy var dot2View = makeDotView(selected: number == 2)
    lazy var dot3View = makeDotView(selected: number == 3)
    lazy var button = makeButton()
    
    private let number: Int
    
    init(number: Int, step: OnboardingView.Step) {
        self.number = number
        
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OWelcomeView {
    func initialize() {
        backgroundColor = Appearance.background
    }
}

// MARK: Make constraints
private extension OWelcomeView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 296.scale),
            imageView.heightAnchor.constraint(equalToConstant: 296.scale),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 157.scale : 60.scale)
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
            dot1View.widthAnchor.constraint(equalToConstant: 8.scale),
            dot1View.heightAnchor.constraint(equalToConstant: 8.scale),
            dot1View.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            dot1View.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            dot2View.widthAnchor.constraint(equalToConstant: 8.scale),
            dot2View.heightAnchor.constraint(equalToConstant: 8.scale),
            dot2View.leadingAnchor.constraint(equalTo: dot1View.trailingAnchor, constant: 8.scale),
            dot2View.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            dot3View.widthAnchor.constraint(equalToConstant: 8.scale),
            dot3View.heightAnchor.constraint(equalToConstant: 8.scale),
            dot3View.leadingAnchor.constraint(equalTo: dot2View.trailingAnchor, constant: 8.scale),
            dot3View.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale),
            button.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OWelcomeView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.Welcome\(number)")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.bold(size: 32.scale))
            .lineHeight(38.4.scale)
            .textAlignment(.left)
        
        let string = "Onboarding.Welcome\(number).Title".localized
        
        let view = UILabel()
        view.attributedText = string.attributed(with: attrs)
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
            .textAlignment(.left)
        
        let string = "Onboarding.Welcome\(number).SubTitle".localized
        
        let view = UILabel()
        view.attributedText = string.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDotView(selected: Bool) -> CircleView {
        let view = CircleView()
        view.backgroundColor = Appearance.secondary.withAlphaComponent(selected ? 1 : 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        var string: String? {
            switch number {
            case 1, 2:
                return "Next".localized
            case 3:
                return "Continue".localized
            default:
                return nil
            }
        }
        
        let view = UIButton()
        view.setAttributedTitle(string?.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 27.5.scale
        view.backgroundColor = Appearance.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        addSubview(view)
        return view
    }
}

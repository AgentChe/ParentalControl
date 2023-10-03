//
//  OChildAgeView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

final class OChildAgeView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var gridHeader = makeGridHeader()
    lazy var gridView = makeGridView()
    lazy var year1Button = makeYearButton()
    lazy var year2Button = makeYearButton()
    lazy var year3Button = makeYearButton()
    lazy var year4Button = makeYearButton()
    lazy var year5Button = makeYearButton()
    lazy var year6Button = makeYearButton()
    lazy var year7Button = makeYearLeftCornerButton()
    lazy var year8Button = makeYearButton()
    lazy var year9Button = makeYearRightCornerButton()
    lazy var earlierButton = makeEarlierButton()
    lazy var continueButton = makeContinueButton()
    
    private lazy var yearsButtons = [
        year1Button,
        year2Button,
        year3Button,
        year4Button,
        year5Button,
        year6Button,
        year7Button,
        year8Button,
        year9Button
    ]
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        changeEnabled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OChildAgeView {
    func initialize() {
        backgroundColor = Appearance.background
        
        let currentYear = Calendar.current.dateComponents([.year], from: Date()).year ?? 2023
        year1Button.setup(year: currentYear)
        year2Button.setup(year: currentYear - 1)
        year3Button.setup(year: currentYear - 2)
        year4Button.setup(year: currentYear - 3)
        year5Button.setup(year: currentYear - 4)
        year6Button.setup(year: currentYear - 5)
        year7Button.setup(year: currentYear - 6)
        year8Button.setup(year: currentYear - 7)
        year9Button.setup(year: currentYear - 8)
        
        let earlier = String(format: "Onboarding.ChildAge.EarlierButton".localized, currentYear - 9)
        earlierButton.text = earlier
    }
    
    @objc
    func didTapYear(sender: UIButton) {
        guard let yearButton = sender as? YearButton else {
            return
        }
        
        yearsButtons.forEach { $0.marked = false }
        yearButton.marked = true
        earlierButton.marked = false
        
        changeEnabled()
    }
    
    @objc
    func didTapSelectEarlierYear() {
        yearsButtons.forEach { $0.marked = false }
        earlierButton.marked = true
        
        changeEnabled()
    }
    
    func changeEnabled() {
        let marked = yearsButtons.contains(where: { $0.marked }) || earlierButton.marked
        
        continueButton.isEnabled = marked
        continueButton.alpha = marked ? 1 : 0.4
    }
}

// MARK: Make constraints
private extension OChildAgeView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 124.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            gridHeader.widthAnchor.constraint(equalToConstant: 306.scale),
            gridHeader.heightAnchor.constraint(equalToConstant: 57.scale),
            gridHeader.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 52.scale),
            gridHeader.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gridView.leadingAnchor.constraint(equalTo: gridHeader.leadingAnchor),
            gridView.trailingAnchor.constraint(equalTo: gridHeader.trailingAnchor),
            gridView.topAnchor.constraint(equalTo: gridHeader.bottomAnchor),
            gridView.heightAnchor.constraint(equalToConstant: 207.scale)
        ])
        
        NSLayoutConstraint.activate([
            year1Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year1Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year1Button.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: 1.scale),
            year1Button.topAnchor.constraint(equalTo: gridView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            year2Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year2Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year2Button.centerXAnchor.constraint(equalTo: gridView.centerXAnchor),
            year2Button.topAnchor.constraint(equalTo: gridView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            year3Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year3Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year3Button.trailingAnchor.constraint(equalTo: gridView.trailingAnchor, constant: -1.scale),
            year3Button.topAnchor.constraint(equalTo: gridView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            year4Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year4Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year4Button.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: 1.scale),
            year4Button.topAnchor.constraint(equalTo: year1Button.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            year5Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year5Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year5Button.centerXAnchor.constraint(equalTo: gridView.centerXAnchor),
            year5Button.topAnchor.constraint(equalTo: year2Button.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            year6Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year6Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year6Button.trailingAnchor.constraint(equalTo: gridView.trailingAnchor, constant: -1.scale),
            year6Button.topAnchor.constraint(equalTo: year3Button.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            year7Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year7Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year7Button.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: 1.scale),
            year7Button.topAnchor.constraint(equalTo: year4Button.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            year8Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year8Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year8Button.centerXAnchor.constraint(equalTo: gridView.centerXAnchor),
            year8Button.topAnchor.constraint(equalTo: year5Button.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            year9Button.widthAnchor.constraint(equalToConstant: 100.scale),
            year9Button.heightAnchor.constraint(equalToConstant: 66.scale),
            year9Button.trailingAnchor.constraint(equalTo: gridView.trailingAnchor, constant: -1.scale),
            year9Button.topAnchor.constraint(equalTo: year6Button.bottomAnchor, constant: 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            earlierButton.widthAnchor.constraint(equalToConstant: 210.scale),
            earlierButton.heightAnchor.constraint(equalToConstant: 47.scale),
            earlierButton.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 30.scale),
            earlierButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OChildAgeView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.ChildAge.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeGridHeader() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "Onboarding.ChildAge")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeGridView() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.background2
        view.layer.cornerRadius = 20.scale
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeYearButton() -> YearButton {
        let view = YearButton()
        view.backgroundColor = Appearance.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapYear(sender:)), for: .touchUpInside)
        gridView.addSubview(view)
        return view
    }
    
    func makeYearLeftCornerButton() -> YearButton {
        let view = YearButton()
        view.layer.cornerRadius = 20.scale
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.backgroundColor = Appearance.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapYear(sender:)), for: .touchUpInside)
        gridView.addSubview(view)
        return view
    }
    
    func makeYearRightCornerButton() -> YearButton {
        let view = YearButton()
        view.layer.cornerRadius = 20.scale
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.backgroundColor = Appearance.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapYear(sender:)), for: .touchUpInside)
        gridView.addSubview(view)
        return view
    }
    
    func makeEarlierButton() -> EarlierButton {
        let view = EarlierButton()
        view.layer.cornerRadius = 23.5.scale
        view.backgroundColor = Appearance.background2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapSelectEarlierYear), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Continue".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 27.5.scale
        view.backgroundColor = Appearance.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        addSubview(view)
        return view
    }
}

//
//  OScreenTimeLimitView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

protocol OScreenTimeLimitViewDelegate: AnyObject {
    func screenTimeLimitDidSelect(timeLimit: TimeLimit)
}

final class OScreenTimeLimitView: OSlideView {
    weak var mainDelegate: OScreenTimeLimitViewDelegate?
    
    lazy var skipButton = makeSkipButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var timePicker = makeTimePicker()
    lazy var continueButton = makeContinueButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OScreenTimeLimitView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func didTapContinue() {
        let totalMinutes = timePicker.totalMinutes
        let schedule = WeekSchedule(
            su: false,
            mo: true,
            tu: true,
            we: true,
            th: true,
            fr: true,
            sa: false
        )
        let timeLimit = TimeLimit(
            minutes: totalMinutes,
            schedule: schedule
        )
        
        mainDelegate?.screenTimeLimitDidSelect(timeLimit: timeLimit)

        onNext()
    }
}

// MARK: Make constraints
private extension OScreenTimeLimitView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 67.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 124.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            timePicker.widthAnchor.constraint(equalToConstant: 264.scale),
            timePicker.heightAnchor.constraint(equalToConstant: 256.scale),
            timePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 96.scale)
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
private extension OScreenTimeLimitView {
    func makeSkipButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.ScreenTimeLimit.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTimePicker() -> OScreenTimeLimitPicker {
        let view = OScreenTimeLimitPicker()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        view.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        addSubview(view)
        return view
    }
}

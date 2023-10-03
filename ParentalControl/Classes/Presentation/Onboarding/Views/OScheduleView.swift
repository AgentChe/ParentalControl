//
//  OScheduleView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 28.09.2023.
//

import UIKit

protocol OScheduleViewDelegate: AnyObject {
    func scheduleViewDidSet(schedule: WeekSchedule)
}

final class OScheduleView: OSlideView {
    weak var mainDelegate: OScheduleViewDelegate?
    
    lazy var titleLabel = makeTitleLabel()
    lazy var suButton = makeWeekdayButton(title: "Onboarding.Weekday.Su".localized)
    lazy var moButton = makeWeekdayButton(title: "Onboarding.Weekday.Mo".localized)
    lazy var tuButton = makeWeekdayButton(title: "Onboarding.Weekday.Tu".localized)
    lazy var weButton = makeWeekdayButton(title: "Onboarding.Weekday.We".localized)
    lazy var thButton = makeWeekdayButton(title: "Onboarding.Weekday.Th".localized)
    lazy var frButton = makeWeekdayButton(title: "Onboarding.Weekday.Fr".localized)
    lazy var saButton = makeWeekdayButton(title: "Onboarding.Weekday.Sa".localized)
    lazy var continueButton = makeContinueButton()
    
    private lazy var weekdaysButtons = [
        suButton,
        moButton,
        tuButton,
        weButton,
        thButton,
        frButton,
        saButton
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
private extension OScheduleView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func didTapWeekday(sender: UIButton) {
        guard let weekdayButton = sender as? WeekdayButton else  {
            return
        }
        
        weekdayButton.marked.toggle()
        
        changeEnabled()
    }
    
    @objc
    func didTapContinue() {
        let schedule = WeekSchedule(
            su: suButton.marked,
            mo: moButton.marked,
            tu: tuButton.marked,
            we: weButton.marked,
            th: thButton.marked,
            fr: frButton.marked,
            sa: saButton.marked
        )
        
        mainDelegate?.scheduleViewDidSet(schedule: schedule)
        
        onNext()
    }
    
    func changeEnabled() {
        let selected = weekdaysButtons.contains(where: { $0.marked })
        
        continueButton.isEnabled = selected
        continueButton.alpha = selected ? 1 : 0.4
    }
}

// MARK: Make constraints
private extension OScheduleView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 124.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            suButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.5.scale),
            suButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 131.scale)
        ])
        
        NSLayoutConstraint.activate([
            moButton.leadingAnchor.constraint(equalTo: suButton.trailingAnchor, constant: 12.scale),
            moButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 131.scale)
        ])
        
        NSLayoutConstraint.activate([
            tuButton.leadingAnchor.constraint(equalTo: moButton.trailingAnchor, constant: 12.scale),
            tuButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 131.scale)
        ])
        
        NSLayoutConstraint.activate([
            weButton.leadingAnchor.constraint(equalTo: tuButton.trailingAnchor, constant: 12.scale),
            weButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 131.scale)
        ])
        
        NSLayoutConstraint.activate([
            thButton.leadingAnchor.constraint(equalTo: weButton.trailingAnchor, constant: 12.scale),
            thButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 131.scale)
        ])
        
        NSLayoutConstraint.activate([
            frButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 125.5.scale),
            frButton.topAnchor.constraint(equalTo: suButton.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            saButton.leadingAnchor.constraint(equalTo: frButton.trailingAnchor, constant: 12.scale),
            saButton.topAnchor.constraint(equalTo: suButton.bottomAnchor, constant: 16.scale)
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
private extension OScheduleView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Schedule.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeWeekdayButton(title: String) -> WeekdayButton {
        let view = WeekdayButton(title: title)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapWeekday(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Onboarding.Schedule.ContinueButton".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 27.5.scale
        view.backgroundColor = Appearance.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        addSubview(view)
        return view
    }
}

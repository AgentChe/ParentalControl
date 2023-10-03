//
//  OPreloaderView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import UIKit
import RxSwift

final class OPreloaderView: OSlideView {
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var progressView = makeProgressView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var profileManager = ProfileManager()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
    
    private lazy var animationCompleted = false
    private lazy var requestCompleted = false
    
    private var timer: Timer?
    
    private let combineData: OnboardingCombineData
    private weak var vc: UIViewController?
    
    init(step: OnboardingView.Step, combineData: OnboardingCombineData, vc: UIViewController?) {
        self.combineData = combineData
        self.vc = vc
        
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        calculatePercent()
        request()
    }
}

// MARK: Private
private extension OPreloaderView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    func calculatePercent() {
        let duration = Float(7.5)
        var seconds = Float(0)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self else {
                return
            }
            
            seconds += 0.1
            
            var percent = seconds / duration
            if percent > 100 {
                percent = 100
            }
            
            self.progressView.progress = percent
            
            if seconds >= duration {
                timer.invalidate()
                
                self.calculatePercentFinish()
            }
        }
    }
    
    func request() {
        guard let data = combineData.combineData() else {
            return
        }
        
        func source() -> Single<Void> {
            profileManager
                .set(
                    screenTimeLimitMinutes: data.screenTimeLimitMinutes,
                    schedule: data.schedule,
                    pin: data.pin,
                    email: data.email
                )
        }
        
        func error(err: Error) -> Observable<Void> {
            open(error: err)
        }
        
        observableRetrySingle
            .retry(source: { source() },
                   trigger: { error(err: $0) })
            .asDriver(onErrorDriveWith: .never())
            .drive(Binder(self) { base, void in
                base.requestCompleted = true
                base.checkCompleted()
            })
            .disposed(by: disposeBag)
    }
    
    func calculatePercentFinish() {
        timer = nil
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.animationCompleted = true
            self?.checkCompleted()
        }
    }
    
    func checkCompleted() {
        guard animationCompleted && requestCompleted else {
            return
        }
        
        onNext()
    }
    
    func open(error: Error) -> Observable<Void> {
        Observable<Void>
            .create { [weak self] observe in
                guard let self = self else {
                    return Disposables.create()
                }
                
                let vc = TryAgainViewController.make(error: error) {
                    observe.onNext(())
                }
                self.vc?.present(vc, animated: true)
                
                return Disposables.create()
            }
    }
}

// MARK: Make constraints
private extension OPreloaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 188.scale),
            imageView.heightAnchor.constraint(equalToConstant: 188.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 190.scale : 60.scale)
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
            progressView.widthAnchor.constraint(equalToConstant: 180.scale),
            progressView.heightAnchor.constraint(equalToConstant: 12.scale),
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OPreloaderView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Onboarding.Preloader")
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
        view.attributedText = "Onboarding.Preloader.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Preloader.SubTitle".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProgressView() -> UIProgressView {
        let view = UIProgressView()
        view.trackTintColor = Appearance.background2
        view.progressTintColor = Appearance.third
        view.layer.cornerRadius = 6.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

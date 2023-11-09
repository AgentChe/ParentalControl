//
//  PinMenuView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import RxSwift

final class PinMenuView: UIView {
    var didResetTap: (() -> Void)?
    
    lazy var shadow = makeShadow()
    lazy var container = makeContainer()
    lazy var resetPINButton = makeResetPINButton()
    lazy var faceIdToggleView = makeFaceIdToggleView()
    
    private lazy var disposeBag = DisposeBag()
    
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
private extension PinMenuView {
    func initialize() {
        backgroundColor = Appearance.background
        
        faceIdToggleView.didChangeToggle = { [weak self] enable in
            enable ? self?.faceIdAuth.auth() : self?.faceIdAuth.invalidate()
        }
        
        FaceIdAuthMediator.shared.didChangeStatus
            .startWith(FaceIdAuth.isEnable)
            .emit(to: Binder(self) { base, enable in
                base.faceIdToggleView.switchView.isOn = enable
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func resetTapped() {
        didResetTap?()
    }
}

// MARK: Make constraints
private extension PinMenuView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            shadow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            shadow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            shadow.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: shadow.leadingAnchor, constant: 3.scale),
            container.trailingAnchor.constraint(equalTo: shadow.trailingAnchor, constant: -3.scale),
            container.topAnchor.constraint(equalTo: shadow.topAnchor, constant: 3.scale),
            container.bottomAnchor.constraint(equalTo: shadow.bottomAnchor, constant: -6.scale)
        ])
        
        NSLayoutConstraint.activate([
            resetPINButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            resetPINButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            resetPINButton.topAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            faceIdToggleView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            faceIdToggleView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            faceIdToggleView.topAnchor.constraint(equalTo: resetPINButton.bottomAnchor),
            faceIdToggleView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PinMenuView {
    func makeShadow() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.background2
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.white
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        shadow.addSubview(view)
        return view
    }
    
    func makeResetPINButton() -> TitleValueButton {
        let view = TitleValueButton(title: "PIN.Menu.ResetPIN".localized)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
    
    func makeFaceIdToggleView() -> FaceIdToggle {
        let view = FaceIdToggle()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}

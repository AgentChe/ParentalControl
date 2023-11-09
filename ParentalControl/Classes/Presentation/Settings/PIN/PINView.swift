//
//  PINView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class PINView: UIView {
    enum Step: Int {
        case menu, pin, email, faceId
    }
    
    private lazy var didSetPINTrigger = PublishRelay<String>()
    private lazy var didSetEmailTrigger = PublishRelay<String>()
    private lazy var didSkipEmailTrigger = PublishRelay<Void>()
    private lazy var didCompletedFaceIdTrigger = PublishRelay<Void>()
    private lazy var didSkipFaceIdTrigger = PublishRelay<Void>()
    private lazy var didResetPINTrigger = PublishRelay<Void>()
    
    private var currentView: UIView = {
        let view = UIView()
        view.backgroundColor = Appearance.background
        return view
    }()
    
    private weak var vc: UIViewController?
    
    init(vc: UIViewController?) {
        self.vc = vc
        
        super.init(frame: .zero)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PINView {
    func setup(step: Step, scroll: Bool) {
        if scroll {
            self.scroll(to: step)
        } else {
            display(step: step)
        }
    }
    
    var didSetPIN: Signal<String> {
        didSetPINTrigger.asSignal()
    }
    
    var didSetEmail: Signal<String> {
        didSetEmailTrigger.asSignal()
    }
    
    var didSkipEmail: Signal<Void> {
        didSkipEmailTrigger.asSignal()
    }
    
    var didCompletedFaceId: Signal<Void> {
        didCompletedFaceIdTrigger.asSignal()
    }
    
    var didSkipFaceId: Signal<Void> {
        didSkipFaceIdTrigger.asSignal()
    }
    
    var didResetPIN: Signal<Void> {
        didResetPINTrigger.asSignal()
    }
}

// MARK: Private
private extension PINView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    func display(step: Step) {
        currentView.removeFromSuperview()
        currentView = view(for: step)
        
        currentView.frame.size = UIScreen.main.bounds.size
        currentView.frame.origin = CGPoint.zero
        addSubview(currentView)
    }
    
    func scroll(to step: Step) {
        let scrollToView = view(for: step)
        
        scrollToView.frame.size = UIScreen.main.bounds.size
        scrollToView.frame.origin = CGPoint(x: 375.scale, y: 0)
        addSubview(scrollToView)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.currentView.frame.origin = CGPoint(x: -375.scale, y: 0)
            scrollToView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            
            currentView.removeFromSuperview()
            
            self.currentView = scrollToView
        })
    }
    
    func view(for step: Step) -> UIView {
        switch step {
        case .menu:
            let view = PinMenuView(vc: vc)
            view.didResetTap = { [weak self] in
                self?.didResetPINTrigger.accept(Void())
            }
            return view
        case .pin:
            let view = PINCodeView()
            view.moveToThis()
            view.pinDidSet = { [weak self] pin in
                self?.didSetPINTrigger.accept(pin)
            }
            return view
        case .email:
            let view = PINSignUpView()
            view.moveToThis()
            view.didSetEmail = { [weak self] email in
                self?.didSetEmailTrigger.accept(email)
            }
            view.didSkip = { [weak self] in
                self?.didSkipEmailTrigger.accept(Void())
            }
            return view
        case .faceId:
            let view = PINFaceIdView(vc: vc)
            view.didCompleted = { [weak self] in
                self?.didCompletedFaceIdTrigger.accept(Void())
            }
            view.didSkip = { [weak self] in
                self?.didSkipFaceIdTrigger.accept(Void())
            }
            return view
        }
    }
}

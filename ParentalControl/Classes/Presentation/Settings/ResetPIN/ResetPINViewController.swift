//
//  ResetPINViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ResetPINViewController: UIViewController {
    lazy var mainView = ResetPINView()
    
    private lazy var viewModel = ResetPINViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var setPINTrigger = PublishRelay<String>()
    private lazy var inputPINTrigger = PublishRelay<String>()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.tryAgain = { [weak self] error -> Observable<Void> in
            guard let self = self else {
                return .never()
            }

            return self.open(error: error)
        }
        
        mainView.pinDidSet = { [weak self] pin in
            self?.inputPINTrigger.accept(pin)
        }
        
        let output = viewModel.configure(input: ResetPINViewModel.Input(
            forgotPIN: mainView.forgotButton.rx.tap.asSignal(),
            setPIN: setPINTrigger.asSignal(),
            inputPIN: inputPINTrigger.asSignal()
        ))
        
        output.emailAvailable
            .drive(Binder(self) { base, available in
                base.email(available: available)
            })
            .disposed(by: disposeBag)
        
        output.state
            .drive(Binder(self) { base, state in
                base.state(state)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        resetInput()
    }
}

// MARK: Public
extension ResetPINViewController {
    static func make() -> ResetPINViewController {
        let vc = ResetPINViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "ResetPIN.Title".localized
        return vc
    }
}

// MARK: Private
private extension ResetPINViewController {
    func open(error: Error) -> Observable<Void> {
        Observable<Void>
            .create { [weak self] observe in
                guard let self = self else {
                    return Disposables.create()
                }
                
                let vc = TryAgainViewController.make(error: error) {
                    observe.onNext(())
                }
                self.present(vc, animated: true)
                
                return Disposables.create()
            }
    }
    
    func email(available: Bool) {
        mainView.forgotButton.isHidden = !available
        mainView.emailNotSetLabel.isHidden = available
    }
    
    func state(_ state: ResetPINViewModel.State) {
        let title: String
        
        switch state {
        case .enter(let correct):
            title = "ResetPIN.EnterPIN".localized
            
            if !correct {
                openAlert(title: "ResetPIN.IncorrectPIN".localized) { [weak self] in
                    self?.resetInput()
                }
            }
        case .set:
            title = "ResetPIN.Set".localized
            
            resetInput()
        case .confirm(let correct, let pin):
            title = "ResetPIN.Confirm".localized
            
            if !correct {
                openAlert(title: "ResetPIN.IncorrectPIN".localized) { [weak self] in
                    self?.resetInput()
                }
            } else if let pin {
                setPINTrigger.accept(pin)
            }
            
            resetInput()
        }
        
        mainView.titleLabel.attributedText = title.attributed(with: mainView.titleAttrs)
    }
    
    func route(_ route: ResetPINViewModel.Route) {
        switch route {
        case .checkEmail(let email):
            openAlert(
                title: "ResetPIN.CheckEmail.Title".localized,
                message: String(format: "ResetPIN.CheckEmail.Message".localized, email)
            ) 
        case .pinSet:
            openAlert(title: "ResetPIN.PINSet".localized) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func resetInput() {
        mainView.codesFields.forEach { $0.textField.text = "" }
        mainView.code1Field.textField.becomeFirstResponder()
    }
    
    func openAlert(title: String? = nil, message: String? = nil, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK".localized, style: .default) { action in
            handler?()
        }
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

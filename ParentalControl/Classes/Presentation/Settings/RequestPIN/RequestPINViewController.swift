//
//  RequestPINViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 09.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class RequestPINViewController: UIViewController {
    enum Mode {
        case root, present
    }
    
    lazy var mainView = RequestPINView()
    
    private lazy var viewModel = RequestPINViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var inputPINTrigger = PublishRelay<String>()
    private lazy var unblockedByFaceIdTrigger = PublishRelay<Void>()
    
    private lazy var faceIdAuth = FaceIdAuth(vc: self)
    
    private let mode: Mode
    
    private init(mode: Mode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let output = viewModel.configure(input: RequestPINViewModel.Input(
            forgotPIN: mainView.forgotButton.rx.tap.asSignal(),
            inputPIN: inputPINTrigger.asSignal(),
            unblockedByFaceId: unblockedByFaceIdTrigger.asSignal()
        ))
        
        output.emailAvailable
            .drive(Binder(self) { base, available in
                base.email(available: available)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        resetInput()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        unblockByFaceIdIfAvailable()
    }
}

// MARK: Public
extension RequestPINViewController {
    static func make(mode: Mode) -> RequestPINViewController {
        let vc = RequestPINViewController(mode: mode)
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension RequestPINViewController {
    func unblockByFaceIdIfAvailable() {
        guard FaceIdAuth.isEnable else {
            return
        }
        
        faceIdAuth.auth { [weak self] in
            self?.unblockedByFaceIdTrigger.accept(Void())
        }
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
                self.present(vc, animated: true)
                
                return Disposables.create()
            }
    }
    
    func email(available: Bool) {
        mainView.forgotButton.isHidden = !available
        mainView.emailNotSetLabel.isHidden = available
    }
    
    func route(_ route: RequestPINViewModel.Route) {
        switch route {
        case .checkEmail(let email):
            openAlert(
                title: "ResetPIN.CheckEmail.Title".localized,
                message: String(format: "ResetPIN.CheckEmail.Message".localized, email)
            )
        case .incorrectPINAlert:
            openAlert(title: "ResetPIN.IncorrectPIN".localized) { [weak self] in
                self?.resetInput()
            }
        case .unblock:
            unblocked()
        }
    }
    
    func unblocked() {
        switch mode {
        case .present:
            dismiss(animated: true)
        case .root:
            UIApplication.shared.keyWindow?.rootViewController = MainViewController.make()
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

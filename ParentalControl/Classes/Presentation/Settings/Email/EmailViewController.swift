//
//  EmailViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import RxSwift

final class EmailViewController: UIViewController {
    lazy var mainView = EmailView()
    
    private lazy var viewModel = EmailViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
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
        
        let didSave = mainView.saveButton.rx.tap
            .compactMap { [weak self] in self?.mainView.emailView.textField.text }
            .asSignal(onErrorSignalWith: .never())
        
        let output = viewModel.configure(input: EmailViewModel.Input(
            didSave: didSave
        ))
        
        output.initialEmail
            .drive(Binder(mainView.emailView) { base, email in
                base.textField.text = email
            })
            .disposed(by: disposeBag)
        
        output.activity
            .drive(Binder(mainView) { base, activity in
                base.saveButton.isHidden = activity
                activity ? base.preloader.startAnimating() : base.preloader.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        output.disposable
            .disposed(by: disposeBag)
        
        mainView.emailView.textField
            .becomeFirstResponder()
    }
}

// MARK: Public
extension EmailViewController {
    static func make() -> EmailViewController {
        let vc = EmailViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Email.Title".localized
        return vc
    }
}

// MARK: Private
private extension EmailViewController {
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
}

//
//  PINViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit

import RxSwift

final class PINViewController: UIViewController {
    lazy var mainView = PINView(vc: self)
    
    private lazy var viewModel = PINViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.didResetPIN
            .emit(to: Binder(self) { base, void in
                let vc = ResetPINViewController.make()
                base.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        let output = viewModel.configure(input: PINViewModel.Input(
            didSetPIN: mainView.didSetPIN,
            didSetEmail: mainView.didSetEmail,
            didSkipEmail: mainView.didSkipEmail,
            didCompletedFaceId: mainView.didCompletedFaceId,
            didSkipFaceId: mainView.didSkipFaceId
        ))
        
        output.step
            .drive(Binder(self) { base, step in
                base.step(step)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension PINViewController {
    static func make() -> PINViewController {
        let vc = PINViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "PIN.Title".localized
        return vc
    }
}

// MARK: Private
private extension PINViewController {
    func step(_ step: PINViewModel.Step) {
        switch step {
        case .display(let slide):
            mainView.setup(step: slide, scroll: false)
        case .scroll(let slide):
            mainView.setup(step: slide, scroll: true)
        }
    }
}

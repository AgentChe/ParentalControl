//
//  SettingsViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import RxSwift

final class SettingsViewController: UIViewController {
    lazy var mainView = SettingsView()
    
    private lazy var viewModel = SettingsViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.didTapLink
            .compactMap { URL(string: $0) }
            .emit(to: Binder(self) { base, url in
                UIApplication.shared.open(url)
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.didTapEmail
            .emit(to: Binder(self) { base, void in
                let vc = EmailViewController.make()
                base.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.didTapPIN
            .emit(to: Binder(self) { base, void in
                let vc = PINViewController.make()
                base.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        let output = viewModel.configure(input: SettingsViewModel.Input())
        
        output.elements
            .drive(Binder(mainView.tableView) { base, elements in
                base.setup(elements: elements)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension SettingsViewController {
    static func make() -> SettingsViewController {
        let vc = SettingsViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Settings.Title".localized
        return vc
    }
}

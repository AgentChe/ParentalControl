//
//  HomeViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import UIKit
import RxSwift
import SwiftUI
import DeviceActivity

final class HomeViewController: UIViewController {
    private lazy var settingsButton = UIButton()
    
    private lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.background
        
        addSettingsButton()
        addReportView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: Public
extension HomeViewController {
    static func make() -> HomeViewController {
        let vc = HomeViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension HomeViewController {
    func addSettingsButton() {
        settingsButton.setImage(UIImage(named: "Home.Settings"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 24.scale),
            settingsButton.heightAnchor.constraint(equalToConstant: 24.scale),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.scale),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        settingsButton.rx.tap
            .bind(to: Binder(self) { base, void in
                let vc = SettingsViewController.make()
                base.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func addReportView() {
        let filter = DeviceActivityFilter(
            segment: .daily(during: DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
                end: Date()
            )),
            users: .all,
            devices: .init([.iPhone])
        )

        let hostingVC = UIHostingController(rootView: DeviceActivityReport(.main, filter: filter))
        hostingVC.view.backgroundColor = Appearance.background
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingVC)
        view.addSubview(hostingVC.view)

        NSLayoutConstraint.activate([
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingVC.view.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 2.scale),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        hostingVC.didMove(toParent: parent)
        hostingVC.view.layoutIfNeeded()
    }
}

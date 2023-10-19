//
//  StatisticsViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 18.10.2023.
//

import UIKit
import SwiftUI
import DeviceActivity

final class StatisticsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.background
        
        let hostingVC = UIHostingController(rootView: DeviceActivityReport(.statistics))
        hostingVC.view.backgroundColor = Appearance.background
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        
        NSLayoutConstraint.activate([
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingVC.didMove(toParent: parent)
        hostingVC.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: Public
extension StatisticsViewController {
    static func make() -> StatisticsViewController {
        let vc = StatisticsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

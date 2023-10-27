//
//  WebHistoryViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import UIKit
import SwiftUI
import DeviceActivity

final class WebHistoryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.background
        
        let filter = DeviceActivityFilter(
            segment: .daily(during: DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
                end: Date()
            )),
            users: .all,
            devices: .init([.iPhone])
        )
        
        let hostingVC = UIHostingController(rootView: DeviceActivityReport(.webHistory, filter: filter))
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: Public
extension WebHistoryViewController {
    static func make() -> WebHistoryViewController {
        let vc = WebHistoryViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "WebHistory.Title".localized
        return vc
    }
}

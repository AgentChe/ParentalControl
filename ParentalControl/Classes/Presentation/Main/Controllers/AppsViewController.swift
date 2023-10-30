//
//  AppsViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import UIKit

final class AppsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.background
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: Public
extension AppsViewController {
    static func make() -> AppsViewController {
        let vc = AppsViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Main.Apps".localized
        return vc
    }
}

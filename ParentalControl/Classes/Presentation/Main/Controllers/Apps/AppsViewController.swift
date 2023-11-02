//
//  AppsViewController.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import UIKit
import SwiftUI
import FamilyControls

final class AppsViewController: UIHostingController<AppsRootView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Appearance.background
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: Public
extension AppsViewController {
    static func make() -> AppsViewController {
        let vc = AppsViewController(rootView: AppsRootView())
        vc.navigationItem.backButtonTitle = " " 
        return vc
    }
}

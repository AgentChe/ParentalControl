//
//  MainCoordinator.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import UIKit

final class MainCoordinator {
    weak var parentVC: MainViewController?
    
    lazy var homeVC = NavigationController(rootViewController: HomeViewController.make())
    lazy var statisticsVC = NavigationController(rootViewController: StatisticsViewController.make())
    lazy var apps = NavigationController(rootViewController: AppsViewController.make())
    
    private var previousVC: UIViewController?
    
    init(parentVC: MainViewController) {
        self.parentVC = parentVC
    }
    
    func change(tab: TabView.Tab) {
        parentVC?.mainView.tabView.selectedTab = tab
        
        switch tab {
        case .home:
            changeVC(on: homeVC)
        case .statistics:
            changeVC(on: statisticsVC)
        case .apps:
            changeVC(on: apps)
        }
    }
}

// MARK: Private
private extension MainCoordinator {
    func changeVC(on vc: UIViewController) {
        if let previousVC = self.previousVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
    
        self.previousVC = vc
        
        guard let parentVC = self.parentVC else {
            return
        }
    
        parentVC.addChild(vc)
        vc.view.frame = parentVC.mainView.container.bounds
        parentVC.mainView.container.addSubview(vc.view)
        vc.willMove(toParent: parentVC)
    }
}

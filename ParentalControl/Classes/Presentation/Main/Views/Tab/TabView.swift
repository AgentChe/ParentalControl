//
//  TabView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 06.10.2023.
//

import UIKit

final class TabView: UIView {
    enum Tab {
        case home, statistics, apps
    }
    
    var selectedTab = Tab.home {
        didSet {
            update()
        }
    }
    
    lazy var homeItem = makeItem(key: "Main.Home")
    lazy var statisticsItem = makeItem(key: "Main.Statistics")
    lazy var appsItem = makeItem(key: "Main.Apps")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabView {
    func update() {
        homeItem.marked = selectedTab == .home
        statisticsItem.marked = selectedTab == .statistics
        appsItem.marked = selectedTab == .apps
    }
}

// MARK: Make constraints
private extension TabView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            homeItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeItem.topAnchor.constraint(equalTo: topAnchor),
            homeItem.widthAnchor.constraint(equalTo: statisticsItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statisticsItem.leadingAnchor.constraint(equalTo: homeItem.trailingAnchor),
            statisticsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            statisticsItem.topAnchor.constraint(equalTo: topAnchor),
            statisticsItem.widthAnchor.constraint(equalTo: appsItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            appsItem.leadingAnchor.constraint(equalTo: statisticsItem.trailingAnchor),
            appsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            appsItem.topAnchor.constraint(equalTo: topAnchor),
            appsItem.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TabView {
    func makeItem(key: String) -> TabItemView {
        let view = TabItemView(key: key)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

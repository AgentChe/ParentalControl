//
//  HomeWebHistoryCell.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import SwiftUI

final class HostingTableViewCell<Content: View>: UITableViewCell {
    private weak var controller: UIHostingController<Content>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension HostingTableViewCell {
    func host(_ view: Content, parent: UIViewController?) {
        if let controller = controller {
            controller.rootView = view
            controller.view.layoutIfNeeded()
        } else {
            let hostingVC = UIHostingController(rootView: view)
            hostingVC.view.backgroundColor = UIColor.clear
            hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
            
            controller = hostingVC
            
            layoutIfNeeded()
            
            parent?.addChild(hostingVC)
            contentView.addSubview(hostingVC.view)
            
            NSLayoutConstraint.activate([
                hostingVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingVC.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingVC.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
            
            hostingVC.didMove(toParent: parent)
            hostingVC.view.layoutIfNeeded()
        }
    }
}

// MARK: Private
private extension HostingTableViewCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

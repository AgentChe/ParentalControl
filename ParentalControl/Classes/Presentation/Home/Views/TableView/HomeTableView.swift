//
//  HomeTableView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import UIKit
import SwiftUI
import DeviceActivity

final class HomeTableView: UITableView {
    lazy var elements = [HomeTableElement]()
    
    weak var vc: UIViewController?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension HomeTableView {
    func setup(elements: [HomeTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension HomeTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .seeMore(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SeeMoreCell.self)) as! SeeMoreCell
            cell.setup(element: element)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension HomeTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: Private
private extension HomeTableView {
    func initialize() {
        register(SeeMoreCell.self, forCellReuseIdentifier: String(describing: SeeMoreCell.self))
        
        dataSource = self
        delegate = self
    }
}

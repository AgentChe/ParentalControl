//
//  SettingsTableView.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 08.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsTableView: UITableView {
    lazy var elements = [SettingsTableElement]()
    
    private lazy var didTapLinkTrigger = PublishRelay<String>()
    private lazy var didTapEmailTrigger = PublishRelay<Void>()
    private lazy var didTapPINTrigger = PublishRelay<Void>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SettingsTableView {
    func setup(elements: [SettingsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didTapLink: Signal<String> {
        didTapLinkTrigger.asSignal()
    }
    
    var didTapEmail: Signal<Void> {
        didTapEmailTrigger.asSignal()
    }
    
    var didTapPIN: Signal<Void> {
        didTapPINTrigger.asSignal()
    }
}

// MARK: UITableViewDataSource
extension SettingsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .account(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SettingsAccountCell.self)) as! SettingsAccountCell
            cell.setup(element: element)
            cell.didTapEmail = { [weak self] in
                self?.didTapEmailTrigger.accept(Void())
            }
            cell.didTapPIN = { [weak self] in
                self?.didTapPINTrigger.accept(Void())
            }
            return cell
        case .route:
            let cell = dequeueReusableCell(withIdentifier: String(describing: SettingsRouteCell.self)) as! SettingsRouteCell
            cell.didTapPath = { [weak self] link in
                self?.didTapLinkTrigger.accept(link)
            }
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SettingsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: Private
private extension SettingsTableView {
    func initialize() {
        register(SettingsAccountCell.self, forCellReuseIdentifier: String(describing: SettingsAccountCell.self))
        register(SettingsRouteCell.self, forCellReuseIdentifier: String(describing: SettingsRouteCell.self))
        
        dataSource = self
        delegate = self
    }
}

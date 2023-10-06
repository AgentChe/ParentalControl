//
//  SeeMoreCell.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 05.10.2023.
//

import UIKit

final class SeeMoreCell: UITableViewCell {
    lazy var label = makeLabel()
    lazy var seeMoreLabel = makeSeeMoreLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(Appearance.black)
        .font(Fonts.Satoshi.bold(size: 20.scale))
        .lineHeight(28.scale)
        .textAlignment(.left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SeeMoreCell {
    func setup(element: HomeSeeMore) {
        label.attributedText = element.title.attributed(with: attrs)
    }
}

// MARK: Private
private extension SeeMoreCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension SeeMoreCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seeMoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.scale),
            seeMoreLabel.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SeeMoreCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSeeMoreLabel() -> PaddingLabel {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.medium(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.center)
        
        let view = PaddingLabel()
        view.attributedText = "Home.SeeMore".localized.attributed(with: attrs)
        view.insets = UIEdgeInsets(top: 7.scale, left: 12.scale, bottom: 7.scale, right: 12.scale)
        view.backgroundColor = Appearance.background2
        view.layer.cornerRadius = 16.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}

// MARK: Additional (HomeSeeMore)
private extension HomeSeeMore {
    var title: String {
        switch self {
        case .webHistory:
            return "Home.WebHistory".localized
        }
    }
}

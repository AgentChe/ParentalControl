//
//  PaygateInfoCell.swift
//  Manga
//
//  Created by Андрей Чернышев on 02.09.2022.
//

import UIKit

final class PaygateInfoCell: UIView {
    lazy var imageView = makeImageView()
    lazy var label = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygateInfoCell {
    func setup(text: String) {
        let attrs = TextAttributes()
            .textColor(Appearance.black)
            .font(Fonts.Satoshi.regular(size: 16.scale))
            .lineHeight(22.4.scale)
        label.attributedText = text.attributed(with: attrs)
    }
}

// MARK: Make constraints
private extension PaygateInfoCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 12.scale),
            imageView.heightAnchor.constraint(equalToConstant: 13.scale),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60.scale),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateInfoCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.CellChecked")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

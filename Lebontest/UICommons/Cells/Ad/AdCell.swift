//
//  AdCell.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

final class AdCell: UICollectionViewCell {

    private let subview = UIView()

    var viewModel: AdCellViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(subview)
    }

    private func setupLayout() {
        layoutMargins = .zero

        guard let subviewSuperview = subview.superview else {
            return assertionFailure("Image View has no super view")
        }

        subview.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            subview.topAnchor.constraint(equalTo: subviewSuperview.topAnchor),
            subview.bottomAnchor.constraint(equalTo: subviewSuperview.bottomAnchor),
            subview.leftAnchor.constraint(equalTo: subviewSuperview.leftAnchor),
            subview.rightAnchor.constraint(equalTo: subviewSuperview.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)}

    private func setupStyle() {
        contentView.backgroundColor = .clear
        subview.backgroundColor = DesignToken.shared.colorToken.textHighlighted
    }
}

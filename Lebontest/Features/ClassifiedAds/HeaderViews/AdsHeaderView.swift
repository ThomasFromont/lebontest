//
//  AdsHeaderView.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

class AdsHeaderView: UICollectionReusableView {

    private let imageView = UIImageView()

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
        addSubview(imageView)
    }

    private func setupLayout() {
        layoutMargins = .zero

        guard let imageViewSuperview = imageView.superview else {
            return assertionFailure("Image View has no super view")
        }

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: imageViewSuperview.topAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: imageViewSuperview.bottomAnchor, constant: -8),
            imageView.leftAnchor.constraint(equalTo: imageViewSuperview.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: imageViewSuperview.rightAnchor),
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
    }

    private func setupStyle() {
        backgroundColor = DesignToken.shared.colorToken.background
        imageView.image = Asset.logo.image
        imageView.contentMode = .scaleAspectFit
    }
}

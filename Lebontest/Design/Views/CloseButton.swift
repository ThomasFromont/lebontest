//
//  CloseButton.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class CloseButton: UIControl {

    private enum Constant {
        static let size = CGSize(width: 40, height: 40)
        static let imageSize = CGSize(width: 28, height: 28)
    }

    // MARK: - Properties

    private let imageView = UIImageView()
    private let designToken: DesignToken

    // MARK: - Initializers

    init(designToken: DesignToken) {
        self.designToken = designToken

        super.init(frame: .zero)

        setupHierarchy()
        setupLayout()
        setupStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? designToken.colorToken.divider : designToken.colorToken.background
        }
    }

    // MARK: - Hierarchy

    private func setupHierarchy() {
        addSubview(imageView)
    }

    // MARK: - Layout

    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: Constant.size.width),
            self.heightAnchor.constraint(equalToConstant: Constant.size.height),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageSize.height),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        isExclusiveTouch = true
        backgroundColor = designToken.colorToken.background
        layer.cornerRadius = Constant.size.width / 2

        imageView.image = Asset.iconClose.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = designToken.colorToken.textPrimary
    }
}

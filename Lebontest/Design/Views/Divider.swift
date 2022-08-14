//
//  Divider.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class Divider: UIView {

    private enum Constant {
        static let height: CGFloat = 0.5
        static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    // MARK: - Properties

    private let divider: UIView = UIView()
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

    // MARK: - Hierarchy

    private func setupHierarchy() {
        addSubview(divider)
    }

    // MARK: - Layout

    private func setupLayout() {
        divider.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            divider.heightAnchor.constraint(equalToConstant: Constant.height),
            divider.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            divider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            divider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.bottom),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        divider.backgroundColor = designToken.colorToken.divider
    }
}

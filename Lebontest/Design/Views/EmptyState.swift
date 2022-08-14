//
//  EmptyState.swift
//  Lebontest
//
//  Created by Thomas Fromont on 14/08/2022.
//

import UIKit

final class EmptyState: UIView, HasData {

    private enum Constant {
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    // MARK: - Nested

    struct Data {
        let title: String
        let button: String

        init(title: String, button: String) {
            self.title = title
            self.button = button
        }
    }

    // MARK: - Properties

    private let designToken: DesignToken

    private let titleLabel = UILabel()
    private let _button: Button

    // MARK: - Data

    var button: UIControl { _button }

    var data: Data? {
        didSet {
            titleLabel.text = data?.title
            _button.data = data.map { .init(title: $0.button) }
        }
    }

    // MARK: - Initializers

    init(designToken: DesignToken) {
        self.designToken = designToken
        _button = Button(designToken: designToken)

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
        addSubview(titleLabel)
        addSubview(button)
    }

    // MARK: - Layout

    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: Constant.insets.top),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),

            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        backgroundColor = .clear

        titleLabel.font = designToken.fontToken.title
        titleLabel.textColor = designToken.colorToken.textPrimary
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
}

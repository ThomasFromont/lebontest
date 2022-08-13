//
//  ItemInfo.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class ItemInfo: UIView, HasData {

    private enum Constant {
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let spacing: CGFloat = 16
    }

    // MARK: - Nested

    struct Data {
        public let title: String?
        public let subtitle: String

        public init(title: String?, subtitle: String) {
            self.title = title
            self.subtitle = subtitle
        }
    }

    // MARK: - Properties

    private let designToken: DesignToken

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Properties

    public var data: Data? {
        didSet {
            titleLabel.text = data?.title
            subtitleLabel.text = data?.subtitle
            stackView.spacing = data?.title == nil ? 0 : Constant.spacing
        }
    }

    // MARK: - Initializers

    init(designToken: DesignToken) {
        self.designToken = designToken

        super.init(frame: .zero)

        setupHierarchy()
        setupLayout()
        setupStyle()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Hierarchy

    private func setupHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }

    // MARK: - Layout

    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.top),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        backgroundColor = .clear

        stackView.axis = .vertical
        stackView.spacing = Constant.spacing

        titleLabel.font = designToken.fontToken.title
        titleLabel.textColor = designToken.colorToken.textPrimary
        titleLabel.numberOfLines = 1

        subtitleLabel.font = designToken.fontToken.info
        subtitleLabel.textColor = designToken.colorToken.textPrimary
        subtitleLabel.numberOfLines = 0
    }
}

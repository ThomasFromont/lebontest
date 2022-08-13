//
//  AdDetails.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class AdDetails: UIView, HasData {

    private enum Constant {
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let spacingTitles: CGFloat = 16
        static let spacingInfo: CGFloat = 8
        static let spacingTag: CGFloat = 16
        static let spacingCategory: CGFloat = 4
    }

    // MARK: - Nested

    struct Data {
        public let title: String
        public let subtitle: String
        public let category: String?
        public let info: String
        public let tag: String?

        public init(title: String, subtitle: String, category: String?, info: String, tag: String?) {
            self.title = title
            self.subtitle = subtitle
            self.category = category
            self.info = info
            self.tag = tag
        }
    }

    private let container = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let categoryView: HighlightedText
    private let infoStackView = UIStackView()
    private let infoLabel = UILabel()
    private let tagContainer = UIView()
    private let tagView: Tag
    private let designToken: DesignToken

    // MARK: - Properties

    public var data: Data? {
        didSet {
            titleLabel.text = data?.title
            subtitleLabel.text = data?.subtitle
            categoryView.data = data?.category.map { .init(text: $0) }
            infoLabel.text = data?.info
            tagView.data = data?.tag.map { .init(text: $0) }
            categoryView.isHidden = data?.category == nil
            tagView.isHidden = data?.tag == nil
            infoStackView.spacing = data?.tag == nil ? 0 : Constant.spacingTag
        }
    }

    // MARK: - Initializers

    init(designToken: DesignToken) {
        self.designToken = designToken
        categoryView = HighlightedText(designToken: designToken)
        tagView = Tag(designToken: designToken)

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
        addSubview(container)

        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        container.addSubview(categoryView)
        container.addSubview(infoStackView)

        infoStackView.addArrangedSubview(infoLabel)
        infoStackView.addArrangedSubview(tagContainer)

        tagContainer.addSubview(tagView)
    }

    // MARK: - Layout

    private func setupLayout() {
        container.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.top),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacingTitles),
            subtitleLabel.leftAnchor.constraint(equalTo: container.leftAnchor),

            categoryView.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor),
            categoryView.leftAnchor.constraint(equalTo: subtitleLabel.rightAnchor, constant: Constant.spacingCategory),
            categoryView.rightAnchor.constraint(lessThanOrEqualTo: container.rightAnchor),

            infoStackView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: Constant.spacingInfo),
            infoStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            infoStackView.leftAnchor.constraint(equalTo: container.leftAnchor),
            infoStackView.rightAnchor.constraint(equalTo: container.rightAnchor),

            tagView.topAnchor.constraint(equalTo: tagContainer.topAnchor),
            tagView.bottomAnchor.constraint(equalTo: tagContainer.bottomAnchor),
            tagView.leftAnchor.constraint(equalTo: tagContainer.leftAnchor),
            tagView.rightAnchor.constraint(lessThanOrEqualTo: tagContainer.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        backgroundColor = .clear

        infoStackView.axis = .vertical
        infoStackView.spacing = Constant.spacingTag

        titleLabel.font = designToken.fontToken.title
        titleLabel.numberOfLines = 0
        titleLabel.textColor = designToken.colorToken.textPrimary

        subtitleLabel.font = designToken.fontToken.title
        subtitleLabel.textColor = designToken.colorToken.textPrimary
        subtitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        infoLabel.font = designToken.fontToken.info
        infoLabel.textColor = designToken.colorToken.textPrimary
        infoLabel.numberOfLines = 1
    }
}

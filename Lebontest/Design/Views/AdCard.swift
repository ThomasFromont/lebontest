//
//  AdCard.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

final class AdCard: UIView, HasData {

    // MARK: - Nested

    enum Constant {
        static let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let imageHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 8
        static let infoCornerRadius: CGFloat = 12
        static let tagInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let textInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        static let infoInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        static let spacing: CGFloat = 4
    }

    // MARK: - Data

    struct Data {
        let image: UIImage?
        let title: String
        let subtitle: String
        let tag: String?
        let info: String?

        init(image: UIImage? = nil, title: String, subtitle: String, tag: String?, info: String?) {
            self.image = image
            self.title = title
            self.subtitle = subtitle
            self.tag = tag
            self.info = info
        }
    }

    // MARK: - Properties

    private let designToken: DesignToken

    private let cardContainer = UIView()
    private let imageView = UIImageView()
    private let tagView: Tag
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let infoContainer = UIView()
    private let infoView: HighlightedText

    var data: Data? {
        didSet {
            imageView.image = data?.image
            titleLabel.text = data?.title
            subtitleLabel.text = data?.subtitle
            infoView.data = data?.info.map { .init(text: $0) }
            tagView.data = data?.tag.map { .init(text: $0) }
            tagView.isHidden = data?.tag == nil
            infoContainer.isHidden = data?.info == nil
        }
    }

    // MARK: - Initializers

    init(designToken: DesignToken) {
        self.designToken = designToken
        infoView = HighlightedText(designToken: designToken)
        tagView = Tag(designToken: designToken)

        super.init(frame: .zero)

        setupViews()
        setupLayout()
        setupStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private func setupViews() {
        addSubview(cardContainer)
        cardContainer.addSubview(imageView)
        cardContainer.addSubview(tagView)
        cardContainer.addSubview(textStackView)
        cardContainer.addSubview(infoContainer)

        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        textStackView.addArrangedSubview(infoContainer)
        textStackView.addArrangedSubview(UIView())

        infoContainer.addSubview(infoView)
    }

    // MARK: - Layout

    private func setupLayout() {
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            cardContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            cardContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.bottom),
            cardContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            cardContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),

            imageView.topAnchor.constraint(equalTo: cardContainer.topAnchor),
            imageView.leftAnchor.constraint(equalTo: cardContainer.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: cardContainer.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),

            tagView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Constant.tagInsets.top),
            tagView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: Constant.tagInsets.left),
            tagView.rightAnchor.constraint(lessThanOrEqualTo: imageView.rightAnchor, constant: -Constant.tagInsets.right),

            textStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constant.textInsets.top),
            textStackView.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -Constant.textInsets.bottom),
            textStackView.leftAnchor.constraint(equalTo: cardContainer.leftAnchor, constant: Constant.textInsets.left),
            textStackView.rightAnchor.constraint(equalTo: cardContainer.rightAnchor, constant: -Constant.textInsets.right),

            infoView.topAnchor.constraint(equalTo: infoContainer.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor),
            infoView.leftAnchor.constraint(equalTo: infoContainer.leftAnchor),
            infoView.rightAnchor.constraint(lessThanOrEqualTo: infoContainer.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        isExclusiveTouch = true
        backgroundColor = designToken.colorToken.background

        cardContainer.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.cornerRadius

        textStackView.axis = .vertical
        textStackView.spacing = Constant.spacing

        titleLabel.font = designToken.fontToken.title
        titleLabel.textColor = designToken.colorToken.textPrimary
        titleLabel.numberOfLines = 2

        subtitleLabel.font = designToken.fontToken.subtitle
        subtitleLabel.textColor = designToken.colorToken.textPrimary
    }
}

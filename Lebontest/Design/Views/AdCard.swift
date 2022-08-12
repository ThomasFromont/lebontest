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
        static let tagCornerRadius: CGFloat = 4
        static let tagBorderWidth: CGFloat = 1
        static let tagInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let tagTextInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
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
    private let tagContainer = UIView()
    private let tagLabel = UILabel()
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let infoContainer = UIView()
    private let infoBackground = UIView()
    private let infoLabel = UILabel()

    public var data: Data? {
        didSet {
            imageView.image = data?.image
            titleLabel.text = data?.title
            subtitleLabel.text = data?.subtitle
            infoLabel.text = data?.info
            tagLabel.text = data?.tag
            tagContainer.isHidden = data?.tag == nil
            infoContainer.isHidden = data?.info == nil
        }
    }

    // MARK: - Initializers

    public init(designToken: DesignToken) {
        self.designToken = designToken

        super.init(frame: .zero)

        setupViews()
        setupLayout()
        setupStyle()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views

    private func setupViews() {
        addSubview(cardContainer)
        cardContainer.addSubview(imageView)
        cardContainer.addSubview(tagContainer)
        cardContainer.addSubview(textStackView)
        cardContainer.addSubview(infoContainer)

        tagContainer.addSubview(tagLabel)

        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        textStackView.addArrangedSubview(infoContainer)
        textStackView.addArrangedSubview(UIView())

        infoContainer.addSubview(infoBackground)
        infoBackground.addSubview(infoLabel)
    }

    // MARK: - Layout

    private func setupLayout() {
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tagContainer.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        infoBackground.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            cardContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            cardContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.bottom),
            cardContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            cardContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),

            imageView.topAnchor.constraint(equalTo: cardContainer.topAnchor),
            imageView.leftAnchor.constraint(equalTo: cardContainer.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: cardContainer.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),

            tagContainer.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Constant.tagInsets.top),
            tagContainer.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: Constant.tagInsets.left),
            tagContainer.rightAnchor.constraint(lessThanOrEqualTo: imageView.rightAnchor, constant: -Constant.tagInsets.right),

            tagLabel.topAnchor.constraint(equalTo: tagContainer.topAnchor, constant: Constant.tagTextInsets.top),
            tagLabel.bottomAnchor.constraint(equalTo: tagContainer.bottomAnchor, constant: -Constant.tagTextInsets.bottom),
            tagLabel.leftAnchor.constraint(equalTo: tagContainer.leftAnchor, constant: Constant.tagTextInsets.left),
            tagLabel.rightAnchor.constraint(equalTo: tagContainer.rightAnchor, constant: -Constant.tagTextInsets.right),

            textStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constant.textInsets.top),
            textStackView.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -Constant.textInsets.bottom),
            textStackView.leftAnchor.constraint(equalTo: cardContainer.leftAnchor, constant: Constant.textInsets.left),
            textStackView.rightAnchor.constraint(equalTo: cardContainer.rightAnchor, constant: -Constant.textInsets.right),

            infoBackground.topAnchor.constraint(equalTo: infoContainer.topAnchor),
            infoBackground.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor),
            infoBackground.leftAnchor.constraint(equalTo: infoContainer.leftAnchor),
            infoBackground.rightAnchor.constraint(lessThanOrEqualTo: infoContainer.rightAnchor),

            infoLabel.topAnchor.constraint(equalTo: infoBackground.topAnchor, constant: Constant.infoInsets.top),
            infoLabel.bottomAnchor.constraint(equalTo: infoBackground.bottomAnchor, constant: -Constant.infoInsets.bottom),
            infoLabel.leftAnchor.constraint(equalTo: infoBackground.leftAnchor, constant: Constant.infoInsets.left),
            infoLabel.rightAnchor.constraint(equalTo: infoBackground.rightAnchor, constant: -Constant.infoInsets.right),
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

        tagContainer.backgroundColor = designToken.colorToken.background
        tagContainer.layer.cornerRadius = Constant.tagCornerRadius
        tagContainer.layer.borderColor = designToken.colorToken.textHighlighted.cgColor
        tagContainer.layer.borderWidth = Constant.tagBorderWidth

        tagLabel.font = designToken.fontToken.tag
        tagLabel.textColor = designToken.colorToken.textHighlighted
        tagLabel.numberOfLines = 1

        textStackView.axis = .vertical
        textStackView.spacing = Constant.spacing

        titleLabel.font = designToken.fontToken.title
        titleLabel.textColor = designToken.colorToken.textPrimary
        titleLabel.numberOfLines = 2

        subtitleLabel.font = designToken.fontToken.subtitle
        subtitleLabel.textColor = designToken.colorToken.textSecondary

        infoBackground.backgroundColor = designToken.colorToken.backgroundHighlighted
        infoBackground.layer.cornerRadius = Constant.infoCornerRadius

        infoLabel.font = designToken.fontToken.info
        infoLabel.textColor = designToken.colorToken.textHighlighted
        infoLabel.numberOfLines = 0
    }
}

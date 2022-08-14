//
//  Tag.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class Tag: UIView, HasData {

    // MARK: - Nested

    enum Constant {
        static let cornerRadius: CGFloat = 4
        static let borderWidth: CGFloat = 1
        static let insets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    }

    // MARK: - Data

    struct Data {
        let text: String

        init(text: String) {
            self.text = text
        }
    }

    // MARK: - Properties

    private let designToken: DesignToken

    private let tagLabel = UILabel()

    var data: Data? {
        didSet {
            tagLabel.text = data?.text
        }
    }

    // MARK: - Initializers

    init(designToken: DesignToken) {
        self.designToken = designToken

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
        addSubview(tagLabel)
    }

    // MARK: - Layout

    private func setupLayout() {
        tagLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            tagLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            tagLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.bottom),
            tagLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            tagLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        isExclusiveTouch = true
        backgroundColor = designToken.colorToken.background
        layer.cornerRadius = Constant.cornerRadius
        layer.borderColor = designToken.colorToken.highlighted.cgColor
        layer.borderWidth = Constant.borderWidth

        tagLabel.font = designToken.fontToken.tag
        tagLabel.textColor = designToken.colorToken.highlighted
        tagLabel.numberOfLines = 1
    }
}

//
//  HighlightedText.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class HighlightedText: UIView, HasData {

    // MARK: - Nested

    enum Constant {
        static let cornerRadius: CGFloat = 12
        static let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
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

    private let infoLabel = UILabel()

    var data: Data? {
        didSet {
            infoLabel.text = data?.text
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
        addSubview(infoLabel)
    }

    // MARK: - Layout

    private func setupLayout() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.bottom),
            infoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            infoLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        backgroundColor = designToken.colorToken.highlightedLight
        layer.cornerRadius = Constant.cornerRadius

        infoLabel.font = designToken.fontToken.info
        infoLabel.textColor = designToken.colorToken.highlighted
        infoLabel.numberOfLines = 0
    }
}

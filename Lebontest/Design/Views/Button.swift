//
//  Button.swift
//  Lebontest
//
//  Created by Thomas Fromont on 14/08/2022.
//

import UIKit

final class Button: UIControl, HasData {

    // MARK: - Nested

    enum Constant {
        static let cornerRadius: CGFloat = 4
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let titleInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    // MARK: - Data

    struct Data {
        let title: String

        init(title: String) {
            self.title = title
        }
    }

    // MARK: - Properties

    private let designToken: DesignToken

    private let container = UIView()
    private let title = UILabel()

    var data: Data? {
        didSet {
            title.text = data?.title
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

    override var isHighlighted: Bool {
        didSet {
            container.backgroundColor = isHighlighted ? designToken.colorToken.buttonHighlighted : designToken.colorToken.button
        }
    }

    // MARK: - Views

    private func setupViews() {
        addSubview(container)
        container.addSubview(title)
    }

    // MARK: - Layout

    private func setupLayout() {
        container.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.insets.top),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.insets.bottom),
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constant.insets.left),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constant.insets.right),

            title.topAnchor.constraint(equalTo: container.topAnchor, constant: Constant.titleInsets.top),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constant.titleInsets.bottom),
            title.leftAnchor.constraint(equalTo: container.leftAnchor, constant: Constant.titleInsets.left),
            title.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -Constant.titleInsets.right),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Style

    private func setupStyle() {
        isExclusiveTouch = true
        container.isUserInteractionEnabled = false
        container.backgroundColor = designToken.colorToken.button
        container.layer.cornerRadius = Constant.cornerRadius

        title.font = designToken.fontToken.navigationTitle
        title.textColor = designToken.colorToken.textButton
        title.numberOfLines = 1
        title.textAlignment = .center
    }
}

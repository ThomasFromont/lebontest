//
//  AdCell.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

final class AdCell: UICollectionViewCell {

    private let adCard = AdCard(designToken: DesignToken.shared)

    var viewModel: AdCellViewModel? {
        didSet {
            bind()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(adCard)
    }

    private func setupLayout() {
        layoutMargins = .zero

        adCard.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            adCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            adCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            adCard.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            adCard.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupStyle() {
        contentView.backgroundColor = .clear
    }

    private func bind() {
        adCard.data = viewModel.map { .init(title: $0.title, subtitle: $0.subtitle, tag: $0.tag, info: $0.info) }
        viewModel?.bind = updateData
        viewModel?.fetch()
    }

    private func updateData(_ data: AdCellViewModel.Data) {
        DispatchQueue.main.async {
            self.adCard.data = self.viewModel.map {
                .init(image: data.image, title: $0.title, subtitle: $0.subtitle, tag: $0.tag, info: $0.info)
            }
        }
    }
}

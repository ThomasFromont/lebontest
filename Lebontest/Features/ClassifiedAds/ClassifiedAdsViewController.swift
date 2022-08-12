//
//  ClassifiedAdsViewController.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import UIKit

final class ClassifiedAdsViewController: UIViewController {

    private enum Constant {
        static let headerHeight: CGFloat = 40
        static let cellHeight: CGFloat = 60
        static let collectionViewInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    // MARK: - Properties

    private let viewModel: ClassifiedAdsViewModel
    private let designToken: DesignToken

    private let collectionView: UICollectionView

    private var cellViewModels = [AdCellViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Initializer

    init(viewModel: ClassifiedAdsViewModel, designToken: DesignToken) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = .zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        self.viewModel = viewModel
        self.designToken = designToken

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupStyle()
        bind()
    }

    // MARK: - Setup

    func setupViews() {
        view.addSubview(collectionView)
    }

    func setupStyle() {
        view.backgroundColor = designToken.colorToken.background
        collectionView.backgroundColor = designToken.colorToken.background

        collectionView.register(AdsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(AdCell.self, forCellWithReuseIdentifier: "adCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setupLayout() {
        collectionView.contentInset = Constant.collectionViewInsets

        guard let collectionViewSuperview = collectionView.superview else {
            return assertionFailure("Image View has no super view")
        }

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: collectionViewSuperview.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewSuperview.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: collectionViewSuperview.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: collectionViewSuperview.rightAnchor),
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }

    func bind() {
        navigationItem.backButtonTitle = viewModel.navigationTitle

        viewModel.bind = updateData
        viewModel.fetch()
    }

    func updateData(_ data: ClassifiedAdsViewModel.Data) {
        DispatchQueue.main.async {
            self.cellViewModels = data.cells
        }
    }
}

extension ClassifiedAdsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: Constant.headerHeight)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "headerView",
            for: indexPath as IndexPath
        ) as? AdsHeaderView
        return headerView ?? UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - Constant.collectionViewInsets.left - Constant.collectionViewInsets.right) / 2
        return CGSize(width: width, height: Constant.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adCell", for: indexPath) as? AdCell
        let viewModel = cellViewModels[indexPath.item]
        cell?.viewModel = viewModel
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellViewModels[indexPath.item].select()
    }
}

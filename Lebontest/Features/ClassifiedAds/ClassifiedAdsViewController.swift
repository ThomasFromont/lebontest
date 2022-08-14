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
        static let cellHeight: CGFloat = 326
        static let collectionViewInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    // MARK: - Properties

    private let viewModel: ClassifiedAdsViewModel
    private let designToken: DesignToken

    private let collectionView: UICollectionView
    private let loaderView = UIActivityIndicatorView(style: .large)

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

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(loaderView)
    }

    private func setupStyle() {
        view.backgroundColor = designToken.colorToken.background

        loaderView.startAnimating()
        loaderView.hidesWhenStopped = true

        collectionView.backgroundColor = designToken.colorToken.background
        collectionView.register(AdsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(AdCell.self, forCellWithReuseIdentifier: "adCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayout() {
        collectionView.contentInset = Constant.collectionViewInsets

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),

            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func bind() {
        navigationItem.backButtonTitle = viewModel.navigationTitle

        viewModel.bind = updateState
        viewModel.fetch()
    }

    private func updateState(_ state: ClassifiedAdsViewModel.State) {
        DispatchQueue.main.async {
            switch state {
            case .success(let cellViewModels):
                self.cellViewModels = cellViewModels
                self.loaderView.stopAnimating()
            case .loading:
                self.loaderView.startAnimating()
            case .error(let error):
                self.loaderView.stopAnimating()
            }
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

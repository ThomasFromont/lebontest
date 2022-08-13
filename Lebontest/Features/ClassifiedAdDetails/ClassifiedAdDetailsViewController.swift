//
//  ClassifiedAdDetailsViewController.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

final class ClassifiedAdDetailsViewController: UIViewController {

    private enum Constant {
        static let closeButtonInsets = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 0)
    }

    // MARK: - Properties

    private let viewModel: ClassifiedAdDetailsViewModel
    private let designToken: DesignToken

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let statusBarBackground = UIView()
    private let closeButton: CloseButton
    private let headerView = UIImageView()
    private let adDetails: AdDetails
    private let descriptionView: ItemInfo
    private let siretView: ItemInfo

    // MARK: - Initializer

    init(viewModel: ClassifiedAdDetailsViewModel, designToken: DesignToken) {
        self.viewModel = viewModel
        self.designToken = designToken

        closeButton = CloseButton(designToken: designToken)
        adDetails = AdDetails(designToken: designToken)
        descriptionView = ItemInfo(designToken: designToken)
        siretView = ItemInfo(designToken: designToken)

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
        view.addSubview(scrollView)
        view.addSubview(statusBarBackground)
        view.addSubview(closeButton)

        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(adDetails)
        stackView.addArrangedSubview(Divider(designToken: designToken))
        stackView.addArrangedSubview(descriptionView)
        if viewModel.siret != nil {
            stackView.addArrangedSubview(Divider(designToken: designToken))
            stackView.addArrangedSubview(siretView)
        }
    }

    private func setupStyle() {
        view.backgroundColor = designToken.colorToken.background

        scrollView.alwaysBounceVertical = true
        stackView.axis = .vertical

        headerView.contentMode = .scaleAspectFill
        statusBarBackground.backgroundColor = designToken.colorToken.background.withAlphaComponent(0.5)
    }

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        statusBarBackground.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            headerView.widthAnchor.constraint(equalTo: headerView.heightAnchor),

            statusBarBackground.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusBarBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            statusBarBackground.rightAnchor.constraint(equalTo: view.rightAnchor),

            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constant.closeButtonInsets.top
            ),
            closeButton.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor,
                constant: Constant.closeButtonInsets.left
            ),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func bind() {
        navigationItem.backButtonTitle = viewModel.navigationTitle

        closeButton.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
        adDetails.data = .init(
            title: viewModel.title,
            subtitle: viewModel.price,
            category: viewModel.category,
            info: viewModel.date,
            tag: viewModel.tag
        )
        descriptionView.data = .init(title: viewModel.description.title, subtitle: viewModel.description.subtitle)
        siretView.data = viewModel.siret.map { .init(title: $0.title, subtitle: $0.subtitle) }

        viewModel.bind = updateData
        viewModel.fetch()
    }

    private func updateData(_ data: ClassifiedAdDetailsViewModel.Data) {
        DispatchQueue.main.async {
            self.headerView.image = data.image
        }
    }

    @objc
    func closeClicked(_ sender: AnyObject?) {
        viewModel.close()
    }
}

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
    private let statusBarBackground = UIView()
    private let closeButton: CloseButton
    private let headerView = UIImageView()

    // MARK: - Initializer

    init(viewModel: ClassifiedAdDetailsViewModel, designToken: DesignToken) {
        self.viewModel = viewModel
        self.designToken = designToken

        self.closeButton = CloseButton(designToken: designToken)

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

        scrollView.addSubview(headerView)
        scrollView.addSubview(closeButton)
    }

    private func setupStyle() {
        view.backgroundColor = designToken.colorToken.background

        headerView.contentMode = .scaleAspectFill
        statusBarBackground.backgroundColor = designToken.colorToken.background.withAlphaComponent(0.5)
    }

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        statusBarBackground.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),

            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            headerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
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

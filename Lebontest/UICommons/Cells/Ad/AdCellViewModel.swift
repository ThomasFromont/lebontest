//
//  AdCellViewModel.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

final class AdCellViewModel {

    // MARK: - Outputs

    // MARK: - Properties

    private let selectCompletion: (() -> Void)?

    // MARK: - Initializers

    init(selectCompletion: (() -> Void)? = nil) {
        self.selectCompletion = selectCompletion
    }

    func select() {
        selectCompletion?()
    }
}

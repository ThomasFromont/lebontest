//
//  MockClassifiedAdDetailsViewModelDelegate.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//-

@testable import Lebontest

class MockClassifiedAdDetailsViewModelDelegate: ClassifiedAdDetailsViewModelDelegate {

    private let onSelectClose: (() -> Void)?

    init(onSelectClose: (() -> Void)? = nil) {
        self.onSelectClose = onSelectClose
    }

    func didSelectClose(from: ClassifiedAdDetailsViewModel) {
        onSelectClose?()
    }
}

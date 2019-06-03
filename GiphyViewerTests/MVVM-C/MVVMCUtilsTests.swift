//
//  MVVMCUtilsTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class MVVMCUtilsTests: XCTestCase {

    func testMVVMCInstantiateMethod() {
        let viewController = FakeViewController.instantiate(with: FakeViewModelCoordinator())
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.viewModel.coordinator)
    }
}

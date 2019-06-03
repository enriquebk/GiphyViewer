//
//  MVVMViewTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class MVVMViewTests: XCTestCase {

    private let fakeViewModel = FakeViewModel()
    
    func testUIViewBinding() {
       
        let view = SpyViewMVVMView()
        
        view.bind(to: fakeViewModel)
        
        XCTAssertTrue(view.didCallBindViewModel)
        XCTAssertNotNil(view.viewModel)
    }
    
    func testUIViewControllerBinding() {
        
        let viewController = SpyViewControllerMVVMView()

        viewController.bind(to: fakeViewModel)
        
        XCTAssertTrue(viewController.didCallBindViewModel)
        XCTAssertTrue(viewController.didCallViewDidLoad)
        XCTAssertNotNil(viewController.viewModel)
    }
}

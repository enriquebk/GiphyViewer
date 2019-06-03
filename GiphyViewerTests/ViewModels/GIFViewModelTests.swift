//
//  GIFViewModelTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class GIFViewModelTests: XCTestCase {

    func testInit() {
    
        let gif = GIF(id: "gifID", title: "Title", images: [:])
        
        let viewModel = GIFViewModel(gif)
        
        XCTAssertEqual(gif, viewModel.gif.value)
    }
}

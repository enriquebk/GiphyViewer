//
//  SearchViewModelTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class SearchViewModelTests: XCTestCase {
    
    func testSearchGIFs() {
        
        let viewModel = SearchViewModel()
        let spyFetcher = SpyGifFetcher()
        viewModel.gifFetcher = spyFetcher
        
        let gifsExp = expectation(description: "gifs should be refreshed")
        gifsExp.expectedFulfillmentCount = 2
        viewModel.gifs.bind { _ in gifsExp.fulfill() }
       
        let searchingExp = expectation(description: "isSearching should be refreshed")
        searchingExp.expectedFulfillmentCount = 2
        viewModel.isSearching.bind { _ in searchingExp.fulfill() }
        
        let query = "query"
        viewModel.searchGIFs(with: query)
        
        XCTAssertEqual(query, spyFetcher.didSearch)
        XCTAssert(viewModel.isSearching.value)
        XCTAssert(viewModel.gifs.value.count == 0)
        
        waitForExpectations(timeout: 0.1)
    }

    func testLoadNewPage() {
        
        let viewModel = SearchViewModel()
        let spyFetcher = SpyGifFetcher()
        viewModel.gifFetcher = spyFetcher
        
        viewModel.loadNewPage()
        
        XCTAssert(spyFetcher.didCallLoadNewPage)
    }
    
    func testGetViewStateforGIF() {

        let testPreviewImage = Image(url: "http://media2.giphy.com/media/FiGiRei2ICzzG/giphy_s.gif", width: 500, height: 176)
        let testOriginalImage = Image(url: "http://media2.giphy.com/media/FiGiRei2ICzzG/giphy_s.gif", width: 300, height: 350)
        let testGif = GIF(id: "gifID", title: "Title", images: ["preview_gif": testPreviewImage, "original": testOriginalImage])
        
        let viewModel = SearchViewModel()
        viewModel.gifs.value = [testGif]
        
        let viewState = viewModel.getViewStateforGIF(at: 0)
        
        XCTAssertEqual(viewState?.previewURL, URL(string: testPreviewImage.url ?? ""))
        XCTAssertEqual(viewState?.titleString, testGif.title)
        
    }
    
    func testGetViewStateforGIFWithNoElements() {
        
        let viewModel = SearchViewModel()
        
        XCTAssert(viewModel.getViewStateforGIF(at: 0) == nil)
    }
    
    func testSelectGIF() {
        
        let testGif = GIF(id: "gifID", title: "Title", images: [:])
        
        let coordinator = SpyCoordinator()
        let viewModel = SearchViewModel()
        viewModel.coordinator = coordinator
        viewModel.gifs.value = [testGif]
        
        viewModel.selectGIF(at: 0)
        
        XCTAssertEqual(coordinator.gifToShow, testGif)
    }
    
    func testSelectGIFWithNoElements() {
        
        let coordinator = SpyCoordinator()
        let viewModel = SearchViewModel()
        viewModel.coordinator = coordinator
        
        viewModel.selectGIF(at: 0)
        
        XCTAssert(coordinator.gifToShow == nil)
    }

}

//
//  GifFetcherTest.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class GifFetcherTest: XCTestCase {

    func testLoadNewPage() {
        
        let spyDelegate = SpyGifFetcherDelegate()
        let apiClientStub = APIClientStub()
        let fetcher = GifFetcher()
        fetcher.delegate = spyDelegate
        fetcher.apiClient = apiClientStub
        
        fetcher.loadNewPage()
        
        XCTAssert(spyDelegate.newPageResult?.count == apiClientStub.testData.count )
    }
    
    func testSearchPage() {
        
        let spyDelegate = SpyGifFetcherDelegate()
        let apiClientStub = APIClientStub()
        let fetcher = GifFetcher()
        fetcher.delegate = spyDelegate
        fetcher.apiClient = apiClientStub
        
        fetcher.search(query: "query")
        
        XCTAssert(spyDelegate.searchResult?.count == apiClientStub.testData.count )
    }
}

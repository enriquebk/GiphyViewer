//
//  SpyGifFetcherDelegate.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class SpyGifFetcherDelegate: GifFetcherDelegate {
    
    var newPageResult: [GIF]?
    var searchResult: [GIF]?
    var error: Error?
    
    func fetcher(_ fetcher: GifFetcher, didFinishLoadingPage gifs: [GIF]?) {
        newPageResult = gifs
    }
    
    func fetcher(_ fetcher: GifFetcher, didFinishSearching gifs: [GIF]?) {
        searchResult = gifs
    }
    
    func fetcher(_ fetcher: GifFetcher, didFailWithError error: Error) {
        self.error = error
    }

}

//
//  SpyGifFetcher.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
@testable import GiphyViewer

class SpyGifFetcher: GifFetcher {

    var didCallLoadNewPage = false
    var didSearch: String?
    
    override func loadNewPage() {
        self.didCallLoadNewPage = true
    }
    
    override func search(query: String) {
        self.didSearch = query
    }
}

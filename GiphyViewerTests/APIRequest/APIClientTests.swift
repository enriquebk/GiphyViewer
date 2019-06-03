//
//  APIClientTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class APIClientTests: XCTestCase {

    func testSearchRequest() {
        let request = APIRequest.search(query: "query", limit: 20, offset: 1)
        
        XCTAssertEqual(try? request.asURLRequest().url?.absoluteString,
                       "http://api.giphy.com/v1/gifs/search?api_key=Ewi7fenM7y0ADl63Epp6Ncz76NHxuZn8&limit=20&offset=1&q=query")
    }
}

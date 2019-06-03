//
//  APIClientStub.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation
@testable import GiphyViewer

class APIClientStub: APIClient {
    
    var testData: [GIF] {
        return [GIF(id: "1", title: "title", images: [:]),
                GIF(id: "2", title: "title", images: [:]),
                GIF(id: "3", title: "title", images: [:])]
    }
    
    @discardableResult
    override func searchGIFs(with query: String,
                             limit: Int = 20,
                             offset: Int = 0,
                             callback:@escaping(_ result: [GIF]?, _ error: APIClientError?) -> Void) -> CancelableRequest {
        
        callback(testData, nil)
        return FakeCancelableRequest()
    }
    
    @discardableResult
    override func getTrendingGifs(limit: Int = 20,
                                  offset: Int = 0,
                                  callback:@escaping(_ result: [GIF]?, _ error: APIClientError?) -> Void) -> CancelableRequest {
        
        callback(testData, nil)
        return FakeCancelableRequest()
    }
}

class FakeCancelableRequest: CancelableRequest {
    func cancel() { }
}

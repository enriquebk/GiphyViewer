//
//  GIFTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class GIFTests: XCTestCase {

    func testJSONParse() {
        
        if let json = json {
            let gif = try? JSONDecoder().decode(GIF.self, from: json)
            
            XCTAssertEqual(gif?.id, "FiGiRei2ICzzG")
            XCTAssertEqual(gif?.title, "Funny Cat GIF")
        } else {
            XCTFail("Error when parsing GIF object")
        }
    }
}

private let json = """
{
            "id": "FiGiRei2ICzzG",
            "images": {
                "preview_gif": {
                    "url": "http://media2.giphy.com/media/FiGiRei2ICzzG/200.gif",
                    "width": "568",
                    "height": "200",
                },
                "original": {
                    "url": "http://media2.giphy.com/media/FiGiRei2ICzzG/200_s.gif",
                    "width": "568",
                    "height": "200"
                }
            },
            "title": "Funny Cat GIF"
        }
""".data(using: .utf8)

//
//  GIF.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

struct GIF: Decodable {
    let id: String
    let title: String
    let images: [String: Image]
}

struct Image: Decodable {
    
    var url: String?
    var width: Int?
    var height: Int?
    
    private enum CodingKeys: String, CodingKey {
        case url, width, height
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url =  try? container.decode(String.self, forKey: .url)
        if let widthStr = try? container.decode(String.self, forKey: .width) {
            self.width = Int(widthStr)
        }
        if let heightStr = try? container.decode(String.self, forKey: .width) {
            self.height = Int(heightStr)
        }
    }
}

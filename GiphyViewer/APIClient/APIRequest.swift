//
//  APIRoute.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation
import Alamofire

enum APIRequest: URLRequestConvertible {
    
    case search(query: String, limit: Int, offset: Int)
    case trending(limit:Int, offset:Int)
    
    private var httpProtocol: String { return "http" }
    private var basePath: String { return "api.giphy.com" }
    private var version: String { return "v1" }
    private var apiKey: String { return "Ewi7fenM7y0ADl63Epp6Ncz76NHxuZn8" }
    
    private var httpMethod: String {
        switch self {
        case .search, .trending:
            return "GET"
        }
    }
    
    private var path: String {
        switch self {
        case .search:
           return "gifs/search"
        case .trending:
            return "gifs/trending"
        }
    }
    
    private var url: URL? {
        let urlString = httpProtocol + "://" + basePath + "/" + version + "/" + path
        return URL(string: urlString)
    }
    
    private var bodyParams: [String: Any] {
        
        var bodyParams: [String: Any]!
        
        switch self {
        case .search(let query, let limit, let offset):
            bodyParams = ["q": query, "limit": limit, "offset": offset]
        case .trending( let limit, let offset):
            bodyParams = ["limit": limit, "offset": offset]
        }
        
        bodyParams["api_key"] = self.apiKey
        
        return bodyParams
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = url else {
            throw APIClientError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        if httpMethod == "GET" {
            request = try URLEncoding.queryString.encode(request, with: bodyParams)
        } else {
            request = try URLEncoding.httpBody.encode(request, with: bodyParams)
        }
        
        return request
    }
}

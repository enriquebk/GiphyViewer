//
//  APIRoute.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

enum APIRequest {
    
    // MARK: Endopints
    
    // Add endpoints as enum cases
    
    // MARK: -
    
    private func httpProtocol() -> String {
        return "https"
    }
    
    private func basePath() -> String {
        return ""
    }
    
    private func path() -> String {
        switch self {
        default:
            return ""
        }
    }
    
    private func method() -> String {
        switch self {
        default:
            return "GET"
        }
    }
    
    private func url() -> URL? {
        return URL(string: "\(self.httpProtocol())://\(self.basePath())\(self.path())")
    }
    
    func request() -> URLRequest? {
        if let url = self.url() {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = self.method()
            return request
        }
        return nil
    }
}

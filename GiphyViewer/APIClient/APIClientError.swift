//
//  APIError.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

public enum APIClientError: LocalizedError {
    
    // An error has occurred while executing the request
    case comunicationError(Error)
    // The server has responded an error with a certain status code
    case serverError(statusCode: Int)
    // Error occurred while parsing json
    case JSONMappingError(Error)
    // Unknown Error
    case unknownError
    // Invalid Url
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case let .comunicationError(error): return "Comunication error: \(error.localizedDescription)"
        case let .JSONMappingError(error): return "JSON mapping error: \(error.localizedDescription)"
        case let .serverError(statusCode): return "Server error, status code: \(statusCode)"
        case .unknownError: return "Unknown Error"
        case .invalidURL: return "Invalid URL"
        }
    }
}

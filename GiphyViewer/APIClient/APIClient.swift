//
//  APIClient.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
import Alamofire

class APIClient {
    
    private struct Response<T: Decodable>: Decodable {
        let data: T
    }
    
    @discardableResult
    private func execute<ResultType: Decodable>(request apiRequest: APIRequest,
                                                resultType: ResultType.Type,
                                                callback: @escaping(_ result: ResultType?, _ error: APIClientError?) -> Void) -> CancelableRequest {
        
        return Alamofire.request(apiRequest).validate()
            .responseData { response in
                
                switch response.result {
                case .failure(let error):
                    
                    if let serverResponse = response.response {
                        let statusCode = serverResponse.statusCode
                        callback(nil, .serverError(statusCode: statusCode))
                    } else {
                        
                        guard (error as NSError).code != NSURLErrorCancelled else {
                            return
                        }
                        
                        callback(nil, .comunicationError(error))
                    }
                    
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(Response<ResultType>.self, from: data)
                        callback(result.data, nil)
                    } catch let error {
                        callback(nil, .JSONMappingError(error))
                    }
                }
        }
    }
    
    @discardableResult
    func searchGIFs(with query: String,
                    limit: Int = 20,
                    offset: Int = 0,
                    callback:@escaping(_ result: [GIF]?, _ error: APIClientError?) -> Void) -> CancelableRequest {
        
        return self.execute(request: .search(query: query, limit: limit, offset: offset),
                            resultType: [GIF].self) { (gifs, error) in
                                callback(gifs, error)
        }
    }
    
    @discardableResult
    func getTrendingGifs(limit: Int = 20,
                         offset: Int = 0,
                         callback:@escaping(_ result: [GIF]?, _ error: APIClientError?) -> Void) -> CancelableRequest {
        
        return self.execute(request: .trending(limit: limit, offset: offset),
                            resultType: [GIF].self) { (gifs, error) in
                                callback(gifs, error)
        }
    }
}

protocol CancelableRequest {
    func cancel()
}

extension DataRequest: CancelableRequest { }

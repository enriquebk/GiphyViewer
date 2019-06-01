//
//  APIClient.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

class APIClient {
    
    func execute(request apiRequest: APIRequest) {
        guard let request = apiRequest.request() else {
            print("Invalid request")
            return
        }
        
        //TODO: Execute Request
    }
}

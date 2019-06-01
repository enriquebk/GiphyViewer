//
//  GIFRoute.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

enum GIFRoute: Route {
    
    case dissmiss
    
    func getTransition() -> Transition {
        switch self {
        case .dissmiss:
            return NavigationTransition(.dismiss)
        }
    }
}

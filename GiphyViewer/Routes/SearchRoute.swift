//
//  SearchRoute.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

enum SearchRoute: Route {
 
    case show(GIF)
    
    func getTransition() -> Transition {
        switch self {
        case .show:
            return NavigationTransition(.push(GIFViewController()))
        }
    }
}

//
//  SearchRoute.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation
import UIKit

enum SearchRoute: Route {
 
    case show(GIF)
    case showError(Error)
    
    func getTransition() -> Transition {
        switch self {
        case .show:
            
            return NavigationTransition(.push(GIFViewController()))
        
        case let .showError(error):

            let alert = UIAlertController(title: L10n.error, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: L10n.ok, style: .default, handler: nil))

            return NavigationTransition(.present(alert))
        }
    }
}

//
//  SpyCoordinator.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation
import UIKit
@testable import GiphyViewer

class SpyCoordinator: Coordinator<SearchRoute> {
    
    var gifToShow: GIF?
    
    init() {
        super.init(root: UIViewController())
    }
    
    override func navigate(to destination: SearchRoute) {
        switch destination {
        case .show(let gif):
            self.gifToShow = gif
        case .showError: break

        }
    }
    
}

//
//  UIViewControllerMock.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

class SpyViewController: UIViewController {
    var didCallDismiss = false
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.didCallDismiss = true
        super.dismiss(animated: flag, completion: completion)
    }
    
    func navigationControllerMock() -> SpyUINavigationController {
        guard let navController = self.navigationController as? SpyUINavigationController else {
            return SpyUINavigationController()
        }
        return navController
    }
}

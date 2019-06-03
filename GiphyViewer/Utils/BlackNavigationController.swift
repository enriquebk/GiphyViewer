//
//  CustomNavigationController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/3/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

class BlackNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = .black
        self.navigationBar.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

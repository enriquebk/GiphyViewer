//
//  MVVMViewMock.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
@testable import GiphyViewer

class SpyViewControllerMVVMView: UIViewController, MVVMView {

    var viewModel: FakeViewModel!
        
    var didCallBindViewModel = false
    var didCallViewDidLoad = false
    
    func bindViewModel() {
        self.didCallBindViewModel = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didCallViewDidLoad = true
    }
}

class SpyViewMVVMView: UIView, MVVMView {
    
    var viewModel: FakeViewModel!
    
    var didCallBindViewModel = false
    
    func bindViewModel() {
        self.didCallBindViewModel = true
    }
}

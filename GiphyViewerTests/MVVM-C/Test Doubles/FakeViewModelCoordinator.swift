//
//  FakeViewModelCoordinator.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
@testable import GiphyViewer

class FakeRoute: Route {
    func getTransition() -> Transition {
        return NavigationTransition(.noTransition)
    }
}

class FakeViewModelCoordinator: ViewModel, CoordinatorManager {
    
    var coordinator: Coordinator<FakeRoute>!
}

class FakeViewController: UIViewController, MVVMView {
    var viewModel: FakeViewModelCoordinator!
    
    func bindViewModel() { }
}

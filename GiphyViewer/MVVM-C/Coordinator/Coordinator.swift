//
//  Coordinator.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

public protocol Presentable { }

extension UIViewController: Presentable {}

public class Coordinator<CoordinatorRoute: Route> {
    
    public var root: Presentable!
    
    init(root: Presentable) {
        self.root = root
    }
    
    public func navigate(to destination: CoordinatorRoute) {
        destination.getTransition().execute(from: self.root)
    }
}

protocol CoordinatorManager {
    associatedtype CoordinatorType: Route
    var coordinator: Coordinator<CoordinatorType>! { get set }
}

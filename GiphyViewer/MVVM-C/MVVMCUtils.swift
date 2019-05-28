//
//  MVVMCUtils.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

extension MVVMView where Self: UIViewController, Self.ViewModelType: CoordinatorManager {
    
    static func instantiate(with viewModel: Self.ViewModelType) -> Self {
        
        let viewController = Self()
        viewController.bind(to: viewModel)
        viewController.viewModel.coordinator = Coordinator<Self.ViewModelType.CoordinatorType>(root: viewController)
        
        return viewController
    }
}

//
//  MVVMView.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

protocol ViewModel: AnyObject { }

protocol MVVMView: AnyObject {
    associatedtype ViewModelType: ViewModel

    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension MVVMView where Self: UIViewController {
    
    func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension MVVMView where Self: UIView {
    
    func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}

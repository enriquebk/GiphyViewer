//
//  BindableValue.swift
//  LightMVVMC
//
//  Created by Enrique Bermúdez on 3/27/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit

public class BindableValue<T> {

    public typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet {
            self.listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}

public class OptionalBindableValue<T> {
    
    public typealias Listener = (T?) -> Void
    private var listener: Listener?
    
    public var value: T? {
        didSet {
            self.listener?(value)
        }
    }

    public init(_ value: T?) {
        self.value = value
    }

    public func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}

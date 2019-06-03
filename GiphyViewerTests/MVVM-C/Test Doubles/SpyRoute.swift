//
//  RouteMock.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

@testable import GiphyViewer

class SpyRoute: Route {
    var didCallGetTransition = false
    var returnedTransition: SpyTransition?
    
    func getTransition() -> Transition {
        didCallGetTransition = true
        let transition = SpyTransition()
        returnedTransition = transition
        return transition
    }
}

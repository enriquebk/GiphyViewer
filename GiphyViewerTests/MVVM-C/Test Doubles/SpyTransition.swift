//
//  TransitionMock.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

@testable import GiphyViewer

class SpyTransition: Transition {
    var from: Presentable?
    
    func execute(from presentable: Presentable) {
        from = presentable
    }
}

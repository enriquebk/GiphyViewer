//
//  CoordinatorTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class CoordinatorTests: XCTestCase {

    private var root: UIViewController!
    private var coordinator: Coordinator<SpyRoute>!
    
    override func setUp() {
        root = UIViewController()
        coordinator = Coordinator<SpyRoute>.init(root: root)
    }
    
    func testCoordinatorInit() {

        if let coordinatorRoot = coordinator.root as? UIViewController {
            XCTAssertTrue(coordinatorRoot === root)
        } else {
            XCTFail("Coordinatior root was't correclty initialized")
        }
    }
    
    func testCoordinatorNavigation() {

        let routeMock = SpyRoute()
        
        coordinator.navigate(to: routeMock)
        
        XCTAssertTrue(routeMock.didCallGetTransition)
    
        if let transition = routeMock.returnedTransition,
            let from = transition.from as? UIViewController {
            XCTAssertTrue(from === root)
        } else {
            XCTFail("An error has occurred when accessing `returnedTransition`")
        }
    }
}

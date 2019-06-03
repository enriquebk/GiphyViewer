//
//  NavigationTransitionTests.swift
//  GiphyViewerTests
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import XCTest
@testable import GiphyViewer

class NavigationTransitionTests: XCTestCase {

    private var viewControllerMock: SpyViewController!
    
    override func setUp() {
        viewControllerMock = SpyViewController()
        _ = SpyUINavigationController(rootViewController: viewControllerMock)
    }

    func testPushNavigationTransition() {
        let navigationTransition = NavigationTransition(.push(UIViewController()))
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPushViewController)
    }
    
    func testPopNavigationTransition() {
        let navigationTransition = NavigationTransition(.pop)
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPopViewController)
    }
    
    func testPopToRootNavigationTransition() {
        let navigationTransition = NavigationTransition(.popToRoot)
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPopToRootViewController)
    }
    
    func testPresentNavigationTransition() {
        let navigationTransition = NavigationTransition(.present(UIViewController()))
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPresent)
    }
    
    func testDismissNavigationTransition() {
        let navigationTransition = NavigationTransition(.dismiss)
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.didCallDismiss)
    }
    
    func testNoTransitionTransition() {
        let navigationTransition = NavigationTransition(.noTransition)
        navigationTransition.execute(from: self.viewControllerMock)
        
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPushViewController)
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPopViewController)
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPopToRootViewController)
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPresent)
        XCTAssertFalse(self.viewControllerMock.didCallDismiss)
    }
}

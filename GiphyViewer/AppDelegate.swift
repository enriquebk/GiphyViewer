//
//  AppDelegate.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var initialScreen: UIViewController {
        return UINavigationController(rootViewController: SearchViewController())
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = self.initialScreen
        window?.makeKeyAndVisible()
        
        return true
    }
}

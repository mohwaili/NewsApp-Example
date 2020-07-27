//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit
import NewsAPIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewModel = NewsOverviewViewModel()
        let rootViewController = NewsOverviewViewController(with: viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

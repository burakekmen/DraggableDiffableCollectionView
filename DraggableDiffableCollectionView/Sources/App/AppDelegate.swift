//
//  AppDelegate.swift
//  DraggableDiffableCollectionView
//
//  Created by Burak Ekmen on 25.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = DraggableCollectionViewBuilder.generate()
        window?.makeKeyAndVisible()
        return true
    }

}


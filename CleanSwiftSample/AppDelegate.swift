//
//  AppDelegate.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setRootViewController()
        return true
    }
    
    private func setRootViewController() {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = .white
        }
        let rootViewController = CountriesViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        self.window?.rootViewController?.removeFromParent()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

//
//  AppDelegate.swift
//  WhzxSwiftProject
//
//  Created by Applezxk on 2020/9/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ZXKLoginVC()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}


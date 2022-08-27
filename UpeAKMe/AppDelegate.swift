//
//  AppDelegate.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 19/08/22.
//

import UIKit
import IQKeyboardManagerSwift

let ObjAppdelegate = UIApplication.shared.delegate as! AppDelegate
@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

//MARK: - Create shared preference
    private static var AppDelegateManager: AppDelegate = {
        let manager = UIApplication.shared.delegate as! AppDelegate
        return manager
    }()
// MARK: - Accessors
    class func AppDelegateObject() -> AppDelegate {
        return AppDelegateManager
    }

    
// MARK: - App Delegate Functions
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.settingRootController()
        
        return true
    }
}


//MARK: - Manage AutoLogin
extension AppDelegate {
    func settingRootController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        navController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthNav") as? UINavigationController
        appDelegate.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}

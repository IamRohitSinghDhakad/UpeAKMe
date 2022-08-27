//
//  SWRevealViewController+Extensions.swift
//  SWHomePushSwift
//
//  Created by Patrick BODET on 10/07/2018.
//  Copyright © 2018 iDevelopper. All rights reserved.
//

import Foundation
import UIKit

extension SWRevealViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        var pushingController: Any?

        if frontViewController is UINavigationController {
            if (frontViewController as! UINavigationController).topViewController != viewController {
                pushingController = frontViewController
            }
        }
        else if let navigationController = frontViewController.navigationController {
            pushingController = navigationController
        }
        
        if pushingController != nil && !(viewController is UINavigationController) {
            (pushingController as! UINavigationController).pushViewController(viewController, animated: false)
            revealToggle(animated: animated)
        }
        else {
            pushFrontViewController(viewController, animated: animated)
        }
    }
}

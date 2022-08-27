//
//  RevealViewController.swift
//  SWHomePushSwift
//
//  Created by Patrick BODET on 09/08/2017.
//  Copyright © 2017 iDevelopper. All rights reserved.
//

import UIKit

class RevealViewController: SWRevealViewController, SWRevealViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.rearViewRevealOverdraw = 0.0
        self.rightViewRevealOverdraw = 0.0
        
        self.tapGestureRecognizer()
        self.panGestureRecognizer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - SWReveal view controller delegate
    
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        let nc = revealController.frontViewController as! UINavigationController
        let vc = nc.topViewController
//        if vc is OtherViewController {
//            return false
//        }
//        if vc is SettingsViewController {
//            return false
//        }
        
       // if vc is LoginVC {
       //     return false
      //  }
       
        return true
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if position == .right {
            revealController.frontViewController.view.alpha = 0.8
            revealController.frontViewController.view.isUserInteractionEnabled = false
        }
        else if position == .leftSide {
            revealController.frontViewController.view.alpha = 0.8
            revealController.frontViewController.view.isUserInteractionEnabled = false
        }
        else {
            revealController.frontViewController.view.alpha = 1.0
            revealController.frontViewController.view.isUserInteractionEnabled = true
        }
    }
    
    func revealController(_ revealController: SWRevealViewController!, panGestureMovedToLocation location: CGFloat, progress: CGFloat, overProgress: CGFloat) {
        print("progress: \(progress)")
        revealController.frontViewController.view.alpha = 1.0 - (progress * 0.2)
    }

/*
    func revealControllerPanGestureShouldBegin(_ revealController: PBRevealViewController!, direction: PBRevealControllerPanDirection) -> Bool {
        //
    }
 */
}

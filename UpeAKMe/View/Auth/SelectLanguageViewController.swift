//
//  SelectLanguageViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit

class SelectLanguageViewController: UIViewController {
    
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblEnglish: UILabel!
    @IBOutlet var lblFrench: UILabel!
    @IBOutlet var veFrench: UIView!
    @IBOutlet var vwEnglish: UIView!
    
    //MARK: - App Lyf Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToNextController()
        self.veFrench.layer.borderColor = UIColor.lightGray.cgColor
        self.lblFrench.textColor = UIColor.black
        self.vwEnglish.layer.borderColor = UIColor.init(named: "AppDefaultGolden")?.cgColor
        self.lblEnglish.textColor = UIColor.init(named: "AppDefaultGolden")
        objAppShareData.UserDetail.strSelectedLanguage = "en"//AppLanguage.English
        
    }
    
    @IBAction func btnOnEnglish(_ sender: Any) {
        self.veFrench.layer.borderColor = UIColor.lightGray.cgColor
        self.lblFrench.textColor = UIColor.black
        
        self.vwEnglish.layer.borderColor = UIColor.init(named: "AppDefaultGolden")?.cgColor
        self.lblEnglish.textColor = UIColor.init(named: "AppDefaultGolden")
        objAppShareData.UserDetail.strSelectedLanguage = "en"//AppLanguage.English
    }
    
    @IBAction func btnOnfrench(_ sender: Any) {
        self.vwEnglish.layer.borderColor = UIColor.lightGray.cgColor
        self.lblEnglish.textColor = UIColor.black
        
        self.veFrench.layer.borderColor = UIColor.init(named: "AppDefaultGolden")?.cgColor
        self.lblFrench.textColor = UIColor.init(named: "AppDefaultGolden")
        objAppShareData.UserDetail.strSelectedLanguage = "fr"//AppLanguage.French
        
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        let strSelectedLanguage = LocalizationSystem.sharedInstance.getLanguage()
        objAppShareData.UserDetail.strSelectedLanguage = strSelectedLanguage
        self.pushVc(viewConterlerId: "LoginViewController")
    }
    
    @IBAction func btnOnSelect(_ sender: Any) {
        if objAppShareData.UserDetail.strSelectedLanguage == "en"{
            setEnglish()
        }else{
            setFrench()
        }
    }
    
    
    //MARK: - Redirection Methods
    func goToNextController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if AppSharedData.sharedObject().isLoggedIn {
            let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            appDelegate.window?.rootViewController = navController
        }
        else {
            //            let vc = (self.authStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController)!
            //            let navController = UINavigationController(rootViewController: vc)
            //            navController.isNavigationBarHidden = true
            //            appDelegate.window?.rootViewController = navController
        }
    }
}

extension SelectLanguageViewController{
    
    func setEnglish() {
        if LocalizationSystem.sharedInstance.getLanguage() == "fr" {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            objAlert.showAlertSingleButtonCallBack(alertBtn: "OK".localized(), title: "", message: "English Language Set You have to restart your app".localized(), controller: self) {
                exit(EXIT_SUCCESS)
            }
        }
    }
    
    func setFrench() {
        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "fr")
            objAlert.showAlertSingleButtonCallBack(alertBtn: "OK".localized(), title: "", message: "French Language Set You have to restart your app".localized(), controller: self) {
                exit(EXIT_SUCCESS)
            }
        }
    }
}

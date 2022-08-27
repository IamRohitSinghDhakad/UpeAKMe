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

        self.veFrench.layer.borderColor = UIColor.lightGray.cgColor
        self.lblFrench.textColor = UIColor.black
        self.vwEnglish.layer.borderColor = UIColor.init(named: "AppDefaultGolden")?.cgColor
        self.lblEnglish.textColor = UIColor.init(named: "AppDefaultGolden")
        objAppShareData.signInData.strSelectedLanguage = AppLanguage.English
       
    }
    
    @IBAction func btnOnEnglish(_ sender: Any) {
        self.veFrench.layer.borderColor = UIColor.lightGray.cgColor
        self.lblFrench.textColor = UIColor.black
        
        self.vwEnglish.layer.borderColor = UIColor.init(named: "AppDefaultGolden")?.cgColor
        self.lblEnglish.textColor = UIColor.init(named: "AppDefaultGolden")
        objAppShareData.signInData.strSelectedLanguage = AppLanguage.English
    }
    
    @IBAction func btnOnfrench(_ sender: Any) {
        self.vwEnglish.layer.borderColor = UIColor.lightGray.cgColor
        self.lblEnglish.textColor = UIColor.black
        
        self.veFrench.layer.borderColor = UIColor.init(named: "AppDefaultGolden")?.cgColor
        self.lblFrench.textColor = UIColor.init(named: "AppDefaultGolden")
        objAppShareData.signInData.strSelectedLanguage = AppLanguage.French
        
    }
    
    @IBAction func btnOnSelect(_ sender: Any) {
        self.pushVc(viewConterlerId: "LoginViewController")
    }
    
}

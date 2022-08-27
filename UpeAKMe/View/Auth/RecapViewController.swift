//
//  RecapViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 21/08/22.
//

import UIKit

class RecapViewController: UIViewController {

    @IBOutlet var lblFirstName: UILabel!
    @IBOutlet var lblLastName: UILabel!
    @IBOutlet var lblPhoneNumber: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblDesiredField: UILabel!
    @IBOutlet var lblJobType: UILabel!
    @IBOutlet var lbldesiredWorkSetting: UILabel!
    @IBOutlet var lblDesiredPayAnnual: UILabel!
    @IBOutlet var lblWorkSchedule: UILabel!
    @IBOutlet var lblRelocation: UILabel!
    @IBOutlet var lblDesiredCountry: UILabel!
    @IBOutlet var lblDesiredState: UILabel!
    @IBOutlet var lblDesiredCity: UILabel!
    @IBOutlet var lblDesiredVaccation: UILabel!
    @IBOutlet var lblJobTitle: UILabel!
    @IBOutlet var lblCompanyName: UILabel!
    @IBOutlet var lblJobLocation: UILabel!
    @IBOutlet var lblJobDuration: UILabel!
    @IBOutlet var lblLevelEducation: UILabel!
    @IBOutlet var lblCertificate: UILabel!
    @IBOutlet var lblSkills: UILabel!
    @IBOutlet var lblSpokenLanguage: UILabel!
    @IBOutlet var lblWrittenLanguage: UILabel!
    @IBOutlet var lblSignLanguage: UILabel!
    @IBOutlet var lblVolunteerWork: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUserDetailsForSignIn()
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        self.makeRootController()
    }
    
}

extension RecapViewController{
    
    func makeRootController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
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
            let vc = (self.authStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController)!
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            appDelegate.window?.rootViewController = navController
        }
    }
}


extension RecapViewController{
    
    func loadUserDetailsForSignIn(){
        
        self.lblFirstName.text! = objAppShareData.signInData.strFirstName
        self.lblLastName.text! = objAppShareData.signInData.strLastName
        self.lblPhoneNumber.text! = objAppShareData.signInData.strPhoneNumber
        self.lblEmail.text! = objAppShareData.signInData.strEmail
        self.lblDesiredField.text! = objAppShareData.signInData.strSelectedDesiredField
        self.lblJobType.text! = objAppShareData.signInData.strSelectedDesiredJobType
        self.lbldesiredWorkSetting.text! = objAppShareData.signInData.strSelectedDesiredWorkSetting
        self.lblDesiredPayAnnual.text! = objAppShareData.signInData.strSelectedDesiredPayAnnual
        self.lblWorkSchedule.text! = objAppShareData.signInData.strSelectedDesiredWorkSchedule
        self.lblRelocation.text! = objAppShareData.signInData.strSelectedDesiredRelocation
        self.lblDesiredCountry.text! = objAppShareData.signInData.strSelectedDesiredCountry
        self.lblDesiredState.text! = objAppShareData.signInData.strSelectedDesiredProvience
        self.lblDesiredCity.text! = objAppShareData.signInData.strSelectedDesiredCity
        self.lblDesiredVaccation.text! = objAppShareData.signInData.strSelectedDesiredVaccation
        self.lblJobTitle.text! = objAppShareData.signInData.strJobTitle1
        self.lblCompanyName.text! = objAppShareData.signInData.strCompanyName1
        self.lblJobLocation.text! = objAppShareData.signInData.strLocation1
        self.lblJobDuration.text! = objAppShareData.signInData.strWorkDuration1
        self.lblLevelEducation.text! = objAppShareData.signInData.strLevelEducation
        self.lblCertificate.text! = objAppShareData.signInData.strCertificateLicense
        self.lblSkills.text! = objAppShareData.signInData.strSkills
        self.lblSpokenLanguage.text! = objAppShareData.signInData.strSpokenLanguage
        self.lblWrittenLanguage.text! = objAppShareData.signInData.strWrittenLanguage
        self.lblSignLanguage.text! = "No"
        self.lblVolunteerWork.text! = objAppShareData.signInData.strVolunteerWork
        
    }
}

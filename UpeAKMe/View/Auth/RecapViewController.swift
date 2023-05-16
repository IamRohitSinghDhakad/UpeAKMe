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
        self.call_wsRegisterUser()
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
        
        self.lblFirstName.text! = objAppShareData.UserDetail.strFirstName
        self.lblLastName.text! = objAppShareData.UserDetail.strLastName
        self.lblPhoneNumber.text! = objAppShareData.UserDetail.strPhoneNumber
        self.lblEmail.text! = objAppShareData.UserDetail.strEmail
        self.lblDesiredField.text! = objAppShareData.UserDetail.strSelectedDesiredField
        self.lblJobType.text! = objAppShareData.UserDetail.strSelectedDesiredJobType
        self.lbldesiredWorkSetting.text! = objAppShareData.UserDetail.strSelectedDesiredWorkSetting
        self.lblDesiredPayAnnual.text! = objAppShareData.UserDetail.strSelectedDesiredPayAnnual
        self.lblWorkSchedule.text! = objAppShareData.UserDetail.strSelectedDesiredWorkSchedule
        self.lblRelocation.text! = objAppShareData.UserDetail.strSelectedDesiredRelocation
        self.lblDesiredCountry.text! = objAppShareData.UserDetail.strSelectedDesiredCountry
        self.lblDesiredState.text! = objAppShareData.UserDetail.strSelectedDesiredProvience
        self.lblDesiredCity.text! = objAppShareData.UserDetail.strSelectedDesiredCity
        self.lblDesiredVaccation.text! = objAppShareData.UserDetail.strSelectedDesiredVaccation
        self.lblJobTitle.text! = objAppShareData.UserDetail.strJobTitle1 + "," + objAppShareData.UserDetail.strJobTitle2
        self.lblCompanyName.text! = objAppShareData.UserDetail.strCompanyName1 + "," + objAppShareData.UserDetail.strCompanyName2
        self.lblJobLocation.text! = objAppShareData.UserDetail.strLocation1 + "," + objAppShareData.UserDetail.strLocation2
        self.lblJobDuration.text! = objAppShareData.UserDetail.strWorkDuration1 + "," + objAppShareData.UserDetail.strWorkDuration2
        self.lblLevelEducation.text! = objAppShareData.UserDetail.strLevelEducation
        self.lblCertificate.text! = objAppShareData.UserDetail.strCertificateLicense
        self.lblSkills.text! = objAppShareData.UserDetail.strSkills
        self.lblSpokenLanguage.text! = objAppShareData.UserDetail.strSpokenLanguage
        self.lblWrittenLanguage.text! = objAppShareData.UserDetail.strWrittenLanguage
        self.lblSignLanguage.text! = objAppShareData.UserDetail.strDesiredValue
        self.lblVolunteerWork.text! = objAppShareData.UserDetail.strVolunteerWork
        
    }
}


extension RecapViewController{
    
    func call_wsRegisterUser(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        var dictParam = [String:Any]()
        
        
        var uri = ""
        if objAppShareData.isComingFromEdit{
            uri = WsUrl.url_completeProfile
            
            dictParam = ["user_id":objAppShareData.UserDetail.strUserId,
                         "first_name":self.lblFirstName.text!,
                         "last_name":self.lblLastName.text!,
                         "name":lblFirstName.text! + lblLastName.text!,
                         "mobile":lblPhoneNumber.text!.withoutSpecialCharacters,
                         "email":lblEmail.text!,
                         "password":objAppShareData.UserDetail.strPassword,
                         "address":"",
                         "lat":"",
                         "lng":"",
                         "nation_id":objAppShareData.UserDetail.strSelectedDesiredCountryID,
                         "province_id":objAppShareData.UserDetail.strSelectedDesiredProvienceID,
                         "municipality_id":objAppShareData.UserDetail.strSelectedDesiredCityID,
                         "device_type":"IOS",
                         "desired_field":self.lblDesiredField.text!,
                         "desired_id":objAppShareData.UserDetail.strSelectedDesiredFieldID, //need to send ID
                         "desired_position_id":objAppShareData.UserDetail.strSelectedDesiredFieldPositionID,
                         "job_type":self.lblJobType.text!,
                         "desired_work":self.lbldesiredWorkSetting.text!,
                         "work_shedule":self.lblWorkSchedule.text!,
                         "desired_annual_pay":self.lblDesiredPayAnnual.text!,
                         "relocation":objAppShareData.UserDetail.strSelectedDesiredRelocation,
                         "desired_vacation":objAppShareData.UserDetail.strSelectedDesiredVaccation,
                         "job_tittle":self.lblJobTitle.text!,
                         "company_name":self.lblCompanyName.text!,
                         "job_location":self.lblJobLocation.text!,
                         "job_duration":self.lblJobDuration.text!,
                         "job_working_status":objAppShareData.UserDetail.strCurrentlyWorkingHere1 + "," + objAppShareData.UserDetail.strCurrentlyWorkingHere2,
                         "level_education":self.lblLevelEducation.text!,
                         "certificate_tbd":self.lblCertificate.text!,
                         "edu_skill":objAppShareData.UserDetail.strSkills,
                         "spoken_language":self.lblSpokenLanguage.text!,
                         "written_language":self.lblWrittenLanguage.text!,
                         "desired_values":self.lblSignLanguage.text!,
                         "volunteer_work":self.lblVolunteerWork.text!,
                         "language":objAppShareData.UserDetail.strSelectedLanguage,
                         "register_id":""
            ]as [String:Any]
            
        }else{
            uri = WsUrl.url_SignUp
            
            dictParam = ["first_name":self.lblFirstName.text!,
                         "last_name":self.lblLastName.text!,
                         "name":lblFirstName.text! + lblLastName.text!,
                         "mobile":lblPhoneNumber.text!.withoutSpecialCharacters,
                         "email":lblEmail.text!,
                         "password":objAppShareData.UserDetail.strPassword,
                         "address":"",
                         "lat":"",
                         "lng":"",
                         "nation_id":objAppShareData.UserDetail.strSelectedDesiredCountryID,
                         "province_id":objAppShareData.UserDetail.strSelectedDesiredProvienceID,
                         "municipality_id":objAppShareData.UserDetail.strSelectedDesiredCityID,
                         "device_type":"IOS",
                         "desired_field":self.lblDesiredField.text!,
                         "desired_id":objAppShareData.UserDetail.strSelectedDesiredFieldID,
                         "desired_position_id":objAppShareData.UserDetail.strSelectedDesiredFieldPositionID,
                         "job_type":self.lblJobType.text!,
                         "desired_work":self.lbldesiredWorkSetting.text!,
                         "work_shedule":self.lblWorkSchedule.text!,
                         "desired_annual_pay":self.lblDesiredPayAnnual.text!,
                         "relocation":objAppShareData.UserDetail.strSelectedDesiredRelocation,
                         "desired_vacation":objAppShareData.UserDetail.strSelectedDesiredVaccation,
                         "job_tittle":self.lblJobTitle.text!,
                         "company_name":self.lblCompanyName.text!,
                         "job_location":self.lblJobLocation.text!,
                         "job_duration":self.lblJobDuration.text!,
                         "job_working_status":objAppShareData.UserDetail.strCurrentlyWorkingHere1,
                         "level_education":self.lblLevelEducation.text!,
                         "certificate_tbd":self.lblCertificate.text!,
                         "edu_skill":objAppShareData.UserDetail.strSkills,
                         "spoken_language":self.lblSpokenLanguage.text!,
                         "written_language":self.lblWrittenLanguage.text!,
                         "desired_values":self.lblSignLanguage.text!,
                         "volunteer_work":self.lblVolunteerWork.text!,
                         "language":objAppShareData.UserDetail.strSelectedLanguage,
                         "register_id":""
            ]as [String:Any]
        }
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: uri, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            debugPrint(response)
            if status == MessageConstant.k_StatusCode{
                objAppShareData.isComingFromEdit = false
                guard let dictUserData = response["result"]as? [String:Any] else{return}
                debugPrint(dictUserData)
                objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: dictUserData)
                objAppShareData.fetchUserInfoFromAppshareData()
                self.makeRootController()
                
            }else{
                if let resultmessage = response["result"]as? String{
                    objAlert.showAlert(message: resultmessage, controller: self)
                }
                
                debugPrint(message ?? "Error Occured")
            }
            
        } failure: { Error in
            debugPrint(Error)
        }
    }
}


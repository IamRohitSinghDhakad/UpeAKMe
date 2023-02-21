//
//  MyProfileViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 11/09/22.
//

import UIKit

class MyProfileViewController: UIViewController {

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
        call_wsGetProfile()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        objAppShareData.makeRootControllerSideMenu()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        objAppShareData.isComingFromEdit = true
        let vc = (self.authStoryboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as? CreateAccountViewController)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension MyProfileViewController{
    
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
        self.lblJobTitle.text! = objAppShareData.UserDetail.strJobTitle1
        self.lblCompanyName.text! = objAppShareData.UserDetail.strCompanyName1
        self.lblJobLocation.text! = objAppShareData.UserDetail.strLocation1
        self.lblJobDuration.text! = objAppShareData.UserDetail.strWorkDuration1
        self.lblLevelEducation.text! = objAppShareData.UserDetail.strLevelEducation
        self.lblCertificate.text! = objAppShareData.UserDetail.strCertificateLicense
        self.lblSkills.text! = objAppShareData.UserDetail.strSkills
        self.lblSpokenLanguage.text! = objAppShareData.UserDetail.strSpokenLanguage
        self.lblWrittenLanguage.text! = objAppShareData.UserDetail.strWrittenLanguage
        self.lblSignLanguage.text! = objAppShareData.UserDetail.strDesiredValue
        self.lblVolunteerWork.text! = objAppShareData.UserDetail.strVolunteerWork
        
    }
}


extension MyProfileViewController{
    
    func call_wsGetProfile(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = ["user_id":objAppShareData.UserDetail.strUserId]as [String:Any]
        
        debugPrint(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetProfile, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            debugPrint(response)
            if status == MessageConstant.k_StatusCode{
                
                guard let dictUserData = response["result"]as? [String:Any] else{return}
                debugPrint(dictUserData)
                objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: dictUserData)
                objAppShareData.fetchUserInfoFromAppshareData()
                self.loadUserDetailsForSignIn()
                
            }else{
                debugPrint(message ?? "Error Occured")
            }
            
        } failure: { Error in
            debugPrint(Error)
        }
    }
}

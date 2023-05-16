//
//  LoginViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var lblSignIn: UILabel!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var btnForgotPassword: UIButton!
    @IBOutlet var btnSignIn: UIButton!
    @IBOutlet var lblDontHaveAccount: UILabel!
    @IBOutlet var btnJoinUs: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnOnJoinUs(_ sender: Any) {
        pushVc(viewConterlerId: "CreateAccountViewController")
       // pushVc(viewConterlerId: "EducationViewController")
    }
    
    @IBAction func btnOnForgotPassword(_ sender: Any) {
        self.pushVc(viewConterlerId: "ForgotPasswordViewController")
    }
    
    @IBAction func btnOnSignIn(_ sender: Any) {
       // self.makeRootController()
   //     self.call_WsLogin()
      
        self.tfEmail.text = self.tfEmail.text?.trim()
        self.tfPassword.text = self.tfPassword.text?.trim()

        if (self.tfEmail.text!.isEmpty){
            showToast(message: MessageConstant.BlankEmail.localized(), font: .systemFont(ofSize: 12))
        }else if (self.tfPassword.text!.isEmpty){
            showToast(message: MessageConstant.BlankPassword.localized(), font: .systemFont(ofSize: 12))
        }else{
            self.call_WsLogin()
           // pushVc(viewConterlerId: "CreateAccountViewController")
        }
        
    }
}

//MARK:- Call Webservice
extension LoginViewController{
    
    
    func call_WsLogin(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["email":self.tfEmail.text!,
                         "password":self.tfPassword.text!,
                         "register_id":"objAppShareData.strFirebaseToken",
                         "language":objAppShareData.UserDetail.strSelectedLanguage,
                         "device_type":"IOS"
        ]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_Login, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { response in

            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                
                if let user_details  = response["result"] as? [String:Any] {
                    
                    objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                    objAppShareData.fetchUserInfoFromAppshareData()
                    objAppShareData.makeRootControllerSideMenu()
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
            
            
        } failure: { (Error) in
          //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
}


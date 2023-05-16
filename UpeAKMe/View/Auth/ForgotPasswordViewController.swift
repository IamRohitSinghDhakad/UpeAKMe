//
//  ForgotPasswordViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var lblForgotPassword: UILabel!
    @IBOutlet var lblEnterYourEmail: UILabel!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var btnResetPassword: UIButton!
    @IBOutlet var btnGoBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnResetPassword(_ sender: Any) {
        if (self.tfEmail.text!.isEmpty){
            showToast(message: MessageConstant.BlankEmail.localized(), font: .systemFont(ofSize: 12))
        }else if !objValidationManager.validateEmail(with: tfEmail.text!){
            objAlert.showAlert(message: MessageConstant.ValidEmail.localized(), title: MessageConstant.k_AlertTitle, controller: self)
        }else{
            self.ws_ForgotPassword()
           // showToast(message: MessageConstant.k_success, font: .systemFont(ofSize: 12))
        }
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
    
    
    func ws_ForgotPassword(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["email":self.tfEmail.text!,
                         "language":objAppShareData.UserDetail.strSelectedLanguage
        ]as [String:Any]
        
        print(dicrParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_forgotPassword, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    if msgg == "Forgot password successfuly"{
                        objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "", message: msgg, controller: self) {
                            self.onBackPressed()
                        }
                    }
                }
            }else{
                objAlert.showAlert(message: "Email not exist", title: "", controller: self)

            }
            
            
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
        
    }
    
}



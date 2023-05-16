//
//  CreateAccountViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var lblCreateAccount: UILabel!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tfFirstName: UITextField!
    @IBOutlet var tfLastName: UITextField!
    @IBOutlet var tfPhoneNumber: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfPhoneNumber.delegate = self
        self.tfPassword.delegate = self
        hideKeyboardWhenTappedAround()
        self.tfEmail.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkSavedData()
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
    
    @IBAction func btnOnNext(_ sender: Any) {
         validateForCreateAccount()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if (textField == self.tfPhoneNumber) {
            
            if length == 0 || (length > 10) {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }

            
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", prefix)
                index += 3
            }
            
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
        }else if (textField == self.tfPassword){
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            return (newLength > 8) ? false : true
        }
        else {
            return true
        }
    }
}


//MARK: - Check Validation
extension CreateAccountViewController{
    
    func validateForCreateAccount() {
        
        self.tfFirstName.text = self.tfFirstName.text!.trim()
        self.tfLastName.text = self.tfLastName.text!.trim()
        self.tfEmail.text = self.tfEmail.text!.trim()
        self.tfPassword.text = self.tfPassword.text!.trim()
        self.tfPhoneNumber.text = self.tfPhoneNumber.text!.trim()
        
      if (tfFirstName.text?.isEmpty)! {
          objAlert.showAlert(message: MessageConstant.BlankFirstName.localized(), title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfLastName.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankLastName.localized(), title:MessageConstant.k_AlertTitle, controller: self)
          }
        else if (tfPhoneNumber.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankPhoneNo.localized(), title:MessageConstant.k_AlertTitle, controller: self)
          }
        else if (tfEmail.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankEmail.localized(), title:MessageConstant.k_AlertTitle, controller: self)
        }else if !objValidationManager.validateEmail(with: tfEmail.text!){
            objAlert.showAlert(message: MessageConstant.ValidEmail.localized(), title:MessageConstant.k_AlertTitle, controller: self)
        }else if (tfPassword.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankPassword.localized(), title:MessageConstant.k_AlertTitle, controller: self)
        }else if !objValidationManager.isValidPassword6(testStr: self.tfPassword.text!){
            objAlert.showAlert(message: MessageConstant.PWDMustContain.localized(), title:MessageConstant.k_AlertTitle, controller: self)
        }
        else{
            
            self.saveDataLocalcy()
            if objAppShareData.isComingFromEdit == false{
                call_wsCheckProfile()
            }else{
                self.pushVc(viewConterlerId: "DesiredJobViewController")
            }
            
        }
    }
    
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.UserDetail.strFirstName = self.tfFirstName.text!
        objAppShareData.UserDetail.strLastName = self.tfLastName.text!
        objAppShareData.UserDetail.strEmail = self.tfEmail.text!
        objAppShareData.UserDetail.strPassword = self.tfPassword.text!
        objAppShareData.UserDetail.strPhoneNumber = self.tfPhoneNumber.text!
    }
    
    func checkSavedData(){
        if let firstName = objAppShareData.UserDetail.strFirstName as String?{
            self.tfFirstName.text! = firstName
        }
        if let lastName = objAppShareData.UserDetail.strLastName as String?{
            self.tfLastName.text! = lastName
        }
        if let email = objAppShareData.UserDetail.strEmail as String?{
            if objAppShareData.isComingFromEdit == false{
                self.tfEmail.isUserInteractionEnabled = true
            }else{
                self.tfEmail.isUserInteractionEnabled = false
            }
            self.tfEmail.text! = email
        }
        if let pwd = objAppShareData.UserDetail.strPassword as String?{
            self.tfPassword.text! = pwd
        }
        if let phoneNumber = objAppShareData.UserDetail.strPhoneNumber as String?{
            self.tfPhoneNumber.text! = phoneNumber
        }
    }
}


extension CreateAccountViewController{
    
    func call_wsCheckProfile(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = ["email":self.tfEmail.text!,
                         "language":objAppShareData.UserDetail.strSelectedLanguage]as [String:Any]
        
        debugPrint(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_CheckEmail, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? String)
            let message = (response["message"] as? String)
            debugPrint(response)
            if status == "1"{
                self.pushVc(viewConterlerId: "DesiredJobViewController")
            }else{
                if let res = response["result"]as? String{
                    objAlert.showAlert(message: res, controller: self)
                }
                debugPrint(message ?? "Error Occured")
            }
            
        } failure: { Error in
            debugPrint(Error)
        }
    }
    
}

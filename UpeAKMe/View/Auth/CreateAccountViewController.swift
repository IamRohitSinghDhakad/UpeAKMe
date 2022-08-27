//
//  CreateAccountViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet var lblCreateAccount: UILabel!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tfFirstName: UITextField!
    @IBOutlet var tfLastName: UITextField!
    @IBOutlet var tfPhoneNumber: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

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
    
}


//MARK: - Check Validation
extension CreateAccountViewController{
    
    func validateForCreateAccount() {
        
        self.tfFirstName.text = self.tfFirstName.text!.trim()
        self.tfLastName.text = self.tfLastName.text!.trim()
        self.tfEmail.text = self.tfEmail.text!.trim()
        self.tfPassword.text = self.tfPassword.text!.trim()
        self.tfPhoneNumber.text = self.tfPassword.text!.trim()
        
      if (tfFirstName.text?.isEmpty)! {
          objAlert.showAlert(message: MessageConstant.BlankFirstName, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfLastName.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankLastName, title:MessageConstant.k_AlertTitle, controller: self)
          }
        else if (tfEmail.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankEmail, title:MessageConstant.k_AlertTitle, controller: self)
        }else if !objValidationManager.validateEmail(with: tfEmail.text!){
            objAlert.showAlert(message: MessageConstant.ValidEmail, title:MessageConstant.k_AlertTitle, controller: self)
        }else if (tfPassword.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankPassword, title:MessageConstant.k_AlertTitle, controller: self)
        }else if (tfPhoneNumber.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.BlankPhoneNo, title:MessageConstant.k_AlertTitle, controller: self)
        }else{
            saveDataLocalcy()
            pushVc(viewConterlerId: "DesiredJobViewController")
        }
    }
    
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.signInData.strFirstName = self.tfFirstName.text!
        objAppShareData.signInData.strLastName = self.tfLastName.text!
        objAppShareData.signInData.strEmail = self.tfEmail.text!
        objAppShareData.signInData.strPassword = self.tfPassword.text!
        objAppShareData.signInData.strPhoneNumber = self.tfPhoneNumber.text!
    }
    
    func checkSavedData(){
        if let firstName = objAppShareData.signInData.strFirstName as String?{
            self.tfFirstName.text! = firstName
        }
        if let lastName = objAppShareData.signInData.strLastName as String?{
            self.tfLastName.text! = lastName
        }
        if let email = objAppShareData.signInData.strEmail as String?{
            self.tfEmail.text! = email
        }
        if let pwd = objAppShareData.signInData.strPassword as String?{
            self.tfPassword.text! = pwd
        }
        if let phoneNumber = objAppShareData.signInData.strPhoneNumber as String?{
            self.tfPhoneNumber.text! = phoneNumber
        }
        
    }
}

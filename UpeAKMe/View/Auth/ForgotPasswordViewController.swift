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
            showToast(message: MessageConstant.BlankEmail, font: .systemFont(ofSize: 12))
        }else if !objValidationManager.validateEmail(with: tfEmail.text!){
            objAlert.showAlert(message: MessageConstant.ValidEmail, title: MessageConstant.k_AlertTitle, controller: self)
        }else{
            showToast(message: MessageConstant.k_success, font: .systemFont(ofSize: 12))
        }
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
}

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
    }
    
    @IBAction func btnOnForgotPassword(_ sender: Any) {
        self.pushVc(viewConterlerId: "ForgotPasswordViewController")
    }
    
    @IBAction func btnOnSignIn(_ sender: Any) {
        self.makeRootController()
      
//        self.tfEmail.text = self.tfEmail.text?.trim()
//        self.tfPassword.text = self.tfPassword.text?.trim()
//
//        if (self.tfEmail.text!.isEmpty){
//            showToast(message: MessageConstant.BlankEmail, font: .systemFont(ofSize: 12))
//        }else if (self.tfPassword.text!.isEmpty){
//            showToast(message: MessageConstant.BlankPassword, font: .systemFont(ofSize: 12))
//        }else{
//            pushVc(viewConterlerId: "CreateAccountViewController")
//        }
        
    }
}

extension LoginViewController{
    func makeRootController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = (self.mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
    }
}

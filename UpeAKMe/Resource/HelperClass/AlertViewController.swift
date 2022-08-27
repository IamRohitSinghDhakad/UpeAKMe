//
//  AlertViewController.swift
//  Somi
//
//  Created by Rohit Singh Dhakad on 25/03/21.
//

import UIKit
var objAlert:AlertViewController = AlertViewController()

class AlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(message: String, title: String = "", controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: MessageConstant.k_AlertOK, style: .default, handler: nil)
        

        alertController.addAction(OKAction)
        controller.present(alertController, animated: true, completion: nil)
        view.endEditing(true)
    }
    
    // Alert call back function
     func showAlertSingleButtonCallBack(alertBtn:String,  title: String, message: String ,controller: UIViewController, callback: @escaping () -> ()) {
         
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         
          alert.addAction(UIAlertAction(title: alertBtn, style: .default, handler: {
            alertAction in
            callback()
          }))
         
          controller.present(alert, animated: true, completion: nil)
        }
    
    // Alert call back function
     func showAlertCallBack(alertLeftBtn:String, alertRightBtn:String,  title: String, message: String ,controller: UIViewController, callback: @escaping () -> ()) {
         
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         
         if alertLeftBtn != ""{
             alert.addAction(UIAlertAction(title:alertLeftBtn, style: .destructive, handler: {
               alertAction in
                 callback()
             }))
         }else{
            
         }
          alert.addAction(UIAlertAction(title: alertRightBtn, style: .default, handler: {
            alertAction in
           // callback()
          }))
         
          controller.present(alert, animated: true, completion: nil)
        }

    
  // For alert show on UIWindow if you have no Viewcontroller then show this alert.
    func showAlertVc(message: String = "", title: String , controller: UIWindow) {
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let subView = alertController.view.subviews.first!
            let alertContentView = subView.subviews.first!
            alertContentView.backgroundColor = UIColor.gray
            alertContentView.layer.cornerRadius = 20
            
            let OKAction = UIAlertAction(title: MessageConstant.k_AlertOK, style: .default, handler: nil)
            alertController.addAction(OKAction)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alertController, animated: true, completion: nil)

        })
    }

    // For alert show on if API response fail.
    func showNetworkAlert(){
        let alert = UIAlertController(title:MessageConstant.NoNetwork , message:MessageConstant.k_CheckInternetConnection , preferredStyle: .alert)
        let action = UIAlertAction(title:MessageConstant.k_AlertOK, style: .default, handler: nil)
        alert.addAction(action)
        alert.show()
    }
    
    func showAlert(message: String = "", title: String , controller: UIWindow) {
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let subView = alertController.view.subviews.first!
            let alertContentView = subView.subviews.first!
            alertContentView.backgroundColor = UIColor.gray
            alertContentView.layer.cornerRadius = 20
            let OKAction = UIAlertAction(title: MessageConstant.k_AlertOK, style: .default, handler: nil)
            alertController.addAction(OKAction)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        })
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-100, width: 250, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1.0)
    toastLabel.textColor = UIColor.red
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 5;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.2
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
 }
    
}






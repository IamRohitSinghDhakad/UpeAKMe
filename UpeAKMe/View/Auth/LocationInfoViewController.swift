//
//  LocationInfoViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit
import iOSDropDown

class LocationInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var lblLocationInfo: UILabel!
    @IBOutlet var tfDesiredCountry: DropDown!
    @IBOutlet var tfDesiredProvince: DropDown!
    @IBOutlet var tfDesiredCity: DropDown!
    
    let dropDownArray: [String] = [MessageConstant.k_success, MessageConstant.k_AlertTitle, MessageConstant.k_AlertOK, MessageConstant.k_NoConnection]
    
    var selectedIndexCountry:String?
    var selectedIndexProvience:String?
    var selectedIndexCity:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdown()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkSavedDataAndFill()
    }
    
    
    //MARK: - Setup Dropdown
        func setupDropdown() {
           //==============================//
            tfDesiredCountry.optionArray = dropDownArray
            tfDesiredProvince.optionArray = dropDownArray
            tfDesiredCity.optionArray = dropDownArray
            //Delegate
            tfDesiredCountry.delegate = self
            tfDesiredProvince.delegate = self
            tfDesiredCity.delegate = self
            //=========== XXXX ============//
            
            tfDesiredCountry.text = dropDownArray[0]
            tfDesiredCountry.selectedIndex = 0
            
            tfDesiredCountry.didSelect{(selectedText , index ,id) in
                self.tfDesiredCountry.text = selectedText
                self.tfDesiredCountry.hideList()
            }
            
            tfDesiredProvince.didSelect{(selectedText , index ,id) in
                self.tfDesiredProvince.text = selectedText
                self.tfDesiredProvince.hideList()
            }
            
            tfDesiredCity.didSelect{(selectedText , index ,id) in
                self.tfDesiredCity.text = selectedText
                self.tfDesiredCity.hideList()
            }
        }
    
    
    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
      //  checkValidation()
        saveDataLocalcy()
        pushVc(viewConterlerId: "WorkExperienceViewController")
    }
    
    func validation(){
        self.tfDesiredCountry.text = self.tfDesiredCountry.text?.trim()
        self.tfDesiredProvince.text = self.tfDesiredProvince.text?.trim()
        self.tfDesiredCity.text = self.tfDesiredCity.text?.trim()
        
        if (tfDesiredCountry.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.CountrySelection, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfDesiredProvince.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.provienceSelection, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfDesiredCity.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.citySelection, title:MessageConstant.k_AlertTitle, controller: self)
        }else{
            saveDataLocalcy()
            pushVc(viewConterlerId: "WorkExperienceViewController")
        }
    }
    
}


extension LocationInfoViewController{
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.signInData.strSelectedDesiredCountry = self.tfDesiredCountry.text!
        objAppShareData.signInData.strSelectedDesiredProvience = self.tfDesiredProvince.text!
        objAppShareData.signInData.strSelectedDesiredCity = self.tfDesiredCity.text!
        
        objAppShareData.signInData.strSelectedDesiredCountryID = self.selectedIndexCountry ?? "0"
        objAppShareData.signInData.strSelectedDesiredProvienceID = self.selectedIndexProvience ?? "0"
        objAppShareData.signInData.strSelectedDesiredCityID = self.selectedIndexCity ?? "0"
        
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let desiredCountry = objAppShareData.signInData.strSelectedDesiredCountry as String?{
            self.tfDesiredCountry.text! = desiredCountry
            self.selectedIndexCountry = objAppShareData.signInData.strSelectedDesiredCountryID
        }
        if let desiredProvience = objAppShareData.signInData.strSelectedDesiredProvience as String?{
            self.tfDesiredProvince.text! = desiredProvience
            self.selectedIndexProvience = objAppShareData.signInData.strSelectedDesiredProvienceID
        }
        if let desiredCity = objAppShareData.signInData.strSelectedDesiredCity as String?{
            self.tfDesiredCity.text! = desiredCity
            self.selectedIndexCity = objAppShareData.signInData.strSelectedDesiredCityID
        }
    }
}

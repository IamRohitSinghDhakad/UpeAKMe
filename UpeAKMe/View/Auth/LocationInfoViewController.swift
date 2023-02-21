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
    @IBOutlet weak var lblDesiredCity: UILabel!
    @IBOutlet weak var imgVwYes: UIImageView!
    @IBOutlet weak var imgVwNo: UIImageView!
    
    var strSelectedRelocation:String?
    var selectedIndexCountry:String?
    var selectedIndexProvience:String?
    var selectedIndexCity:String?
    var arrDesiredCityID  = [Int]()
    var arrDesiredProvienceID  = [Int]()
    var arrDesiredCountryID  = [Int]()
    var arrayMuncipalOptions = [MuncipalModel]()
    var strSelectedDesiredCity = ""
    var strSelectedDesiredCityID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdown()
        self.call_WsGetNation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkSavedDataAndFill()
    }
    
    
    //MARK: - Setup Dropdown
        func setupDropdown() {
           //==============================//
//            tfDesiredCountry.optionArray = dropDownArray
//            tfDesiredProvince.optionArray = dropDownArray
//            tfDesiredCity.optionArray = dropDownArray
            //Delegate
            tfDesiredCountry.delegate = self
            tfDesiredProvince.delegate = self
            //=========== XXXX ============//
            
            
            tfDesiredCountry.didSelect{(selectedText , index ,id) in
                self.tfDesiredCountry.text = selectedText
                self.selectedIndexCountry = "\(id)"
                self.tfDesiredCountry.hideList()
                self.tfDesiredProvince.text = ""
                self.tfDesiredProvince.placeholder = "Select Provience"
                self.call_WsGetprovience(strNationID: "\(id)")
            }
            
            tfDesiredProvince.didSelect{(selectedText , index ,id) in
                self.tfDesiredProvince.text = selectedText
                self.selectedIndexProvience = "\(id)"
                self.call_WsGetMuncipal(strProvience: "\(id)")
                self.tfDesiredProvince.hideList()
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
    
    //MARK: - IBAction
        @IBAction func btnOnRelocation(_ sender: UIButton) {
            switch sender.tag {
            case 7:
                setRelocation(strType: MessageConstant.Yes)
            case 8:
                setRelocation(strType: MessageConstant.No)
            default:
                break
            }
        }
    
    func validation(){
        self.tfDesiredCountry.text = self.tfDesiredCountry.text?.trim()
        self.tfDesiredProvince.text = self.tfDesiredProvince.text?.trim()
        
        if (tfDesiredCountry.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.CountrySelection, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfDesiredProvince.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.provienceSelection, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (lblDesiredCity.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.citySelection, title:MessageConstant.k_AlertTitle, controller: self)
        }else{
            saveDataLocalcy()
            pushVc(viewConterlerId: "WorkExperienceViewController")
        }
    }
    
    func setRelocation(strType: String){
        resetRelocationImages()
        switch strType{
        case MessageConstant.Yes:
            self.imgVwYes.image = .init(named: "radio_selected")
            strSelectedRelocation = MessageConstant.Yes
        case MessageConstant.No:
           self.imgVwNo.image = .init(named: "radio_selected")
            strSelectedRelocation = MessageConstant.No
        default:
            break
        }
    }
    
    func resetRelocationImages(){
        self.imgVwYes.image = .init(named: "radio_button")
        self.imgVwNo.image = .init(named: "radio_button")
    }
    
    @IBAction func btnOnCity(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController")as! PopUpViewController
        vc.strIsComingFrom = "City"
        vc.strTitle = "Select City".localized()
        vc.arrayMuncipalOptions = self.arrayMuncipalOptions
        vc.closerForSelectionTable = {[weak self] dict in
            if dict.count != 0{
                
                self?.strSelectedDesiredCity = dict["City"]as? String ?? ""
                self?.strSelectedDesiredCityID = dict["CityID"]as? String ?? ""
                self?.selectedIndexCity = self?.strSelectedDesiredCityID
                self?.lblDesiredCity.text = dict["City"]as? String ?? ""
            }
        }
        
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true // available in IOS13
        }
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true,completion: nil)
    }
    
}


extension LocationInfoViewController{
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.UserDetail.strSelectedDesiredCountry = self.tfDesiredCountry.text!
        objAppShareData.UserDetail.strSelectedDesiredProvience = self.tfDesiredProvince.text!
        objAppShareData.UserDetail.strSelectedDesiredCity = self.lblDesiredCity.text!
        objAppShareData.UserDetail.strSelectedDesiredCountryID = self.selectedIndexCountry ?? "0"
        objAppShareData.UserDetail.strSelectedDesiredProvienceID = self.selectedIndexProvience ?? "0"
        objAppShareData.UserDetail.strSelectedDesiredCityID = self.selectedIndexCity ?? "0"
        objAppShareData.UserDetail.strSelectedDesiredRelocation = self.strSelectedRelocation!
        
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let desiredCountry = objAppShareData.UserDetail.strSelectedDesiredCountry as String?{
            self.tfDesiredCountry.text! = desiredCountry
            self.selectedIndexCountry = objAppShareData.UserDetail.strSelectedDesiredCountryID
        }
        if let desiredProvience = objAppShareData.UserDetail.strSelectedDesiredProvience as String?{
            self.tfDesiredProvince.text! = desiredProvience
            self.selectedIndexProvience = objAppShareData.UserDetail.strSelectedDesiredProvienceID
        }
        if let desiredCity = objAppShareData.UserDetail.strSelectedDesiredCity as String?{
            if desiredCity == ""{
                self.lblDesiredCity.text! = "Desired City"
            }else{
                self.lblDesiredCity.text! = desiredCity
                self.selectedIndexCity = objAppShareData.UserDetail.strSelectedDesiredCityID
            }
           
        }
        if let relocation = objAppShareData.UserDetail.strSelectedDesiredRelocation as String?{
            self.setRelocation(strType: relocation)
        }
    }
}

//Call Webservice
extension LocationInfoViewController{
    
    //MARK:- Nation
    func call_WsGetNation(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetNation, queryParams: [:], params: [:], strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    
                    for data in user_details{
                        let obj = NationModel.init(dict: data)
                        self.tfDesiredCountry.optionArray.append(obj.strName)
                        self.arrDesiredCountryID.append(obj.strID)
                    }
                    self.tfDesiredCountry.optionIds = self.arrDesiredCountryID
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
    
    
    //MARK:- Provience
    func call_WsGetprovience(strNationID:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = ["nation_id":strNationID] as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getProvince, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    self.tfDesiredProvince.optionArray.removeAll()
                    self.tfDesiredProvince.optionIds?.removeAll()
                    self.arrDesiredProvienceID.removeAll()
                    for data in user_details{
                        let obj = ProvienceModel.init(dict: data)
                        self.tfDesiredProvince.optionArray.append(obj.strName)
                        self.arrDesiredProvienceID.append(obj.strID)
                    }
                    self.tfDesiredProvince.optionIds = self.arrDesiredProvienceID
                    
                  
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "", message: msgg, controller: self) {
                       
                    }
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        } failure: { (Error) in
            //  print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    
    //MARK:- Muncipal
    func call_WsGetMuncipal(strProvience:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = [
                         "province_id":strProvience] as [String:Any]
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getMunicipality, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [[String:Any]] {
                    self.arrayMuncipalOptions.removeAll()
                    self.arrDesiredCityID.removeAll()
                    for data in user_details{
                        let obj = MuncipalModel.init(dict: data)
                        self.arrayMuncipalOptions.append(obj)
                    }
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlertSingleButtonCallBack(alertBtn: "OK", title: "", message: msgg, controller: self) {
                       
                    }
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

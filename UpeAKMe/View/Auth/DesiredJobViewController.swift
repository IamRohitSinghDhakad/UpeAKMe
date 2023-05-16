//
//  DesiredJobViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit
import iOSDropDown


class DesiredJobViewController: UIViewController, UITextFieldDelegate {

//MARK: - IBOutlets
    @IBOutlet var lblDesiredJob: UILabel!
    @IBOutlet var tfDesiredField: DropDown!
    @IBOutlet var tfDesiredFieldPosition: DropDown!
    @IBOutlet var tfWhatisYourDesiredpayAnnual: DropDown!
    @IBOutlet var tfDesiredVaccation: DropDown!
    @IBOutlet var lblJobType: UILabel!
    @IBOutlet var lblPartTime: UILabel!
    @IBOutlet var lblFulltime: UILabel!
    @IBOutlet var lblContractInternship: UILabel!
    @IBOutlet var imgVwContractInternship: UIImageView!
    @IBOutlet var imgVwFullTime: UIImageView!
    @IBOutlet var imgVwPartTime: UIImageView!
    @IBOutlet var lblYourDesiredWorkPlace: UILabel!
    @IBOutlet var imgVwWFH: UIImageView!
    @IBOutlet var imgVwHybrid: UIImageView!
    @IBOutlet var imgVwInOffice: UIImageView!
    @IBOutlet weak var imgVwDayTime: UIImageView!
    @IBOutlet weak var imgVwNightTime: UIImageView!
    @IBOutlet weak var imgVwMondaySaturday: UIImageView!
    @IBOutlet weak var imgVwMondayFriday: UIImageView!
    @IBOutlet weak var imgVwOther: UIImageView!
    
    //MARK: - Outlets
    var strSelectedJobType:String?
    var strSelectedWorkSetting:String?
    var arrDesiredFieldID = [Int]()
    var arrDesiredFieldPositionID = [Int]()
    var arrDesiredFieldNames = [String]()
    var selectedDesiredFieldID:String?
    var selectedDesiredPositionFieldID:String?
    var selectedDesiredWorkSchedule:String?
    let desiredPayAnnualArray: [String] = ["What is your desired pay annual".localized(), "30000+", "40000+", "50000+", "60000+", "70000+", "80000+", "100000+"]
    let desiredVacationArray: [String] = ["Desired Vacation".localized(), "2 weeks+".localized(), "3 week+".localized(), "4 weeks+".localized(), "Unlimited".localized()]
    var arrSelectedDesiredWorkSchedule = [String]()
    var arrSelectedJobType = [String]()
    var arrSelectedDesiredWorkSetting = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdown()
      if objAppShareData.isComingFromEdit{
            
        }else{
            setDefaultStylingAndData()
        }
        self.call_wsGetDesiredField()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkSavedDataAndFill()
        if objAppShareData.isComingFromEdit{
            self.call_wsGetDesiredFieldPosition(strDesiredID: objAppShareData.UserDetail.strSelectedDesiredFieldID)
        }
    }
    
    
//MARK: - Default Styling
    func setDefaultStylingAndData() {
        objAppShareData.UserDetail.strSelectedDesiredJobType = JobType.strPartTime
        objAppShareData.UserDetail.strSelectedDesiredWorkSetting = WorkSetting.strWFH
        objAppShareData.UserDetail.strSelectedDesiredRelocation = MessageConstant.Yes
        objAppShareData.UserDetail.strSelectedDesiredWorkSchedule = WorkSchedule.strDayTime
        arrSelectedDesiredWorkSchedule.append(WorkSchedule.strDayTime)
        arrSelectedJobType.append(JobType.strPartTime)
        arrSelectedDesiredWorkSetting.append(WorkSetting.strWFH)
    }
    
//MARK: - Setup Dropdown
    func setupDropdown() {
       //==============================//
        tfWhatisYourDesiredpayAnnual.optionArray = desiredPayAnnualArray
        tfDesiredVaccation.optionArray = desiredVacationArray
        //Delegate
        tfDesiredFieldPosition.delegate = self
        tfWhatisYourDesiredpayAnnual.delegate = self
        tfDesiredVaccation.delegate = self
        //=========== XXXX ============//
        
        
        tfWhatisYourDesiredpayAnnual.text = desiredPayAnnualArray[0]
        tfDesiredVaccation.text = desiredVacationArray[0]
        tfDesiredField.delegate = self
        
        tfDesiredField.didSelect{(selectedText , index ,id) in
            self.tfDesiredField.text = selectedText
            self.tfDesiredField.hideList()
            self.tfDesiredFieldPosition.optionArray.removeAll()
            self.tfDesiredFieldPosition.optionIds?.removeAll()
            self.tfDesiredFieldPosition.text = ""
            self.selectedDesiredFieldID = "\(id)"
            self.call_wsGetDesiredFieldPosition(strDesiredID: "\(id)")
        }
        
        tfDesiredFieldPosition.didSelect{(selectedText , index ,id) in
            self.tfDesiredFieldPosition.text = selectedText
            self.selectedDesiredPositionFieldID = "\(id)"
            self.tfDesiredFieldPosition.hideList()
        }
        
        tfWhatisYourDesiredpayAnnual.didSelect{(selectedText , index ,id) in
            self.tfWhatisYourDesiredpayAnnual.text = selectedText
            self.tfWhatisYourDesiredpayAnnual.hideList()
        }
        
        tfDesiredVaccation.didSelect{(selectedText , index ,id) in
            self.tfDesiredVaccation.text = selectedText
            self.tfDesiredVaccation.hideList()
        }
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
       saveDataLocalcy()
       pushVc(viewConterlerId: "LocationInfoViewController")
    }

    
    @IBAction func btnOnDesiredWorkSetting(_ sender: UIButton) {
       
        switch sender.tag {
        case 4:
            if arrSelectedDesiredWorkSetting.contains(WorkSetting.strWFH){
                arrSelectedDesiredWorkSetting.removeAll(where: {$0 == WorkSetting.strWFH})
                self.imgVwWFH.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSetting.append(WorkSetting.strWFH)
                self.imgVwWFH.image = UIImage.init(named: "radio_selected")
            }
            //self.setWorkSetting(strType: WorkSetting.strWFH)
        case 5:
            if arrSelectedDesiredWorkSetting.contains(WorkSetting.strHybrid){
                arrSelectedDesiredWorkSetting.removeAll(where: {$0 == WorkSetting.strHybrid})
                self.imgVwHybrid.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSetting.append(WorkSetting.strHybrid)
                self.imgVwHybrid.image = UIImage.init(named: "radio_selected")
            }
           // self.setWorkSetting(strType: WorkSetting.strHybrid)
        case 6:
            if arrSelectedDesiredWorkSetting.contains(WorkSetting.strInOffice){
                arrSelectedDesiredWorkSetting.removeAll(where: {$0 == WorkSetting.strInOffice})
                self.imgVwInOffice.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSetting.append(WorkSetting.strInOffice)
                self.imgVwInOffice.image = UIImage.init(named: "radio_selected")
            }
            //self.setWorkSetting(strType: WorkSetting.strInOffice)
        default:
            break
        }
    }
    @IBAction func btnOnJobType(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if arrSelectedJobType.contains(JobType.strPartTime){
                arrSelectedJobType.removeAll(where: {$0 == JobType.strPartTime})
                self.imgVwPartTime.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedJobType.append(JobType.strPartTime)
                self.imgVwPartTime.image = UIImage.init(named: "radio_selected")
            }
           // setJobType(strType: JobType.strPartTime)
        case 2:
            if arrSelectedJobType.contains(JobType.strFullime){
                arrSelectedJobType.removeAll(where: {$0 == JobType.strFullime})
                self.imgVwFullTime.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedJobType.append(JobType.strFullime)
                self.imgVwFullTime.image = UIImage.init(named: "radio_selected")
            }
            //setJobType(strType: JobType.strFullime)
        case 3:
            if arrSelectedJobType.contains(JobType.strContractInternship){
                arrSelectedJobType.removeAll(where: {$0 == JobType.strContractInternship})
                self.imgVwContractInternship.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedJobType.append(JobType.strContractInternship)
                self.imgVwContractInternship.image = UIImage.init(named: "radio_selected")
            }
            //setJobType(strType: JobType.strContractInternship)
        default:
            break
        }
    }
    
    @IBAction func btnWorkSchedule(_ sender: UIButton) {
        switch sender.tag {
        case 7:
            if arrSelectedDesiredWorkSchedule.contains(WorkSchedule.strDayTime){
                arrSelectedDesiredWorkSchedule.removeAll(where: {$0 == WorkSchedule.strDayTime})
                self.imgVwDayTime.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSchedule.append(WorkSchedule.strDayTime)
                self.imgVwDayTime.image = UIImage.init(named: "radio_selected")
            }
        case 8:
            if arrSelectedDesiredWorkSchedule.contains(WorkSchedule.strNightTime){
                arrSelectedDesiredWorkSchedule.removeAll(where: {$0 == WorkSchedule.strNightTime})
                self.imgVwNightTime.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSchedule.append(WorkSchedule.strNightTime)
                self.imgVwNightTime.image = UIImage.init(named: "radio_selected")
            }
           
        case 9:
            if arrSelectedDesiredWorkSchedule.contains(WorkSchedule.strMondaySaturday){
                arrSelectedDesiredWorkSchedule.removeAll(where: {$0 == WorkSchedule.strMondaySaturday})
                self.imgVwMondaySaturday.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSchedule.append(WorkSchedule.strMondaySaturday)
                self.imgVwMondaySaturday.image = UIImage.init(named: "radio_selected")
            }
           
        case 10:
            if arrSelectedDesiredWorkSchedule.contains(WorkSchedule.strMondayFriday){
                arrSelectedDesiredWorkSchedule.removeAll(where: {$0 == WorkSchedule.strMondayFriday})
                self.imgVwMondayFriday.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSchedule.append(WorkSchedule.strMondayFriday)
                self.imgVwMondayFriday.image = UIImage.init(named: "radio_selected")
            }
          
        case 11:
            if arrSelectedDesiredWorkSchedule.contains(WorkSchedule.strOther){
                arrSelectedDesiredWorkSchedule.removeAll(where: {$0 == WorkSchedule.strOther})
                self.imgVwOther.image = UIImage.init(named: "radio_button")
            }else{
                arrSelectedDesiredWorkSchedule.append(WorkSchedule.strOther)
                self.imgVwOther.image = UIImage.init(named: "radio_selected")
            }
           
        default:
            break
        }
    }
    
}

extension DesiredJobViewController{
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        if self.arrSelectedDesiredWorkSchedule.count != 0{
            self.selectedDesiredWorkSchedule = self.arrSelectedDesiredWorkSchedule.joined(separator: ",")
        }
        print(self.arrSelectedJobType)
        if self.arrSelectedJobType.count != 0{
            self.strSelectedJobType = self.arrSelectedJobType.joined(separator: ",")
        }
        if self.arrSelectedDesiredWorkSetting.count != 0{
            self.strSelectedWorkSetting = self.arrSelectedDesiredWorkSetting.joined(separator: ",")
        }
        
        objAppShareData.UserDetail.strSelectedDesiredField = self.tfDesiredField.text!
        objAppShareData.UserDetail.strSelectedDesiredFieldID = self.selectedDesiredFieldID ?? ""
        objAppShareData.UserDetail.strSelectedDesiredFieldPosition = self.tfDesiredFieldPosition.text!
        objAppShareData.UserDetail.strSelectedDesiredFieldPositionID = self.selectedDesiredPositionFieldID ?? ""
        objAppShareData.UserDetail.strSelectedDesiredJobType = self.strSelectedJobType ?? ""
        objAppShareData.UserDetail.strSelectedDesiredWorkSetting = self.strSelectedWorkSetting ?? ""
        objAppShareData.UserDetail.strSelectedDesiredWorkSchedule = self.selectedDesiredWorkSchedule ?? ""
        objAppShareData.UserDetail.strSelectedDesiredPayAnnual = self.tfWhatisYourDesiredpayAnnual.text!
        objAppShareData.UserDetail.strSelectedDesiredVaccation = self.tfDesiredVaccation.text!
        
        print(objAppShareData.UserDetail)
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let desiredField = objAppShareData.UserDetail.strSelectedDesiredField as String?{
            self.tfDesiredField.text! = ""
            self.tfDesiredField.text! = desiredField
            self.selectedDesiredFieldID = objAppShareData.UserDetail.strSelectedDesiredFieldID as String?
        }
        if let desiredFieldPostion = objAppShareData.UserDetail.strSelectedDesiredFieldPosition as String?{
            self.tfDesiredFieldPosition.text! = desiredFieldPostion
            self.selectedDesiredPositionFieldID = objAppShareData.UserDetail.strSelectedDesiredFieldPositionID as String?
        }
        if let jobType = objAppShareData.UserDetail.strSelectedDesiredJobType as String?{
            self.setJobType(strType: jobType)
        }
        
        if let workSettingType = objAppShareData.UserDetail.strSelectedDesiredWorkSetting as String?{
            self.setWorkSetting(strType: workSettingType)

            
        }
        if let workSchedule = objAppShareData.UserDetail.strSelectedDesiredWorkSchedule as String?{
            
            setWorkSchedule(str: workSchedule)
            
//            let x = workSchedule.split(separator: ",")
//            self.setWorkSchedule(str: x)
//            if objAppShareData.isComingFromEdit{
//
//            }else{
//                setWorkSchedule(str: workSchedule)
//            }
           
        }
        if let payAnnual = objAppShareData.UserDetail.strSelectedDesiredPayAnnual as String?{
            self.tfWhatisYourDesiredpayAnnual.text! = payAnnual
        }
        if let desiredVaccation = objAppShareData.UserDetail.strSelectedDesiredVaccation as String?{
            self.tfDesiredVaccation.text! = desiredVaccation
        }
    }
    
    func setWorkSchedule(str: String){
        print(str)
        self.arrSelectedDesiredWorkSchedule = str.components(separatedBy: ",")
//        self.arrSelectedDesiredWorkSchedule.removeAll()
//        for data in str{
//            self.arrSelectedDesiredWorkSchedule.append("\(data)")
//        }
//        print(self.arrSelectedDesiredWorkSchedule)
        
        if "\(str)".contains(WorkSchedule.strDayTime){
            self.imgVwDayTime.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwDayTime.image = UIImage.init(named: "radio_button")
        }
        
        if "\(str)".contains(WorkSchedule.strNightTime){
            self.imgVwNightTime.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwNightTime.image = UIImage.init(named: "radio_button")
        }
        
        if "\(str)".contains(WorkSchedule.strMondayFriday){
            self.imgVwMondayFriday.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwMondayFriday.image = UIImage.init(named: "radio_button")
        }
        
        if "\(str)".contains(WorkSchedule.strMondaySaturday){
            self.imgVwMondaySaturday.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwMondaySaturday.image = UIImage.init(named: "radio_button")
        }
        if "\(str)".contains(WorkSchedule.strOther){
            self.imgVwOther.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwOther.image = UIImage.init(named: "radio_button")
        }
    }
    
    func setJobType(strType: String){
      //  resetJobTypeImages()
//        switch strType{
//        case JobType.strPartTime:
//            self.imgVwPartTime.image = .init(named: "radio_selected")
//            strSelectedJobType = JobType.strPartTime
//        case JobType.strFullime:
//            self.imgVwFullTime.image = .init(named: "radio_selected")
//            strSelectedJobType = JobType.strFullime
//        case JobType.strContractInternship:
//            self.imgVwContractInternship.image = .init(named: "radio_selected")
//            strSelectedJobType = JobType.strContractInternship
//        default:
//            break
//        }
        
        self.arrSelectedJobType = strType.components(separatedBy: ",")
      //  self.strSelectedJobType = "\(strType)".stripped
        
        if "\(strType)".contains(JobType.strPartTime){
            self.imgVwPartTime.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwPartTime.image = UIImage.init(named: "radio_button")
        }
        
        if "\(strType)".contains(JobType.strFullime){
            self.imgVwFullTime.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwFullTime.image = UIImage.init(named: "radio_button")
        }
        
        if "\(strType)".contains(JobType.strContractInternship){
            self.imgVwContractInternship.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwContractInternship.image = UIImage.init(named: "radio_button")
        }
        
    }
    
    func setWorkSetting(strType: String){
       // resetWorkSettingImages()
//        switch strType{
//        case WorkSetting.strWFH:
//            self.imgVwWFH.image = .init(named: "radio_selected")
//            strSelectedWorkSetting = WorkSetting.strWFH
//        case WorkSetting.strHybrid:
//            self.imgVwHybrid.image = .init(named: "radio_selected")
//            strSelectedWorkSetting = WorkSetting.strHybrid
//        case WorkSetting.strInOffice:
//            self.imgVwInOffice.image = .init(named: "radio_selected")
//            strSelectedWorkSetting = WorkSetting.strInOffice
//        default:
//            break
//        }
        
       self.arrSelectedDesiredWorkSetting = strType.components(separatedBy: ",")
        
        if "\(strType)".contains(WorkSetting.strWFH){
            self.imgVwWFH.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwWFH.image = UIImage.init(named: "radio_button")
        }
        if "\(strType)".contains(WorkSetting.strHybrid){
            self.imgVwHybrid.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwHybrid.image = UIImage.init(named: "radio_button")
        }
        if "\(strType)".contains(WorkSetting.strInOffice){
            self.imgVwInOffice.image = UIImage.init(named: "radio_selected")
        }else{
            self.imgVwInOffice.image = UIImage.init(named: "radio_button")
        }
    }
    
}

extension DesiredJobViewController{
    //MARK: - Reset Values
    func resetJobTypeImages() {
        self.imgVwPartTime.image = .init(named: "radio_button")
        self.imgVwFullTime.image = .init(named: "radio_button")
        self.imgVwContractInternship.image = .init(named: "radio_button")
    }
    func resetWorkSettingImages() {
        self.imgVwWFH.image = .init(named: "radio_button")
        self.imgVwHybrid.image = .init(named: "radio_button")
        self.imgVwInOffice.image = .init(named: "radio_button")
    }
    
}


extension DesiredJobViewController{
    
    func call_wsGetDesiredField(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: MessageConstant.NoNetwork.localized(), title: MessageConstant.k_AlertTitle.localized(), controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getDesired, queryParams: [:], params: [:], strCustomValidation: "", showIndicator: false) { response in
            
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                
                guard let arrResult = response["result"]as? [[String:Any]] else{return}
                
                for data in arrResult{
                    let obj = DesiredFieldModel.init(dict: data)
                    if LocalizationSystem.sharedInstance.getLanguage() == "en"{
                        self.tfDesiredField.optionArray.append(obj.strDesiredName ?? "")
                    }else{
                        self.tfDesiredField.optionArray.append(obj.strDesiredNameFr ?? "")
                    }
                   
                    self.arrDesiredFieldID.append(obj.strDesiredID ?? 0)
                }
                self.tfDesiredField.optionIds = self.arrDesiredFieldID
                
            }else{
                debugPrint(message ?? "Error Occured")
            }
            
        } failure: { Error in
            debugPrint(Error)
        }
    }
    
    //=============== Desired Field Postion ==================//
    func call_wsGetDesiredFieldPosition(strDesiredID: String){
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: MessageConstant.NoNetwork.localized(), title: MessageConstant.k_AlertTitle.localized(), controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dictParam = ["desired_id":strDesiredID,
                         "language":objAppShareData.UserDetail.strSelectedLanguage] as [String:Any]
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getDesiredPosition, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                
                guard let arrResult = response["result"]as? [[String:Any]] else{return}
                
                self.tfDesiredFieldPosition.optionArray.removeAll()
                self.arrDesiredFieldPositionID.removeAll()
                
                for data in arrResult{
                    let obj = DesiredFieldModel.init(dict: data)
                    if LocalizationSystem.sharedInstance.getLanguage() == "en"{
                        self.tfDesiredFieldPosition.optionArray.append(obj.strDesiredPositionName ?? "")
                    }else{
                        self.tfDesiredFieldPosition.optionArray.append(obj.strDesiredPositionNameFr ?? "")
                    }
                    
                    self.arrDesiredFieldPositionID.append(obj.strDesiredPositionID ?? 0)
                    
                    if objAppShareData.isComingFromEdit{
                        var str = String(obj.strDesiredPositionID ?? 0)
                        if str == objAppShareData.UserDetail.strSelectedDesiredFieldPositionID{
                            
                          //  self.tfDesiredFieldPosition.text = obj.strDesiredPositionName
                            if LocalizationSystem.sharedInstance.getLanguage() == "en"{
                                self.tfDesiredFieldPosition.optionArray.append(obj.strDesiredPositionName ?? "")
                            }else{
                                self.tfDesiredFieldPosition.optionArray.append(obj.strDesiredPositionNameFr ?? "")
                            }
                            self.selectedDesiredPositionFieldID = objAppShareData.UserDetail.strSelectedDesiredFieldPositionID
                        }
                        
                    }
                }
                
                self.tfDesiredFieldPosition.optionIds = self.arrDesiredFieldPositionID
                
            }else{
                debugPrint(message ?? "Error Occured")
            }
            
        } failure: { Error in
            debugPrint(Error)
        }
    }
    
}
extension String {

    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=.!_,")
        return self.filter {okayChars.contains($0) }
    }
}

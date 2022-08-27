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
    @IBOutlet var tfWorkSchedule: DropDown!
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
    @IBOutlet var imgVwYes: UIImageView!
    @IBOutlet var imgVwNo: UIImageView!
    
    //MARK: - Outlets
    var strSelectedJobType:String?
    var strSelectedWorkSetting:String?
    var strSelectedRelocation:String?
    
    let workScheduleArray: [String] = ["Work Schedule", "Day Time", "Night Time", "Monday-Saturday", "Monday-Friday", "Other"]
    let desiredPayAnnualArray: [String] = ["What is your desired pay annual", "30000+", "40000+", "50000+", "60000+", "70000+", "80000+", "100000+"]
    let desiredVacationArray: [String] = ["Desired Vacation", "2 weeks+", "3 week+", "4 weeks+", "Unlimited"]
    
    
    let dropDownArray: [String] = [MessageConstant.k_success, MessageConstant.k_AlertTitle, MessageConstant.k_AlertOK, MessageConstant.k_NoConnection]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdown()
        setDefaultStylingAndData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkSavedDataAndFill()
    }
    
    
//MARK: - Default Styling
    func setDefaultStylingAndData() {
        objAppShareData.signInData.strSelectedDesiredJobType = JobType.strPartTime
        objAppShareData.signInData.strSelectedDesiredWorkSetting = WorkSetting.strWFH
        objAppShareData.signInData.strSelectedDesiredRelocation = MessageConstant.Yes
    }
    
//MARK: - Setup Dropdown
    func setupDropdown() {
       //==============================//
        tfDesiredFieldPosition.optionArray = dropDownArray
        tfWorkSchedule.optionArray = workScheduleArray
        tfWhatisYourDesiredpayAnnual.optionArray = desiredPayAnnualArray
        tfDesiredVaccation.optionArray = desiredVacationArray
        //Delegate
        tfDesiredFieldPosition.delegate = self
        tfWorkSchedule.delegate = self
        tfWhatisYourDesiredpayAnnual.delegate = self
        tfDesiredVaccation.delegate = self
        //=========== XXXX ============//
        
        
        tfDesiredField.text = dropDownArray[0]
        tfWorkSchedule.text = workScheduleArray[0]
        tfWhatisYourDesiredpayAnnual.text = desiredPayAnnualArray[0]
        tfDesiredVaccation.text = desiredVacationArray[0]
        tfDesiredField.optionArray = dropDownArray
        tfDesiredField.selectedIndex = 0
        tfDesiredField.delegate = self
        tfDesiredField.optionArray = dropDownArray
        
        tfDesiredField.didSelect{(selectedText , index ,id) in
            self.tfDesiredField.text = selectedText
            self.tfDesiredField.hideList()
        }
        
        tfDesiredFieldPosition.didSelect{(selectedText , index ,id) in
            self.tfDesiredFieldPosition.text = selectedText
            self.tfDesiredFieldPosition.hideList()
        }
        
        tfWorkSchedule.didSelect{(selectedText , index ,id) in
            self.tfWorkSchedule.text = selectedText
            self.tfWorkSchedule.hideList()
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
    
    @IBAction func btnOnDesiredWorkSetting(_ sender: UIButton) {
       
        switch sender.tag {
        case 4:
            self.setWorkSetting(strType: WorkSetting.strWFH)
        case 5:
            self.setWorkSetting(strType: WorkSetting.strHybrid)
        case 6:
            self.setWorkSetting(strType: WorkSetting.strInOffice)
        default:
            break
        }
    }
    @IBAction func btnOnJobType(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            setJobType(strType: JobType.strPartTime)
        case 2:
            setJobType(strType: JobType.strFullime)
        case 3:
            setJobType(strType: JobType.strContractInternship)
        default:
            break
        }
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        saveDataLocalcy()
        pushVc(viewConterlerId: "LocationInfoViewController")
    }
}

extension DesiredJobViewController{
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.signInData.strSelectedDesiredField = self.tfDesiredField.text!
        objAppShareData.signInData.strSelectedDesiredFieldPosition = self.tfDesiredFieldPosition.text!
        objAppShareData.signInData.strSelectedDesiredJobType = self.strSelectedJobType!
        objAppShareData.signInData.strSelectedDesiredWorkSetting = self.strSelectedWorkSetting!
        objAppShareData.signInData.strSelectedDesiredWorkSchedule = self.tfWorkSchedule.text!
        objAppShareData.signInData.strSelectedDesiredPayAnnual = self.tfWhatisYourDesiredpayAnnual.text!
        objAppShareData.signInData.strSelectedDesiredRelocation = self.strSelectedRelocation!
        objAppShareData.signInData.strSelectedDesiredVaccation = self.tfDesiredVaccation.text!
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let desiredField = objAppShareData.signInData.strSelectedDesiredField as String?{
            self.tfDesiredField.text! = desiredField
        }
        if let desiredFieldPostion = objAppShareData.signInData.strSelectedDesiredFieldPosition as String?{
            self.tfDesiredFieldPosition.text! = desiredFieldPostion
        }
        if let jobType = objAppShareData.signInData.strSelectedDesiredJobType as String?{
            self.setJobType(strType: jobType)
        }
        if let workSettingType = objAppShareData.signInData.strSelectedDesiredWorkSetting as String?{
            setWorkSetting(strType: workSettingType)
        }
        if let workSchedule = objAppShareData.signInData.strSelectedDesiredWorkSchedule as String?{
            self.tfWorkSchedule.text! = workSchedule
        }
        if let payAnnual = objAppShareData.signInData.strSelectedDesiredPayAnnual as String?{
            self.tfWhatisYourDesiredpayAnnual.text! = payAnnual
        }
        if let desiredVaccation = objAppShareData.signInData.strSelectedDesiredVaccation as String?{
            self.tfDesiredVaccation.text! = desiredVaccation
        }
        if let relocation = objAppShareData.signInData.strSelectedDesiredRelocation as String?{
            self.setRelocation(strType: relocation)
        }
        
    }
    
    func setJobType(strType: String){
        resetJobTypeImages()
        switch strType{
        case JobType.strPartTime:
            self.imgVwPartTime.image = .init(named: "radio_selected")
            strSelectedJobType = JobType.strPartTime
        case JobType.strFullime:
            self.imgVwFullTime.image = .init(named: "radio_selected")
            strSelectedJobType = JobType.strFullime
        case JobType.strContractInternship:
            self.imgVwContractInternship.image = .init(named: "radio_selected")
            strSelectedJobType = JobType.strContractInternship
        default:
            break
        }
    }
    
    func setWorkSetting(strType: String){
        resetWorkSettingImages()
        switch strType{
        case WorkSetting.strWFH:
            self.imgVwWFH.image = .init(named: "radio_selected")
            strSelectedWorkSetting = WorkSetting.strWFH
        case WorkSetting.strHybrid:
            self.imgVwHybrid.image = .init(named: "radio_selected")
            strSelectedWorkSetting = WorkSetting.strHybrid
        case WorkSetting.strInOffice:
            self.imgVwInOffice.image = .init(named: "radio_selected")
            strSelectedWorkSetting = WorkSetting.strInOffice
        default:
            break
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
    func resetRelocationImages(){
        self.imgVwYes.image = .init(named: "radio_button")
        self.imgVwNo.image = .init(named: "radio_button")
    }
}

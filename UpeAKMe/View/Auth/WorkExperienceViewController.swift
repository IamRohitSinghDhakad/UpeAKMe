//
//  WorkExperienceViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit

class WorkExperienceViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var lblWorkExperience: UILabel!
    @IBOutlet var lblWorkEx1: UILabel!
    @IBOutlet var lblWorkEx2: UILabel!
    @IBOutlet var vwOne: UIView!
    @IBOutlet var vwTwo: UIView!
    @IBOutlet var tfJobTitle1: UITextField!
    @IBOutlet var tfCompanyName1: UITextField!
    @IBOutlet var tfLocation1: UITextField!
    @IBOutlet var lblDuration1: UILabel!
    @IBOutlet var sliderDuration1: UISlider!
    @IBOutlet var lblCurrentlyWorkHere1: UILabel!
    @IBOutlet var tfJobTitle2: UITextField!
    @IBOutlet var tfComapnyName2: UITextField!
    @IBOutlet var tfLocation2: UITextField!
    @IBOutlet var lblDuration2: UILabel!
    @IBOutlet var sliderDuration2: UISlider!
    @IBOutlet var lblIamWorkingHere2: UILabel!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var lblYes2: UILabel!
    @IBOutlet var imgVwYes2: UIImageView!
    @IBOutlet var lblNo2: UILabel!
    @IBOutlet var imgVwNo2: UIImageView!
    @IBOutlet var imgVwYes1: UIImageView!
    @IBOutlet var lblYes1: UILabel!
    @IBOutlet var imgVwNo1: UIImageView!
    @IBOutlet var lblNo1: UILabel!
    
    //MARK: - Variables
    var strSelectedWorkingHere1:String?
    var strSelectedWorkingHere2:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imgVwYes1.image = .init(named: "radio_selected")
        self.imgVwYes2.image = .init(named: "radio_selected")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkSavedDataAndFill()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        saveDataLocalcy()
        pushVc(viewConterlerId: "EducationViewController")
    }
    
    @IBAction func btnOnCurrentlyWorkHere1(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.imgVwYes1.image = .init(named: "radio_selected")
            self.imgVwNo1.image = .init(named: "radio_button")
            strSelectedWorkingHere1 = MessageConstant.Yes
        case 2:
            self.imgVwNo1.image = .init(named: "radio_selected")
            self.imgVwYes1.image = .init(named: "radio_button")
            strSelectedWorkingHere1 = MessageConstant.No
        case 3:
            self.imgVwNo2.image = .init(named: "radio_button")
            self.imgVwYes2.image = .init(named: "radio_selected")
            strSelectedWorkingHere2 = MessageConstant.Yes
        case 4:
            self.imgVwYes2.image = .init(named: "radio_button")
            self.imgVwNo2.image = .init(named: "radio_selected")
            strSelectedWorkingHere2 = MessageConstant.No
            
        default:
            break
        }
    }
    
    @IBAction func btnOnGoBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func sliderOnDuration(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        switch sender.tag {
        case 0:
            self.lblDuration1.text = "Duration (\(sliderValue) Year)"
        case 1:
            self.lblDuration2.text = "Duration (\(sliderValue) Year)"
        default:
            break
        }
    }
    
}


extension WorkExperienceViewController{
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.signInData.strJobTitle1 = self.tfJobTitle1.text!
        objAppShareData.signInData.strCompanyName1 = self.tfCompanyName1.text!
        objAppShareData.signInData.strLocation1 = self.tfLocation1.text!
        objAppShareData.signInData.strWorkDuration1 = "\(self.sliderDuration1.value)"
        objAppShareData.signInData.strCurrentlyWorkingHere1 = self.strSelectedWorkingHere1 ?? "No"
        
        objAppShareData.signInData.strJobTitle2 = self.tfJobTitle2.text!
        objAppShareData.signInData.strCompanyName2 = self.tfComapnyName2.text!
        objAppShareData.signInData.strLocation2 = self.tfLocation2.text!
        objAppShareData.signInData.strWorkDuration2 = "\(self.sliderDuration2.value)"
        objAppShareData.signInData.strCurrentlyWorkingHere2 = self.strSelectedWorkingHere2 ?? "No"
        
        
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let jobTitle1 = objAppShareData.signInData.strJobTitle1 as String?{
            self.tfJobTitle1.text! = jobTitle1
        }
        if let companyName1 = objAppShareData.signInData.strCompanyName1 as String?{
            self.tfCompanyName1.text! = companyName1
        }
        if let location1 = objAppShareData.signInData.strLocation1 as String?{
            self.tfLocation1.text! = location1
        }
        if let durationValue1 = objAppShareData.signInData.strWorkDuration1 as String?{
            self.sliderDuration1.value = Float(durationValue1) ?? 0.0
        }
        if let workingHere1 = objAppShareData.signInData.strCurrentlyWorkingHere1 as String?{
            setWorkHere1(strType: workingHere1)
        }
        
        if let jobTitle2 = objAppShareData.signInData.strJobTitle2 as String?{
            self.tfJobTitle2.text! = jobTitle2
        }
        if let companyName2 = objAppShareData.signInData.strCompanyName2 as String?{
            self.tfComapnyName2.text! = companyName2
        }
        if let location2 = objAppShareData.signInData.strLocation2 as String?{
            self.tfLocation2.text! = location2
        }
        if let durationValue2 = objAppShareData.signInData.strWorkDuration2 as String?{
            self.sliderDuration2.value = Float(durationValue2) ?? 0.0
        }
        if let workingHere2 = objAppShareData.signInData.strCurrentlyWorkingHere2 as String?{
            setWorkHere2(strType: workingHere2)
        }
    }
    
    func setWorkHere1(strType: String){
        resetWorkHereImages1()
        switch strType{
        case MessageConstant.Yes:
            self.imgVwYes1.image = .init(named: "radio_selected")
            strSelectedWorkingHere1 = MessageConstant.Yes
        case MessageConstant.No:
            self.imgVwNo1.image = .init(named: "radio_selected")
            strSelectedWorkingHere1 = MessageConstant.No
        default:
            break
        }
    }
    
    func setWorkHere2(strType: String){
        resetWorkHereImages2()
        switch strType{
        case MessageConstant.Yes:
            self.imgVwYes2.image = .init(named: "radio_selected")
            strSelectedWorkingHere2 = MessageConstant.Yes
        case MessageConstant.No:
            self.imgVwNo2.image = .init(named: "radio_selected")
            strSelectedWorkingHere2 = MessageConstant.No
        default:
            break
        }
    }
    
    func resetWorkHereImages1(){
        self.imgVwYes1.image = .init(named: "radio_button")
        self.imgVwNo1.image = .init(named: "radio_button")
    }
    
    func resetWorkHereImages2(){
        self.imgVwYes2.image = .init(named: "radio_button")
        self.imgVwNo2.image = .init(named: "radio_button")
    }
}

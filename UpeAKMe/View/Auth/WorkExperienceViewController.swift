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
    
    var strSliderValue1:String?
    var strSliderValue2:String?
    
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
       validateForCreateAccount()
    }
    
    func validateForCreateAccount() {
        
        self.tfJobTitle1.text = self.tfJobTitle1.text!.trim()
        self.tfJobTitle2.text = self.tfJobTitle2.text!.trim()
        self.tfLocation1.text = self.tfLocation1.text!.trim()
        self.tfLocation2.text = self.tfLocation2.text!.trim()
        self.tfCompanyName1.text = self.tfCompanyName1.text!.trim()
        self.tfComapnyName2.text = self.tfComapnyName2.text!.trim()
        
        if (tfJobTitle1.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.Job_Title, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfCompanyName1.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.CompanyName, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfLocation1.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.location, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else if (tfJobTitle2.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.Job_Title, title:MessageConstant.k_AlertTitle, controller: self)
        }else if (tfComapnyName2.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.CompanyName, title:MessageConstant.k_AlertTitle, controller: self)
        }else if (tfLocation2.text?.isEmpty)! {
            objAlert.showAlert(message: MessageConstant.location, title:MessageConstant.k_AlertTitle, controller: self)
        }
        else{
            saveDataLocalcy()
            pushVc(viewConterlerId: "EducationViewController")
        }
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
            self.strSliderValue1 = "\(sliderValue)"
        case 1:
            self.lblDuration2.text = "Duration (\(sliderValue) Year)"
            self.strSliderValue2 = "\(sliderValue)"
        default:
            break
        }
    }
    
}


extension WorkExperienceViewController{
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.UserDetail.strJobTitle1 = self.tfJobTitle1.text!
        objAppShareData.UserDetail.strCompanyName1 = self.tfCompanyName1.text!
        objAppShareData.UserDetail.strLocation1 = self.tfLocation1.text!
        objAppShareData.UserDetail.strWorkDuration1 = self.strSliderValue1 ?? "0"
        objAppShareData.UserDetail.strCurrentlyWorkingHere1 = self.strSelectedWorkingHere1 ?? "No"
        
        objAppShareData.UserDetail.strJobTitle2 = self.tfJobTitle2.text!
        objAppShareData.UserDetail.strCompanyName2 = self.tfComapnyName2.text!
        objAppShareData.UserDetail.strLocation2 = self.tfLocation2.text!
        objAppShareData.UserDetail.strWorkDuration2 = self.strSliderValue2 ?? "0"
        objAppShareData.UserDetail.strCurrentlyWorkingHere2 = self.strSelectedWorkingHere2 ?? "No"
        
        
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let jobTitle1 = objAppShareData.UserDetail.strJobTitle1 as String?{
            if objAppShareData.isComingFromEdit{
                let x = jobTitle1.split(separator: ",").first
                let y = jobTitle1.split(separator: ",").last
                self.tfJobTitle1.text! = "\(x ?? "0")"
                self.tfJobTitle2.text! = "\(y ?? "0")"
            }else{
                self.tfJobTitle1.text! = jobTitle1
            }
           
        }
        if let companyName1 = objAppShareData.UserDetail.strCompanyName1 as String?{
            if objAppShareData.isComingFromEdit{
                let x = companyName1.split(separator: ",").first
                let y = companyName1.split(separator: ",").last
                self.tfCompanyName1.text! = "\(x ?? "0")"
                self.tfComapnyName2.text! = "\(y ?? "0")"
            }else{
                self.tfCompanyName1.text! = companyName1
            }
            
        }
        if let location1 = objAppShareData.UserDetail.strLocation1 as String?{
            if objAppShareData.isComingFromEdit{
                let x = location1.split(separator: ",").first
                let y = location1.split(separator: ",").last
                self.tfLocation1.text! = "\(x ?? "0")"
                self.tfLocation2.text! = "\(y ?? "0")"
            }else{
                self.tfLocation1.text! = location1
            }
        }
        if let durationValue1 = objAppShareData.UserDetail.strWorkDuration1 as String?{
            if objAppShareData.isComingFromEdit{
                let x = durationValue1.split(separator: ",").first
                let y = durationValue1.split(separator: ",").last
                print(x!,y!)
                self.lblDuration1.text = "Duration \(x ?? "0") Year"
                self.lblDuration2.text = "Duration \(y ?? "0") Year"
                self.sliderDuration1.value = Float(x ?? "0.0") ?? 0.0
                self.sliderDuration2.value = Float(y ?? "0.0") ?? 0.0
                self.strSliderValue1 = "\(x ?? "0")"
                self.strSliderValue2 = "\(y ?? "0")"
            }else{
                self.sliderDuration1.value = Float(durationValue1) ?? 0.0
            }
        }
        
        if let workingHere1 = objAppShareData.UserDetail.strCurrentlyWorkingHere1 as String?{
            if objAppShareData.isComingFromEdit{
                let x = workingHere1.split(separator: ",").first
                let y = workingHere1.split(separator: ",").last
                setWorkHere1(strType: "\(x ?? "")")
                setWorkHere2(strType: "\(y ?? "")")
            }else{
                setWorkHere1(strType: workingHere1)
            }
        }
        
        if let jobTitle2 = objAppShareData.UserDetail.strJobTitle2 as String?{
            if objAppShareData.isComingFromEdit{
                
            }else{
                self.tfJobTitle2.text! = jobTitle2
            }
            
        }
        if let companyName2 = objAppShareData.UserDetail.strCompanyName2 as String?{
            if objAppShareData.isComingFromEdit{
                
            }else{
                self.tfComapnyName2.text! = companyName2
            }
            
        }
        if let location2 = objAppShareData.UserDetail.strLocation2 as String?{
            if objAppShareData.isComingFromEdit{
                
            }else{
                self.tfLocation2.text! = location2
            }
            
        }
        if let durationValue2 = objAppShareData.UserDetail.strWorkDuration2 as String?{
            if objAppShareData.isComingFromEdit{
                
            }else{
                self.sliderDuration2.value = Float(durationValue2) ?? 0.0
            }
            
        }
        if let workingHere2 = objAppShareData.UserDetail.strCurrentlyWorkingHere2 as String?{
            if objAppShareData.isComingFromEdit{
                
            }else{
                setWorkHere2(strType: workingHere2)
            }
            
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

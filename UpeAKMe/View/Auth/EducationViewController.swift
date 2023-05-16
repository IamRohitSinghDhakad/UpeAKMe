//
//  EducationViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import UIKit
import iOSDropDown

class EducationViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var tfLevelEducation: DropDown!
    @IBOutlet var tfCertificateLevel: UITextField!
    @IBOutlet var lblSkill: UILabel!
    @IBOutlet var txtVw: RDTextView!
    @IBOutlet weak var lblSpokenLanguage: UILabel!
    @IBOutlet weak var lblWrittenLanguage: UILabel!
    @IBOutlet weak var lblDesired: UILabel!
    
    //MARK: - Variables
    var strSelectedSkillID:String?
    let  levelEducationArray: [String] = ["Level Education".localized(), "High school".localized(), "College".localized(), "Professional diploma".localized(), "Trade school".localized(), "University".localized(), "Bachelor's degree".localized(), "Master's degree".localized(), "Doctorate".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Delegate
        tfLevelEducation.delegate = self
        //=========== XXXX ============//
        setupDropdown()
    
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkSavedDataAndFill()
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        onBackPressed()
    }
    
    @IBAction func btnOnNext(_ sender: Any) {
        saveDataLocalcy()
        pushVc(viewConterlerId: "RecapViewController")
    }
    
    @IBAction func btnOnWrittenLanguage(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController")as! PopUpViewController
        vc.strTitle = "Written Language".localized()
        vc.strIsComingFrom = "WrittenLanguage"
        vc.closerForSelectionTable = {[weak self] dict in
            if dict.count != 0{
                self?.lblWrittenLanguage.text! = dict["WrittenLanguage"]as? String ?? ""
            }
        }
        self.isModalInPresentation = true
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func btnOnSpokenLanguage(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController")as! PopUpViewController
        vc.strTitle = "Spoken Language".localized()
        vc.strIsComingFrom = "SpokenLanguage"
        vc.closerForSelectionTable = {[weak self] dict in
            if dict.count != 0{
                self?.lblSpokenLanguage.text! = dict["SpokenLanguage"]as? String ?? ""
            }
        }
        self.isModalInPresentation = true
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func btnOnDesiredValues(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController")as! PopUpViewController
        vc.strTitle = "Desired Values@Work".localized()
        vc.strIsComingFrom = "Desired"
        vc.closerForSelectionTable = {[weak self] dict in
            if dict.count != 0{
                self?.lblDesired.text! = dict["Desired"]as? String ?? ""
            }
        }
        self.isModalInPresentation = true
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true,completion: nil)
    }
    @IBAction func btnOnSkill(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Auth", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController")as! PopUpViewController
        vc.strTitle = "Select Skill".localized()
        vc.strIsComingFrom = "Skill"
        vc.closerForSelectionTable = {[weak self] dict in
            if dict.count != 0{
                self?.strSelectedSkillID = dict["skill"]as? String
                self?.lblSkill.text! = dict["Skill"]as? String ?? ""
            }
        }
        self.isModalInPresentation = true
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true,completion: nil)
    }
}

extension EducationViewController: UITextFieldDelegate{
    
    //MARK: - Setup Dropdown
        func setupDropdown() {
           //==============================//
            tfLevelEducation.optionArray = levelEducationArray
            
            tfLevelEducation.text = levelEducationArray[0]
            
            tfLevelEducation.didSelect{(selectedText , index ,id) in
                self.tfLevelEducation.text = selectedText
                self.tfLevelEducation.hideList()
            }
        }
    
}


extension EducationViewController{
    
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.UserDetail.strLevelEducation = self.tfLevelEducation.text!
        objAppShareData.UserDetail.strCertificateLicense = self.tfCertificateLevel.text!
        objAppShareData.UserDetail.strSkills = self.lblSkill.text!
        objAppShareData.UserDetail.strDesiredValue = self.lblDesired.text!
        objAppShareData.UserDetail.strSkillID = self.strSelectedSkillID ?? "0"
        objAppShareData.UserDetail.strSpokenLanguage = self.lblSpokenLanguage.text!
        objAppShareData.UserDetail.strWrittenLanguage = self.lblWrittenLanguage.text!
        objAppShareData.UserDetail.strVolunteerWork = self.txtVw.text!
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let lvlEducation = objAppShareData.UserDetail.strLevelEducation as String?{
            self.tfLevelEducation.text! = lvlEducation
        }
        if let certificate = objAppShareData.UserDetail.strCertificateLicense as String?{
            self.tfCertificateLevel.text! = certificate
        }
        if let skill = objAppShareData.UserDetail.strSkills as String?{
            if skill == ""{
                self.lblSkill.text! = "Choose your best skills".localized()
                self.lblSkill.textColor = .lightGray
            }else{
                self.lblSkill.text! = skill
                self.lblSkill.textColor = .black
            }
        }
        if let desired = objAppShareData.UserDetail.strDesiredValue as String?{
            if desired == ""{
                self.lblDesired.text! = "Desired Values@Work".localized()
                self.lblDesired.textColor = .lightGray
            }else{
                self.lblDesired.text! = desired
                self.lblDesired.textColor = .black
            }
        }
        if let spokenLanguage = objAppShareData.UserDetail.strSpokenLanguage as String?{
            if spokenLanguage == ""{
                self.lblSpokenLanguage.text! = "Spoken Language".localized()
            }else{
                self.lblSpokenLanguage.text! = spokenLanguage
            }
            
        }
        if let writtenLanguage = objAppShareData.UserDetail.strWrittenLanguage as String?{
            if writtenLanguage == ""{
                self.lblWrittenLanguage.text! = "Written Language".localized()
            }else{
                self.lblWrittenLanguage.text! = writtenLanguage
            }
            
        }
        
        if let volunteerWork = objAppShareData.UserDetail.strVolunteerWork as String?{
            self.txtVw.text! = volunteerWork
        }
    }
    
}

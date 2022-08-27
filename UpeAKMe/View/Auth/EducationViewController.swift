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
    @IBOutlet var tfSpokenEnglish: DropDown!
    @IBOutlet var tfWrittenLanguage: DropDown!
    @IBOutlet var txtVw: RDTextView!
    
    //MARK: - Variables
    var strSelectedSkillID:String?
    let  levelEducationArray: [String] = ["Level Education", "High school", "College", "Professional diploma", "Trade school", "University", "Bachelor's degree", "Master's degree", "Doctorate"]
    let  spokenLanguageArray: [String] = ["Spoken Language", "French", "English", "Spanish", "Italian", "Greek", "Chinese", "Japanese", "Arabic", "Other"]
    let  writtenLanguageArray: [String] =  ["Written Language", "French", "English", "Spanish", "Italian", "Greek", "Chinese", "Japanese", "Arabic", "Other"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate
        tfLevelEducation.delegate = self
        tfSpokenEnglish.delegate = self
        tfWrittenLanguage.delegate = self
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
}

extension EducationViewController: UITextFieldDelegate{
    
    //MARK: - Setup Dropdown
        func setupDropdown() {
           //==============================//
            tfLevelEducation.optionArray = levelEducationArray
            tfSpokenEnglish.optionArray = spokenLanguageArray
            tfWrittenLanguage.optionArray = writtenLanguageArray
           
            
            tfLevelEducation.text = levelEducationArray[0]
            tfSpokenEnglish.text = spokenLanguageArray[0]
            tfWrittenLanguage.text = writtenLanguageArray[0]
            
            tfLevelEducation.didSelect{(selectedText , index ,id) in
                self.tfLevelEducation.text = selectedText
                self.tfLevelEducation.hideList()
            }
            
            tfSpokenEnglish.didSelect{(selectedText , index ,id) in
                self.tfSpokenEnglish.text = selectedText
                self.tfSpokenEnglish.hideList()
            }
            
            tfWrittenLanguage.didSelect{(selectedText , index ,id) in
                self.tfWrittenLanguage.text = selectedText
                self.tfWrittenLanguage.hideList()
            }
        }
    
}


extension EducationViewController{
    
    //MARK: - Save Localy data
    func saveDataLocalcy() {
        objAppShareData.signInData.strLevelEducation = self.tfLevelEducation.text!
        objAppShareData.signInData.strCertificateLicense = self.tfCertificateLevel.text!
        objAppShareData.signInData.strSkills = self.lblSkill.text!
        objAppShareData.signInData.strSkillID = self.strSelectedSkillID ?? "0"
        objAppShareData.signInData.strSpokenLanguage = self.tfSpokenEnglish.text!
        objAppShareData.signInData.strWrittenLanguage = self.tfWrittenLanguage.text!
        objAppShareData.signInData.strVolunteerWork = self.txtVw.text!
    }
    
    //MARK: - Fetch Saved Localy data
    func checkSavedDataAndFill(){
        if let lvlEducation = objAppShareData.signInData.strLevelEducation as String?{
            self.tfLevelEducation.text! = lvlEducation
        }
        if let certificate = objAppShareData.signInData.strCertificateLicense as String?{
            self.tfCertificateLevel.text! = certificate
        }
        if let skill = objAppShareData.signInData.strSkills as String?{
            self.lblSkill.text! = skill
        }
        if let spokenLanguage = objAppShareData.signInData.strSpokenLanguage as String?{
            self.tfSpokenEnglish.text! = spokenLanguage
        }
        if let writtenLanguage = objAppShareData.signInData.strWrittenLanguage as String?{
            self.tfWrittenLanguage.text! = writtenLanguage
        }
        
        if let volunteerWork = objAppShareData.signInData.strVolunteerWork as String?{
            self.txtVw.text! = volunteerWork
        }
    }
    
}

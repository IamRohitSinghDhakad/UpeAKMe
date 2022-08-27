//
//  SignInDetail.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 21/08/22.
//

import UIKit

class SignInDetail: NSObject {
    
    var straAuthToken          : String = ""
    var strDeviceId            : String = ""
    var strDeviceType          : String = ""
    var strEmail               : String = ""
    var strName                : String = ""
    var strFirstName           : String = ""
    var strLastName            : String = ""
    var strPassword            : String = ""
    var strPhoneNumber         : String = ""
    var strSelectedLanguage    : String = ""
    //Desired Job Controler Variables
    var strSelectedDesiredField: String = ""
    var strSelectedDesiredFieldPosition: String = ""
    var strSelectedDesiredJobType: String = ""
    var strSelectedDesiredWorkSetting: String = ""
    var strSelectedDesiredWorkSchedule: String = ""
    var strSelectedDesiredPayAnnual: String = ""
    var strSelectedDesiredRelocation: String = ""
    var strSelectedDesiredVaccation: String = ""
    //Location Controler Variables
    var strSelectedDesiredCountry: String = ""
    var strSelectedDesiredProvience: String = ""
    var strSelectedDesiredCity: String = ""
    var strSelectedDesiredCountryID: String = ""
    var strSelectedDesiredProvienceID: String = ""
    var strSelectedDesiredCityID: String = ""
   // WorkExperienceViewController
    ///1
    var strJobTitle1: String = ""
    var strCompanyName1: String = ""
    var strLocation1: String = ""
    var strWorkDuration1: String = ""
    var strCurrentlyWorkingHere1: String = ""
    ///2
    var strJobTitle2: String = ""
    var strCompanyName2: String = ""
    var strLocation2: String = ""
    var strWorkDuration2: String = ""
    var strCurrentlyWorkingHere2: String = ""
    // Education
    var strLevelEducation: String = ""
    var strCertificateLicense: String = ""
    var strSkills: String = ""
    var strSkillID: String = ""
    var strSpokenLanguage: String = ""
    var strWrittenLanguage: String = ""
    var strVolunteerWork: String = ""
    
    
    init(dict : [String:Any]) {
    
  }
}

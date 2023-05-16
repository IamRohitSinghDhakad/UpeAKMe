//
//  userDetailModel.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 21/08/22.
//

import UIKit

class userDetailModel: NSObject {
    
    var straAuthToken          : String = ""
    var strDeviceId            : String = ""
    var strDeviceType          : String = ""
    var strEmail               : String = ""
    var strName                : String = ""
    var strPassword            : String = ""
    var strPhoneNumber         : String = ""
    var strProfilePicture      : String = ""
    var strUserId              : String = ""
    var strUserName            : String = ""
    var strlatitude            : String = ""
    var strlongitude           : String = ""
    var strAddress             : String = ""
    var strAge                 : String = ""
    var strGender              : String = ""
    var strUserType            : String = ""
    var strFirstName           : String = ""
    var strLastName            : String = ""
    var strSelectedLanguage    : String = ""
    //Desired Job Controler Variables
    var strSelectedDesiredField: String = ""
    var strSelectedDesiredFieldID: String = ""
    var strSelectedDesiredFieldPosition: String = ""
    var strSelectedDesiredFieldPositionID:String = ""
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
    var strDesired: String = ""
    var strSkillID: String = ""
    var strSpokenLanguage: String = ""
    var strWrittenLanguage: String = ""
    var strVolunteerWork: String = ""
    var strDesiredValue: String = ""
    var strbrailLanguage: String = ""
    
    
    init(dict : [String:Any]) {
       
        if let auth_token = dict["auth_token"] as? String{
            self.straAuthToken = auth_token
            UserDefaults.standard.setValue(auth_token, forKey: objAppShareData.UserDetail.straAuthToken)
        }
        
        if let device_id = dict["device_id"] as? String{
            self.strDeviceId = device_id
        }
        
        if let device_type = dict["device_type"] as? String{
            self.strDeviceType = device_type
        }
        
        if let desired_values = dict["desired_values"] as? String{
            self.strDesiredValue = desired_values
        }
        
        if let email = dict["email"] as? String{
            self.strEmail = email
        }
        
        if let name = dict["name"] as? String{
            self.strName = name.decodeEmoji
        }
        
        if let password = dict["password"] as? String{
            self.strPassword = password
        }
        
        if let phone_number = dict["mobile"] as? String{
            self.strPhoneNumber = phone_number
        }else if let phone_number = dict["mobile"] as? Int{
            self.strPhoneNumber = "\(phone_number)"
        }
        
        if let profile_picture = dict["user_image"] as? String{
            self.strProfilePicture = profile_picture
        }
        
        if let userID = dict["user_id"] as? String{
            self.strUserId = userID
        }else if let userID = dict["user_id"] as? Int{
            self.strUserId = "\(userID)"
        }
        
        if let age = dict["age"] as? String{
            self.strAge = age
        }else if let age = dict["age"] as? Int{
            self.strAge = "\(age)"
        }
        
        if let lat = dict["lat"] as? String{
            self.strlatitude = lat
        }else if let lat = dict["lat"] as? Int{
            self.strlatitude = "\(lat)"
        }
        
        if let long = dict["lon"] as? String{
            self.strlongitude = long
        }else if let long = dict["lon"] as? Int{
            self.strlongitude = "\(long)"
        }
        
        if let address = dict["address"] as? String{
            self.strAddress = address.decodeEmoji
        }
        
        if let sex = dict["sex"] as? String{
            self.strGender = sex
        }
        
        if let type = dict["type"] as? String{
            self.strUserType = type
        }
        
        if let first_name = dict["first_name"] as? String{
            self.strFirstName = first_name
        }
        
        if let last_name = dict["last_name"] as? String{
            self.strLastName = last_name
        }
        
        if let nation_name = dict["nation_name"] as? String{
            self.strSelectedDesiredCountry = nation_name
        }
        
        if let province_name = dict["province_name"] as? String{
            self.strSelectedDesiredProvience = province_name
        }
        
        if let municipality_name = dict["municipality_name"] as? String{
            self.strSelectedDesiredCity = municipality_name
        }
        
        if let nation_id = dict["municipality_id"] as? String{
            self.strSelectedDesiredCityID = nation_id
        }else if let nation_id = dict["municipality_id"] as? Int{
            self.strSelectedDesiredCityID = "\(nation_id)"
        }
        
        if let province_id = dict["province_id"] as? String{
            self.strSelectedDesiredProvienceID = province_id
        }else if let province_id = dict["province_id"] as? Int{
            self.strSelectedDesiredProvienceID = "\(province_id)"
        }
        
        if let municipality_id = dict["nation_id"] as? String{
            self.strSelectedDesiredCountryID = municipality_id
        }else if let municipality_id = dict["nation_id"] as? Int{
            self.strSelectedDesiredCountryID = "\(municipality_id)"
        }
        
        if let desired_id = dict["desired_id"] as? String{
            self.strSelectedDesiredFieldID = desired_id
        }else if let desired_id = dict["desired_id"] as? Int{
            self.strSelectedDesiredFieldID = "\(desired_id)"
        }
        
        if let desired_field = dict["desired_field"] as? String{
            self.strSelectedDesiredField = desired_field
        }
       
        if let desired_position_id = dict["desired_position_id"] as? String{
            self.strSelectedDesiredFieldPositionID = desired_position_id
        }else if let desired_position_id = dict["desired_position_id"] as? Int{
            self.strSelectedDesiredFieldPositionID = "\(desired_position_id)"
        }
        
        if let desired_position = dict["desired_position"] as? String{
            self.strSelectedDesiredFieldPosition = desired_position
        }
        
        if let job_type = dict["job_type"] as? String{
            self.strSelectedDesiredJobType = job_type
        }
        
        if let desired_work = dict["desired_work"] as? String{
            self.strSelectedDesiredWorkSetting = desired_work
        }
        
        if let work_shedule = dict["work_shedule"] as? String{
            self.strSelectedDesiredWorkSchedule = work_shedule
        }
        
        if let desired_annual_pay = dict["desired_annual_pay"] as? String{
            self.strSelectedDesiredPayAnnual = desired_annual_pay
        }
        
        if let desired_vacation = dict["desired_vacation"] as? String{
            self.strSelectedDesiredVaccation = desired_vacation
        }
        
        if let relocation = dict["relocation"] as? String{
            self.strSelectedDesiredRelocation = relocation
        }
        
        if let job_tittle = dict["job_tittle"] as? String{
            self.strJobTitle1 = job_tittle
        }
        
        if let company_name = dict["company_name"] as? String{
            self.strCompanyName1 = company_name
        }
        
        if let job_location = dict["job_location"] as? String{
            self.strLocation1 = job_location
        }
        
        if let job_duration = dict["job_duration"] as? String{
            self.strWorkDuration1 = job_duration
        }
        
        if let job_working_status = dict["job_working_status"] as? String{
            self.strCurrentlyWorkingHere1 = job_working_status
        }
        
        if let level_education = dict["level_education"] as? String{
            self.strLevelEducation = level_education
        }
        
        if let certificate_tbd = dict["certificate_tbd"] as? String{
            self.strCertificateLicense = certificate_tbd
        }
        
        if let edu_skill = dict["edu_skill"] as? String{
            self.strSkills = edu_skill
        }
        if let desired = dict["desired"] as? String{
            self.strDesired = desired
        }
        
        if let spoken_language = dict["spoken_language"] as? String{
            self.strSpokenLanguage = spoken_language
        }
        
        if let written_language = dict["written_language"] as? String{
            self.strWrittenLanguage = written_language
        }
        
        if let brail_language = dict["brail_language"] as? String{
            self.strbrailLanguage = brail_language
        }
        
        if let volunteer_work = dict["volunteer_work"] as? String{
            self.strVolunteerWork = volunteer_work
        }
        
    }
}

//
//  Enums.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 21/08/22.
//

import Foundation
import UIKit


enum JobType{
    static let strPartTime = "PartTime".localized()
    static let strFullime = "FullTime".localized()
    static let strContractInternship = "ContractInternship".localized()
}

enum WorkSetting{
    static let strWFH = "work@home".localized()
    static let strHybrid = "hybrid".localized()
    static let strInOffice = "inOffice".localized()
}
enum WorkSchedule{
    static let strDayTime = "Day Time".localized()
    static let strNightTime = "Night Time".localized()
    static let strMondaySaturday = "Monday-Saturday".localized()
    static let strMondayFriday = "Monday-Friday".localized()
    static let strOther = "Other".localized()
    
}
enum AppLanguage{
    static let English = "English".localized()
    static let French = "French".localized()
}
enum MenuName{
    static let MyProfile = "My Profile".localized()
    static let Logout = "Logout".localized()
}

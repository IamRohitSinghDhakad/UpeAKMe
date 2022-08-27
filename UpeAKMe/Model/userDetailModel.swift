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
       
    }
}

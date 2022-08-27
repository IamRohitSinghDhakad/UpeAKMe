//
//  AppSharedData.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 21/08/22.
//

import UIKit

let objAppShareData : AppSharedData  = AppSharedData.sharedObject()
class AppSharedData: NSObject {
    
    //MARK: - Shared object
    private static var sharedManager: AppSharedData = {
        let manager = AppSharedData()
        return manager
    }()
    
    // MARK: - Accessors
    class func sharedObject() -> AppSharedData {
        return sharedManager
    }
    
    //MARK: - Variables
    var UserDetail = userDetailModel(dict: [:])
    var signInData = SignInDetail(dict: [:])
    
    //MARK: - Check Login Status
    open var isLoggedIn: Bool {
        get {
            if (UserDefaults.standard.value(forKey:  UserDefaults.Keys.userInfo) as? [String : Any]) != nil {
                self.fetchUserInfoFromAppshareData()
                return true
            }
            return false
        }
    }
    
    // MARK: - saveUpdateUserInfoFromAppshareData ---------------------
    func SaveUpdateUserInfoFromAppshareData(userDetail:[String:Any])
    {
        let outputDict = self.removeNSNull(from:userDetail)
        UserDefaults.standard.set(outputDict, forKey: UserDefaults.Keys.userInfo)
        
    }
    
    // MARK: - FetchUserInfoFromAppshareData -------------------------
    func fetchUserInfoFromAppshareData()
    {
        if let userDic = UserDefaults.standard.value(forKey:  UserDefaults.Keys.userInfo) as? [String : Any]{
            UserDetail = userDetailModel.init(dict: userDic)
        }
    }
    
    func removeNSNull(from dict: [String: Any]) -> [String: Any] {
        var mutableDict = dict
        let keysWithEmptString = dict.filter { $0.1 is NSNull }.map { $0.0 }
        for key in keysWithEmptString {
            mutableDict[key] = ""
            print(key)
        }
        return mutableDict
    }
}

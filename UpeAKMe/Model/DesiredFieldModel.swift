//
//  DesiredFieldModel.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 11/09/22.
//

import UIKit

struct DesiredFieldModel {
    
    var strDesiredID:Int?
    var strDesiredName:String?
    var strDesiredPositionID:Int?
    var strDesiredPositionName:String?
    var strStatus:String?
    
    init(dict : [String:Any]) {
        
        if let desiredID = dict["desired_id"] as? String{
            self.strDesiredID = Int(desiredID)
        }else if let desiredID = dict["desired_id"] as? Int{
            self.strDesiredID = desiredID
        }
        
        if let desiredName = dict["desired_name"]{
            self.strDesiredName = "\(desiredName)"
        }
        
        if let desiredID = dict["desired_position_id"] as? String{
            self.strDesiredPositionID = Int(desiredID)
        }else if let desiredID = dict["desired_position_id"] as? Int{
            self.strDesiredPositionID = desiredID
        }
        
        if let desiredName = dict["desired_position_name"]{
            self.strDesiredPositionName = "\(desiredName)"
        }
        
        if let status = dict["status"]{
            self.strStatus = "\(status)"
        }
    }

}

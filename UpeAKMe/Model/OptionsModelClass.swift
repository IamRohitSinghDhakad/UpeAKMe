//
//  OptionsModelClass.swift
//  ServiLine
//
//  Created by Rohit Singh Dhakad on 23/03/22.
//

import UIKit

class NationModel: NSObject {
    
    var strName:String = ""
    var strNameFr:String = ""
    var strID:Int = 0
    var isSelected:Bool?
    
    init(dict : [String:Any]) {
        
        if let name = dict["name"] as? String{
            self.strName = name
        }
        
        if let name = dict["name_fr"] as? String{
            self.strNameFr = name
        }
        
        
        
        if let id = dict["id"] as? String{
            self.strID = Int(id) ?? 0
        }else  if let id = dict["id"] as? Int{
            self.strID = id
        }
    }
}

class ProvienceModel: NSObject {
    
    var strNationID:String = ""
    var strNationName:String = ""
    var strName:String = ""
    var strNameFr:String = ""
    var strID:Int = 0
    var isSelected:Bool?
    
    init(dict : [String:Any]) {
        
        if let name = dict["name"] as? String{
            self.strName = name
        }
        
        if let name = dict["name_fr"] as? String{
            self.strNameFr = name
        }
        
        
        if let id = dict["id"] as? String{
            self.strID = Int(id) ?? 0
        }else  if let id = dict["id"] as? Int{
            self.strID = id
        }
    }

}

class MuncipalModel: NSObject {
    
   
    var strName:String = ""
    var strNameFr:String = ""
    var strID:Int = 0
    var isSelected = false
    
    init(dict : [String:Any]) {
        
        if let name = dict["name"] as? String{
            self.strName = name
        }
        
        if let name = dict["name_fr"] as? String{
            self.strNameFr = name
        }
        
        
        if let id = dict["id"] as? String{
            self.strID = Int(id) ?? 0
        }else  if let id = dict["id"] as? Int{
            self.strID = id
        }
    }

}

class SkillModel: NSObject {
    
   
    var strName:String = ""
    var isSelected:Bool?
    
    init(name : String, isSelected : Bool) {
        
        self.strName = name
        self.isSelected = isSelected
        
    }

}



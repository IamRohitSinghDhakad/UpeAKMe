//
//  ValidationManager.swift
//  Somi
//
//  Created by Rohit Singh Dhakad on 25/03/21.
//

import Foundation

let objValidationManager = Validation_Manager.sharedObject()

class Validation_Manager {
    
 private static var sharedValidationManager: Validation_Manager = {
  let validation = Validation_Manager()
  return validation
  }()
    
// MARK: - Accessors
    class func sharedObject() -> Validation_Manager {
    return sharedValidationManager
    }
    
//MARK: - Validation Methods
    // Validate email id URL's
    func validateEmail(with Email: String) -> Bool {
    let emailRegex = "^([a-zA-Z0-9_\\-\\.+-]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4})(\\]?)$"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: Email)
    }
    
    func isPwdLenth(password: String) -> Bool {
           if password.count < 6 {
               return true
           }else{
               return false
           }
       }
    func isNamedLenth(password: String) -> Bool {
        if password.count < 3 {
            return true
        }else{
            return false
        }
    }
    
    
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
   
    
// Valid phone number ----
    func isvalidatePhone(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\D?(\\d{3})\\D?\\D?([0-9]{3})\\D?(\\d{4})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isvalidPhoneNo(value: String) -> Bool {
           
           if value.count >= 6 {
               return true
           }else{
               return false
           }
           
       }
    
// Only integer id validation --
    func isValidId(Id: String) -> Bool {
           let phoneRegex = "^[0-9+]{0,1}+[0-9]{2,12}$"
           let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
           return phoneTest.evaluate(with: Id)
       }

// Validate Name Strings
    func validateNameStrings(_ nameString: String) -> Bool {
        let nameRegEx = "^([A-Za-z](\\.)?+(\\s)?[A-Za-z|\\'|\\.]*){1,7}$"
        let nameTest = NSPredicate (format:"SELF MATCHES %@",nameRegEx)
        let result = nameTest.evaluate(with: nameString)
        return result
    }
    

//Validation for url

    func validateUrl(_ candidate: String) -> Bool {
    // Converted with Swiftify v1.0.6488 - https://objectivec2swift.com/
    if candidate.hasPrefix("http://") {
    return true
    }
    else if candidate.hasPrefix("https://") {
    return true
    }
    else if candidate.hasPrefix("www") {
    return true
    }
    else {
    return false
    }
    }

    //MARK - time format
    func timeFormat(_ time: String) -> String {
    let dateFormatter3 = DateFormatter()
    dateFormatter3.dateStyle = .medium
    dateFormatter3.dateFormat = "HH:mm:ss"
    let date1: Date? = dateFormatter3.date(from: time)
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    let formattedTime: String = formatter.string(from: date1!)
    return formattedTime

    }

    func timeFormat(forAPI date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    let formattedTime: String = formatter.string(from: date)
    return formattedTime
    }

    //MARH - date format
    func dateFormat(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date1: Date? = dateFormatter.date(from: date)
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "MM/dd/yyyy"
    let formatedDate: String = dateFormatter2.string(from: date1!)
    return formatedDate
    }

    func dateFormat(forAPI date: Date) -> String {
    let dateFormator = DateFormatter()
    dateFormator.dateFormat = "yyyy-MM-dd"
    let formatedDate: String = dateFormator.string(from: date)
    return formatedDate
    }

    func date(withTime date: Date) -> String {
    let dateFormatter3 = DateFormatter()
    dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date1: Date? = dateFormatter3.date(from: "\(date)")
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd hh:mm a"
    let formattedTime: String = formatter.string(from: date1!)
    return formattedTime
   }
    
     func isValidDate(dateString: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MMM/yyyy"
        if let _ = dateFormatterGet.date(from: dateString) {
            //date parsing succeeded, if you need to do additional logic, replace _ with some variable name i.e date
            return true
        } else {
            // Invalid date
            return false
        }
    }
    
}

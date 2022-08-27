//
//  MessageConstant.swift
//  Somi
//
//  Created by Rohit Singh Dhakad on 25/03/21.
//

import UIKit

class MessageConstant: NSObject {
    //pragma mark - Field validation
    static let ValidEmail: String = "Email Address is not valid, Please provide a valid Email"
    static let ValidPhone: String = "Phone number is not valid, Please provide a valid phone number"
    static let ValidEmailPhone: String = "Email Address / Phone number is not valid, Please provide a valid Email or phone number"
    static let BlankEmail: String = "Please enter your Email"
    static let BlankFirstName: String = "Please enter your First Name"
    static let BlankLastName: String = "Please enter your Last Name"
    static let BlankUserName: String = "Please enter your Email"
    static let BlankEmailAndPhoneNumber: String = "Please enter your email or phone number"
    static let BlankEmailPass: String = "Please enter your email and password "
    static let BlankPhoneNo: String = "Please enter your Phone number "
    static let BlankLanguage: String = "Please Select Language "
    static let BlankUsername: String = "Please enter full name"
    static let BlankVoiceVideo: String = "Please enter video or voice message "
    static let BlankGender: String = "Please Select Gender"
    static let BlankDOB: String = "Please enter DOB"
    static let InvalidName: String = "Only alphabeticals allowed in Username"
    static let UploadImage: String = "Please upload image"
    static let InvalidDOB: String = "DOB is not valid, Please provide a valid DOB in formate dd/MMM/yyyy"
    static let BlankAge: String = "Please Select Age "
    static let UsernameLength: String = "Username must be atleast 4 characters long"
    static let BlankPassword: String = "Please enter your Password"
    static let PasswordNotMatched: String = "Retype password not matched"
    static let LengthPassword: String = "Password is too short (minimum 6 characters)"
    static let LengthName: String = "Username is too short (minimum 3 characters)"
    static let BlankConfirmPassword: String = "Please enter confirm password"
    static let NoNetwork: String = "No network connection"
    static let SameConfirmPassword: String = "password and confirm password does not match"
    static let VerifyCode: String = "Please enter the 4 digit code below to verify your mobile number and create your account"
    static let ErrorEmail: String = "Email does not exist in our database, please try alternative."
    static let SentEmail: String = "Email sent. Check your inbox"
    static let SMSSent: String = "SMS sent. Check your phone"

    static let Name_Title : String = "Please enter the Name/Title"
    static let NameValidation : String = "Name and title should be between 3 to 50 characters"
    static let Development: String = "Under Development"
    static let CountrySelection: String = "Please select the country"
    static let provienceSelection: String = "Please select the provience"
    static let citySelection: String = "Please select the city"

    //pragma mark -Alert validation
    static let k_AlertOK: String = "OK"
    static let k_AlertMessage: String = "Message"
    static let k_AlertTitle: String = "Alert"
    static let k_ErrorMessage: String = "Something went wrong"
    static let k_success = "success"
    static let k_StatusCode = 1
    static let k_NoConnection: String = "No network connection"
    static let k_CheckInternetConnection: String = "Please check your internet connection."
    
    //Default
    static let Yes: String = "Yes".localized()
    static let No: String = "No".localized()
}


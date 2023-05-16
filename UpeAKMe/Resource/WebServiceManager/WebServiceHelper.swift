//
//  WebServiceHelper.swift
//  Somi
//
//  Created by Paras on 24/03/21.
//

import Foundation
import UIKit


//let BASE_URL = "https://ambitious.in.net/Arun/upeAKMe/index.php/api/"//Local
let BASE_URL = "https://upeakme.com/admin/index.php/api/"//Live


struct WsUrl{
    static let url_Login  = BASE_URL + "login"
    static let url_SignUp  = BASE_URL + "signup"
    static let url_SocialLogin  = BASE_URL + "social_login"
    static let url_getDesired = BASE_URL + "get_desired"
    static let url_getDesiredPosition = BASE_URL + "get_desired_position"
    static let url_GetNation = BASE_URL + "get_nation"
    static let url_GetCommunity = BASE_URL + "get_community"
    static let url_getProvince = BASE_URL + "get_province"
    static let url_getMunicipality = BASE_URL + "get_municipality"
    static let url_completeProfile = BASE_URL + "update_profile"
    static let url_forgotPassword = BASE_URL + "forgot_password"
    static let url_GetUserList = BASE_URL + "get_users"
    static let url_GetProfile = BASE_URL + "get_profile"
    static let url_CheckEmail = BASE_URL + "check_profile"
    static let url_getConversation = BASE_URL + "get_conversation"
    static let url_clearConversastion = BASE_URL + "clear_conversation"
    static let url_GetChat = BASE_URL + "get_chat"
    static let url_InsertChat = BASE_URL + "insert_chat"
    static let url_Logout = BASE_URL + "logout"
}
//Api check for params

struct WsParamsType {

    static let PathVariable = "Path Variable"

    static let QueryParams = "Query Params"

}

//Api Header

struct WsHeader {

    //Login

    static let deviceId = "Device-Id"

    static let deviceType = "Device-Type"

    static let deviceTimeZone = "Device-Timezone"

    static let ContentType = "Content-Type"

}

/*

//Api parameters

struct WsParam {

    

    //static let itunesSharedSecret : String = "c736cf14764344a5913c8c1"

    //Signup

    static let dialCode = "dialCode"

    static let contactNumber = "contactNumber"

    static let code = "code"

    static let deviceToken = "deviceToken"

    static let deviceType = "deviceType"

    static let firstName = "firstName"

    static let lastName = "lastName"

    static let email = "email"

    static let driverImage = "driverImage"

    static let isSignup = "isSignup"

    static let licenceImage = "licenceImage"

    static let socialId = "socialId"

    static let socialType = "socialType"

    static let imageUrl = "image_url"

    static let invitationId = "invitationId"

    static let status = "status"

    static let companyId = "companyId"

    static let vehicleId = "vehicleId"

    static let type = "type"

    static let bookingId = "bookingId"

    static let location = "location"

    static let latitude = "latitude"

    static let longitude = "longitude"

    static let currentdate_time = "current_date_time"

}

*/

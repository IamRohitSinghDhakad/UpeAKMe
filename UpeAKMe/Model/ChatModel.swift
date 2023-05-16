//
//  ChatModel.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 14/03/23.
//

import UIKit

class ChatModel: NSObject {

    var strChatId:String?
    var strLastImage:String?
    var strLastMessage:String?
    var strReceiverId:String?
    var strSenderId:String?
    var strSenderImage:String?
    var strSenderName:String?
    var strTimeAgo:String?
    
    init(dict : [String:Any]) {
        
        if let chat_id = dict["chat_id"] as? Int{
            self.strChatId = String(chat_id)
        }else if let chat_id = dict["chat_id"] as? String{
            self.strChatId = chat_id
        }
        
        if let sender_id = dict["sender_id"] as? Int{
            self.strSenderId = String(sender_id)
        }else if let sender_id = dict["sender_id"] as? String{
            self.strSenderId = sender_id
        }
        
        if let receiver_id = dict["receiver_id"] as? Int{
            self.strReceiverId = String(receiver_id)
        }else if let receiver_id = dict["receiver_id"] as? String{
            self.strReceiverId = receiver_id
        }
        
        if let last_message = dict["last_message"] as? String{
            self.strLastMessage = last_message
        }
        
        if let last_image = dict["last_image"] as? String{
            self.strLastImage = last_image
        }
        
        if let time_ago = dict["time_ago"] as? String{
            self.strTimeAgo = time_ago
        }
        
        if let sender_name = dict["sender_name"] as? String{
            self.strSenderName = sender_name
        }
        
        if let sender_image = dict["sender_image"] as? String{
            self.strSenderImage = sender_image
        }
        
       
        
        
    }
}
/*
 "chat_id" = 44;
 "last_image" = "";
 "last_message" = good;
 "no_of_message" = 0;
 "receiver_id" = 1;
 "sender_id" = 8;
 "sender_image" = "https://upeakme.com/admin/uploads/user/1386favicon.png";
 "sender_name" = "Ambitious Technology ";
 "time_ago" = "2 weeks ago";
 */

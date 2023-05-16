//
//  HomeViewController.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 21/08/22.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet var tblChat: UITableView!
    
    var arrChalList = [ChatModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblChat.delegate = self
        self.tblChat.dataSource = self
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.call_wsGetChatList()
    }

    @IBAction func btnOpenSideMenu(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    @IBAction func btnOnLogout(_ sender: Any) {
        objAppShareData.signOut()
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell")as? HomeTableViewCell
        
        let obj = self.arrChalList[indexPath.row]
        
        let profilePic = obj.strSenderImage
        if profilePic != "" {
            let url = URL(string: profilePic!)
            cell?.imgVw.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "white"))
        }else{
            cell?.imgVw.image = UIImage.init(named: "white")
        }
        
        cell?.lblName.text = obj.strSenderName
        cell?.lblTimeAgo.text = obj.strTimeAgo
        cell?.lblMsg.text = obj.strLastMessage
        
        cell?.btnDelete.tag = indexPath.row

        cell?.btnDelete.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)

        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatDeatilViewController")as! ChatDeatilViewController
        vc.strSenderID = self.arrChalList[indexPath.row].strSenderId ?? ""
        vc.strUserName = self.arrChalList[indexPath.row].strSenderName ?? ""
        vc.strUserImage = self.arrChalList[indexPath.row].strSenderImage ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        objAlert.showAlertCallBack(alertLeftBtn: "Yes", alertRightBtn: "No", title: "Alert!", message: "Are you sure you want to delete this chat", controller: self) {
            self.call_DeleteUserConversation(senderId: self.arrChalList[buttonTag].strSenderId ?? "0")
        }
       
    }
    
    
}


extension HomeViewController{
    
    
    func call_wsGetChatList(){
        
        self.view.endEditing(true)
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
      //  objWebServiceManager.showIndicator()
        
        var dictParam = [String:Any]()
        
        dictParam = ["user_id":objAppShareData.UserDetail.strUserId,
                     "language":objAppShareData.UserDetail.strSelectedLanguage]as [String:Any]
        
        print(dictParam)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_getConversation, queryParams: [:], params: dictParam, strCustomValidation: "", showIndicator: false) { response in
            
         //   objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            debugPrint(response)
            
            if status == MessageConstant.k_StatusCode{
                self.arrChalList.removeAll()
                guard let dictUserData = response["result"]as? [[String:Any]] else{return}
                
                for data in dictUserData{
                    let obj = ChatModel.init(dict: data)
                    self.arrChalList.append(obj)
                }
                
                self.tblChat.reloadData()
                debugPrint(dictUserData)
                
            }else{
                if let resultmessage = response["result"]as? String{
                    self.arrChalList.removeAll()
                    self.tblChat.displayBackgroundText(text: resultmessage)
                    self.tblChat.reloadData()
                   //objAlert.showAlert(message: resultmessage, controller: self)
                }
                
                debugPrint(message ?? "Error Occured")
            }
            
        } failure: { Error in
            debugPrint(Error)
        }
    }
    
    func call_DeleteUserConversation(senderId: String) {
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let parameter = ["receiver_id" : senderId,
                         "sender_id": objAppShareData.UserDetail.strUserId] as [String:Any]
        print(parameter)
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_clearConversastion, queryParams: [:], params: parameter, strCustomValidation: "", showIndicator: false) { response in
            
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            _ = (response["message"] as? String)
            
            print(response)
            
            if status == MessageConstant.k_StatusCode{
                
                self.call_wsGetChatList()
                
            }else{
                objWebServiceManager.hideIndicator()
               // objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                
            }
            
            
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
}

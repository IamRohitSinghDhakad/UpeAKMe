//
//  ChatDeatilViewController.swift
//  MunichBusinessClub
//
//  Created by Rohit Singh Dhakad on 12/01/23.
//

import UIKit

class ChatDeatilViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var tblVwChat: UITableView!
    @IBOutlet var txtVwChat: RDTextView!
    @IBOutlet var hgtConsMaximum: NSLayoutConstraint!
    @IBOutlet var hgtConsMinimum: NSLayoutConstraint!
    @IBOutlet var btnSendTextMessage: UIButton!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgVwUser: UIImageView!
    
    let txtViewCommentMaxHeight: CGFloat = 100
    let txtViewCommentMinHeight: CGFloat = 34
    
    
    var arrChatMessages = [ChatDetailModel]()
    var strUserName = ""
    var strUserImage = ""
    var strSenderID = ""
    var timer: Timer?
    var strMsgID = -1
    var isSendMessage = true
    var selectedIndex = -1
    var arrCount = Int()
    var initilizeFirstTimeOnly = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblVwChat.delegate = self
        self.tblVwChat.dataSource = self
        self.txtVwChat.delegate = self
        
        
        self.lblUserName.text = self.strUserName
        if self.timer == nil{
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtVwChat.placeholderText = "Write message here...".localized()
        
        let profilePic = self.strUserImage
        if profilePic != "" {
            let url = URL(string: profilePic)
            self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "white"))
        }else{
            self.imgVwUser.image = UIImage.init(named: "white")
        }
    }
    
    @objc func updateTimer() {
        //example functionality
        self.call_GetChatList(strUserID: objAppShareData.UserDetail.strUserId, strSenderID: self.strSenderID)
    }
    
    @IBAction func btnOnOpenOptions(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
           
           alert.addAction(UIAlertAction(title: "Block this user", style: .default , handler:{ (UIAlertAction)in
               print("User click Approve button")
           }))
           
           alert.addAction(UIAlertAction(title: "Report this user", style: .default , handler:{ (UIAlertAction)in
               print("User click Edit button")
           }))
           
           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
               print("User click Dismiss button")
           }))
           //uncomment for iPad Support
           //alert.popoverPresentationController?.sourceView = self.view
           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
    
    
    @IBAction func btnOnSendTextMsg(_ sender: Any) {
        if (txtVwChat.text?.isEmpty)!{

            self.txtVwChat.text = "."
            self.txtVwChat.text = self.txtVwChat.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            self.txtVwChat.isScrollEnabled = false
            self.txtVwChat.frame.size.height = self.txtViewCommentMinHeight
            self.txtVwChat.text = ""

            if self.txtVwChat.text!.count > 0{
                self.txtVwChat.isScrollEnabled = false
            }else{
                self.txtVwChat.isScrollEnabled = false
            }
        }else{
            self.txtVwChat.frame.size.height = self.txtViewCommentMinHeight
            DispatchQueue.main.async {
                let text  = self.txtVwChat.text!.encodeEmoji
                self.sendMessageNew(strText: text)
            }
            if self.txtVwChat.text!.count > 0{
                self.txtVwChat.isScrollEnabled = false

            }else{
                self.txtVwChat.isScrollEnabled = false
            }
        }
    }
    
    @IBAction func btnOnBack(_ sender: Any) {
        self.timer?.invalidate()
        self.timer = nil
        onBackPressed()
    }
}

extension ChatDeatilViewController{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 150
    }
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
          if self.txtVwChat.text == "\n"{
              self.txtVwChat.resignFirstResponder()
          }
          else{
          }
          return true
      }
      

      func textViewDidChange(_ textView: UITextView)
      {
          if self.txtVwChat.contentSize.height >= self.txtViewCommentMaxHeight
          {
              self.txtVwChat.isScrollEnabled = true
          }
          else
          {
              self.txtVwChat.frame.size.height = self.txtVwChat.contentSize.height
              self.txtVwChat.isScrollEnabled = false
          }
      }
    
    func sendMessageNew(strText:String){
        self.txtVwChat.isScrollEnabled = false
        self.txtVwChat.contentSize.height = self.txtViewCommentMinHeight
        self.txtVwChat.text = self.txtVwChat.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.txtVwChat.text == "" {
            objAlert.showAlert(message: "Introduzca mensaje", title: "", controller: self)
           // AppSharedClass.shared.showAlert(title: "Alert", message: "Please enter some text", view: self)
            return
        }else{
            self.call_SendTextMessageOnly(strUserID: objAppShareData.UserDetail.strUserId, strText: strText)
        }
        self.txtVwChat.text = ""
    }
}

extension ChatDeatilViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatDeatailTableViewCell", for: indexPath)as! ChatDeatailTableViewCell
        
        let obj = self.arrChatMessages[indexPath.row]
        
        if obj.strSenderId == objAppShareData.UserDetail.strUserId{
      
            cell.vwMyMsg.isHidden = false
            cell.lblMyMsg.text = obj.strOpponentChatMessage
            cell.lblMyMsgTime.text = obj.strOpponentChatTime
            cell.vwOpponent.isHidden = true
        }else{

            cell.lblOpponentMsg.text = obj.strOpponentChatMessage
            cell.lblopponentMsgTime.text = obj.strOpponentChatTime
            cell.vwOpponent.isHidden = false
            cell.vwMyMsg.isHidden = true
        }
        
        return cell
    }
    
    
}


extension ChatDeatilViewController{
    
    func call_GetChatList(strUserID:String, strSenderID:String){

        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }

      //  objWebServiceManager.showIndicator()

        let parameter = ["receiver_id":strSenderID,
                         "language":objAppShareData.UserDetail.strSelectedLanguage,
                         "sender_id":strUserID]as [String:Any]
      

        print(parameter)


        objWebServiceManager.requestPost(strURL: WsUrl.url_GetChat, queryParams: [:], params: parameter, strCustomValidation: "", showIndicator: false) { response in
 

            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)

            print(response)

            if status == MessageConstant.k_StatusCode{

                if let arrData  = response["result"] as? [[String:Any]] {
                    var newArrayChatMessages: [ChatDetailModel] = []
                    for dict in arrData {
                        let obj = ChatDetailModel.init(dict: dict)
                        newArrayChatMessages.append(obj)
                    }

                    if self.arrChatMessages.count == 0 {
                        //Add initially all
                        self.arrChatMessages.removeAll()
                        self.tblVwChat.reloadData()

                        for i in 0..<arrData.count{
                            let dictdata = arrData[i]
                            let obj = ChatDetailModel.init(dict: dictdata)
                            self.arrChatMessages.insert(obj, at: i)
    
                            self.tblVwChat.insertRows(at: [IndexPath(item: i, section: 0)], with: .none)
                        }
                        DispatchQueue.main.async {
                            self.tblVwChat.scrollToBottom()
                        }

                    }
                    else {
                        let previoudIds = self.arrChatMessages.map { $0.strMsgIDForDelete }
                        let newIds = newArrayChatMessages.map { $0.strMsgIDForDelete }

                        let previoudIdsSet = Set(previoudIds)
                        let newIdsSet = Set(newIds)

                        let unique = (previoudIdsSet.symmetricDifference(newIdsSet)).sorted()

                        for uniqueId in unique {
                            if previoudIds.contains(uniqueId) {
                                //Remove the element
                                if let idToDelete = self.arrChatMessages.firstIndex(where: { $0.strMsgIDForDelete == uniqueId }) {
                                    self.arrChatMessages.remove(at: idToDelete)
                                    self.tblVwChat.deleteRows(at: [IndexPath(item: idToDelete, section: 0)], with: .none)

                                }
                            }
                            else if newIds.contains(uniqueId) {
                                // Add new element
                                let filterObj = newArrayChatMessages.filter({ $0.strMsgIDForDelete == uniqueId })
                                if filterObj.count > 0 {
                                    let index = self.arrChatMessages.count
                                    self.arrChatMessages.insert(filterObj[0], at: index)
                                    self.tblVwChat.insertRows(at: [IndexPath(item: index, section: 0)], with: .none)
                                    self.tblVwChat.scrollToBottom()
                                }
                            }
                        }
                    }

                    if self.initilizeFirstTimeOnly == false{
                        self.initilizeFirstTimeOnly = true
                        self.arrCount = self.arrChatMessages.count
                    }


                    if self.arrCount == self.arrChatMessages.count{

                    }else{
                        self.updateTableContentInset()
                    }


                    if self.arrChatMessages.count == 0{
                        self.tblVwChat.displayBackgroundText(text: "No message found")
                    }else{
                        self.tblVwChat.displayBackgroundText(text: "")
                    }

                }
            }else{
                objWebServiceManager.hideIndicator()

                if (response["result"]as? String) != nil{
                    self.tblVwChat.displayBackgroundText(text: "no record found")
                }else{
                    objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                }
            }
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    func updateTableContentInset() {
        let numRows = self.tblVwChat.numberOfRows(inSection: 0)
        var contentInsetTop = self.tblVwChat.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.tblVwChat.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
        self.tblVwChat.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
    }
    
    
    //    //MARK:- Send Text message Only
        func call_SendTextMessageOnly(strUserID:String, strText:String){

            if !objWebServiceManager.isNetworkAvailable(){
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
                return
            }

           // objWebServiceManager.showIndicator()

            let dicrParam = ["receiver_id":self.strSenderID,//Opponent ID
                             "sender_id":strUserID,//My ID
                             "type":"Text",
                             "language":objAppShareData.UserDetail.strSelectedLanguage,
                             "chat_message":strText]as [String:Any]
            print(dicrParam)

            objWebServiceManager.requestPost(strURL: WsUrl.url_InsertChat, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false) { (response) in
                objWebServiceManager.hideIndicator()
                let status = (response["status"] as? Int)
                let message = (response["message"] as? String)

                print(response)
                
                if let result = response["result"]as? [String:Any]{
                    if message == "success"{
                        self.isSendMessage = true
                        self.initilizeFirstTimeOnly = false
                        // self.call_GetChatList(strUserID: objAppShareData.UserDetail.strUserId, strSenderID: self.strSenderID)
                    }
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



//MARK:- Scroll to bottom
extension UITableView {

    func scrollToBottom(){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: false)
           }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

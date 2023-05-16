//
//  AppSideMenuViewController.swift
//  Paing
//
//  Created by Akshada on 21/05/21.
//

import UIKit
import SDWebImage



class SideMenuOptions: Codable {
    var menuName: String = ""
    var menuImageName: String = ""
    var menuSelectedImageName: String = ""
    init(menuName: String, menuImageName: String, menuSelectedImageName: String) {
        self.menuName = menuName
        self.menuImageName = menuImageName
        self.menuSelectedImageName = menuSelectedImageName
    }
}

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class AppSideMenuViewController: UIViewController {
    
    @IBOutlet var imgVwUser: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    
    var selectedIndexpath = 0
    var strBadgeCount : Int?
    var imagePicker = UIImagePickerController()
    var pickedImage:UIImage?
    
    private let menus: [SideMenuOptions] = [
        SideMenuOptions(
            menuName: MenuName.MyProfile, menuImageName: "", menuSelectedImageName: "")]
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        imagePicker.delegate = self
        // Along with auto layout, these are the keys for enabling variable cell height
        tableView.estimatedRowHeight = 60.0
        controllerMenuSetup()
        sideMenuController?.delegate = self
        
     //   call_GetProfile(strUserID: objAppShareData.UserDetail.strUserId)
        
        let profilePic = objAppShareData.UserDetail.strProfilePicture
        if profilePic != "" {
            let url = URL(string: profilePic)
            self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "white"))
        }

        self.lblName.text = objAppShareData.UserDetail.strFirstName + objAppShareData.UserDetail.strLastName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
//
//        self.tableView.updateRow(row: 4)

    }
    
    private func controllerMenuSetup() {
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController")
        }, with: "0")
        
    }
    
    @IBAction func btnAddImage(_ sender: Any) {
        setImage()
    }
    
    
    private func configureView() {
        SideMenuController.preferences.basic.menuWidth = view.frame.width * 0.7
        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        if showPlaceTableOnLeft {
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let sideMenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sideMenuBasicConfiguration.position == .under) != (sideMenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
    
}

extension AppSideMenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did hide.")
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
}

extension AppSideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppSideMenuTableViewCell", for: indexPath) as! AppSideMenuTableViewCell
        
        if indexPath.row == 4{
            if self.strBadgeCount != 0 {
                if self.strBadgeCount == nil{
                    cell.lblBadgeCount.isHidden = true
                }else{
                cell.lblBadgeCount.isHidden = false
                    cell.lblBadgeCount.text = "\(self.strBadgeCount ?? 1)"
                }
                   
                }else{
                    cell.lblBadgeCount.isHidden = true
                }
        }else{
            cell.lblBadgeCount.isHidden = true
        }
        
        cell.menuImage.image = UIImage(named: menus[indexPath.row].menuImageName)
        cell.menuName.text = menus[indexPath.row].menuName
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        self.selectedIndexpath = row
        
        if row == 1{
            exit(EXIT_SUCCESS)
        }
        
            sideMenuController?.setContentViewController(with: "\(row)", animated: Preferences.shared.enableTransitionAnimation)
            sideMenuController?.hideMenu()
            
            if let identifier = sideMenuController?.currentCacheIdentifier() {
                print("[Example] View Controller Cache Identifier: \(identifier)")
            }
        self.tableView.reloadData()
    }
}

extension AppSideMenuViewController{
    
    //MARK:- Call WebService
    
    func call_WSLogout(strUserID:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
    
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["user_id":strUserID,
                        ]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_Logout, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                
               // AppSharedData.sharedObject().signOut()
                
            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
           
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
   }
    
}

extension UITableView
{
    func updateRow(row: Int, section: Int = 0)
    {
        let indexPath = IndexPath(row: row, section: section)
        
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: .automatic)
        self.endUpdates()
    }
    
}



extension AppSideMenuViewController{
    
    func call_GetProfile(strUserID:String){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let parameter = ["user_id":strUserID,
                         "language":objAppShareData.UserDetail.strSelectedLanguage]as [String:Any]
        
        
        objWebServiceManager.requestPost(strURL: WsUrl.url_GetProfile, queryParams: [:], params: parameter, strCustomValidation: "", showIndicator: true) { response in
           
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            debugPrint(response)
            
            if status == MessageConstant.k_StatusCode{
                
                if let user_details  = response["result"] as? [String:Any] {
                    
                
                    
                    let profilePic = user_details["user_image"] as? String ?? ""
                    if profilePic != "" {
                        let url = URL(string: profilePic)
                        self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "white"))
                    }else{
                        self.imgVwUser.image = UIImage.init(named: "LOGo")
                    }
                       
                   

                }
                
            }else{
                objWebServiceManager.hideIndicator()
                if let result  = response["result"] as? String {
                    if result == "User not found"{
                        objAppShareData.signOut()
                    }
                }else{
                    objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
                }
                
            }
            
            
        } failure: { (Error) in
            print(Error)
            objWebServiceManager.hideIndicator()
        }
    }
    
    
    func callWebserviceForCompleteProfile(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        self.view.endEditing(true)
        
        var imageData = [Data]()
        var imgData : Data?
        if self.pickedImage != nil{
            imgData = (self.pickedImage?.jpegData(compressionQuality: 1.0))!
        }
        else {
            imgData = (self.imgVwUser.image?.jpegData(compressionQuality: 1.0))!
        }
        imageData.append(imgData!)
        
        let imageParam = ["user_image"]
        
        let dicrParam = ["user_id":objAppShareData.UserDetail.strUserId,
                         "language":objAppShareData.UserDetail.strSelectedLanguage]as [String:Any]
                
        objWebServiceManager.uploadMultipartWithImagesData(strURL: WsUrl.url_completeProfile, params: dicrParam, showIndicator: true, customValidation: "", imageData: imgData, imageToUpload: imageData, imagesParam: imageParam, fileName: "user_image", mimeType: "image/jpeg") { (response) in
           
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            
            debugPrint(response)
            
            if status == MessageConstant.k_StatusCode{
            
                if let user_details  = response["result"] as? [String:Any]{
                    
                    objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                    objAppShareData.fetchUserInfoFromAppshareData()
                    
                    let profilePic = objAppShareData.UserDetail.strProfilePicture
                    if profilePic != "" {
                        let url = URL(string: profilePic)
                        self.imgVwUser.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "white"))
                    }

                    objWebServiceManager.hideIndicator()
                    self.lblName.text = objAppShareData.UserDetail.strFirstName + objAppShareData.UserDetail.strLastName
                    
                }


            }else{
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: message ?? "", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            print(Error)
        }
    }
    
}

//MARK: Camera Access
extension AppSideMenuViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func setImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        let alert:UIAlertController=UIAlertController(title: "Choose Image".localized(), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera".localized(), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery".localized(), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    // Open camera
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.modalPresentationStyle = .fullScreen
            self .present(imagePicker, animated: true, completion: nil)
        } else {
            self.openGallery()
        }
    }
    
    // Open gallery
    func openGallery()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.pickedImage = editedImage
            self.imgVwUser.image = self.pickedImage
            callWebserviceForCompleteProfile()
            imagePicker.dismiss(animated: true, completion: nil)
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.pickedImage = originalImage
            self.imgVwUser.image = pickedImage
            callWebserviceForCompleteProfile()
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    func cornerImage(image: UIImageView, color: UIColor ,width: CGFloat){
        image.layer.cornerRadius = image.layer.frame.size.height / 2
        image.layer.masksToBounds = false
        image.layer.borderColor = color.cgColor
        image.layer.borderWidth = width
        
    }
    
    
}




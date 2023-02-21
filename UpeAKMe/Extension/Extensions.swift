//
//  Extensions.swift
//  UpeAKMe
//
//  Created by Rohit Singh Dhakad on 20/08/22.
//

import Foundation
import UIKit
import AVKit

extension UserDefaults {
    enum Keys {
        static let userInfo = "userInfo"
        static let deviceID = "device_id"
        static let strAccessToken = "access_token"
        static let AuthToken = "AuthToken"
        static let userID = "userID"
        static let userType = "userType"
    }
}

extension UIViewController{
    
    
    func SetBackGroundImageAtViewAndImageName(ImageName: NSString, view: UIView)
    {
        
       UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: ImageName as String)?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    
     //>>>>>>>>>>>>>>>>>>>>>>>>>>> Hide Keyboard <<<<<<<<<<<<<<<<<<<<<<<<<<
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
     //>>>>>>>>>>>>>>>>>>>>>>>>>>> Dismiss ViewController <<<<<<<<<<<<<<<<<<<<<<<<<<
    func onBackPressed() {
        
        if let navigation = self.navigationController
            
        {
            navigation.popViewController(animated: true)
        }
            
        else
            
        {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
     //>>>>>>>>>>>>>>>>>>>>>>>>>>> Present ViewController <<<<<<<<<<<<<<<<<<<<<<<<<<
    
    func presentVC(viewConterlerId : String)     {
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: viewConterlerId)
           self.present(vc!, animated: true, completion: nil)
           
       }
    
     //>>>>>>>>>>>>>>>>>>>>>>>>>>> Push ViewController <<<<<<<<<<<<<<<<<<<<<<<<<<
    
    func pushVc(viewConterlerId:String){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: viewConterlerId)
        navigationController?.pushViewController(vc!,
                                                 animated: true)
        
    }


//MARK: - >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Check string Null <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    func isStringNullValue(strValues: String) -> Bool {
        var isNull:Bool = true
        
        if strValues == nil || strValues == "(null)" || strValues == "<null>"  || strValues == "" {
            isNull = true
        }
        else
        {
            isNull = false
        }
        // strValues.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines
        return isNull
    }
    
    func isValid(_ object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }

        return false
    }
    
    
//MARK: - >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Return StoryBoard Name <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    var authStoryboard: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }
    
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbNailImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    
    func show() {
        let window = UIApplication.shared.delegate?.window
        let visibleVC = window??.visibleViewController
        visibleVC?.present(self, animated: true, completion: nil)
    }
}

extension UITextField {
func setIconLeftSide(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 10, y: 5, width: 20, height: 20))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 20, y: 0, width: 30, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
  }
}


extension UIView{
    
    func roundedCorners(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func viewShadowHeader() {
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    }
    
    func viewShadowHeaderWithCorner(corner:CGFloat) {
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1.0
        self.layer.cornerRadius = corner
        self.layer.shadowColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    }
}


extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var decodeEmoji: String{
        let data = self.data(using: String.Encoding.utf8);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr{
            return str as String
        }
        return self
    }
    
    var encodeEmoji: String{
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue){
            return encodeStr as String
        }
        return self
    }
    
    func localized() -> String{
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
    
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }

}

extension UIImageView {
    
    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
    
    func getThumbnailImage(with url: URL?, placeholderImage: UIImage) {
        self.image = placeholderImage
        if let videoURL = url {
            let asset: AVAsset = AVAsset(url: videoURL)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            do {
                let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
                let imageGenerated = UIImage(cgImage: thumbnailImage)
                self.image = imageGenerated
            } catch let error {
                print(error)
                self.image = placeholderImage
            }
        }
    }
    
    func getThumbnailImageFromVideoUrl(videoURL: URL?, placeholderImage: UIImage) {
        self.image = placeholderImage
        if let url = videoURL {
            DispatchQueue.global().async { //1
                let asset = AVAsset(url: url) //2
                let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
                avAssetImageGenerator.appliesPreferredTrackTransform = true //4
                let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
                do {
                    let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                    let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                    DispatchQueue.main.async { //8
                        self.image = thumbNailImage
                    }
                } catch {
                    print(error.localizedDescription) //10
                    DispatchQueue.main.async {
                        self.image = placeholderImage
                    }
                }
            }
        }
    }
}

public extension UIWindow {
    
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

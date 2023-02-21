//
//  PopUpViewController.swift
//  ServiLine
//
//  Created by Rohit Singh Dhakad on 11/03/22.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var vwContainTable: UIView!
    @IBOutlet var tfSearch: UITextField!
    @IBOutlet var tblVw: UITableView!
    @IBOutlet var lblTitle: UILabel!
    
    var arrayOptions = [SkillModel]()
    var arrayOptionsFiltered = [SkillModel]()
    var arrayMuncipalOptions = [MuncipalModel]()
    var arrayMuncipalOptionsFiltered = [MuncipalModel]()
    var arrSpokenLanguageArray = [SkillModel]()
    var arrWrittenLanguageArray = [SkillModel]()
    var arrSpokenLanguageArrayFiltered = [SkillModel]()
    var arrWrittenLanguageArrayFiltered = [SkillModel]()
    var arrDesired = [SkillModel]()
    var arrDesiredFiltered = [SkillModel]()
    
    var arrayOptionsPreSelected = [SkillModel]()
    var arrayMuncipalOptionsPrerSelected = [MuncipalModel]()
    var arrSpokenLanguageArrayPreSelected = [SkillModel]()
    var arrWrittenLanguageArrayPreSelected = [SkillModel]()
  
    
    var strTitle = ""
    var strType = ""
    var strSectorID = ""
    var strSectorTitle = ""
    var strIsComingFrom = ""
    
    
    var closerForSelectionButton: (( _ strDict:[String:Any]) ->())?
    var closerForSelectionTable: (( _ strDict:[String:Any]) ->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch strIsComingFrom {
        case "City":
            self.arrayMuncipalOptionsFiltered = self.arrayMuncipalOptions
            self.tblVw.reloadData()
        case "Skill":
            self.arrayOptions = ["Adaptability","Attention to detail","Collaboration","Communication","Computer skills","Conflict Management","Creativity","Critical thinking", "Delegating", "Empathy", "Integrity", "Leadership", "Negotiating skills", "Persuasion", "Presentation skills", "Problem - solving", "Reliability", "Social media skills", "Stress Management", "Task Management", "Team work", "Time management", "Tolerance", "Verbal skills", "Work ethic", "Writing skills"].map { SkillModel(name: $0, isSelected: false) }
            self.arrayOptionsFiltered = self.arrayOptions
            self.tblVw.reloadData()
        case "SpokenLanguage":
            self.arrSpokenLanguageArray = ["French", "English", "Spanish", "Italian", "Greek", "Chinese", "Japanese", "Arabic", "Other"].map { SkillModel(name: $0, isSelected: false) }
            self.arrSpokenLanguageArrayFiltered = self.arrSpokenLanguageArray
            self.tblVw.reloadData()
        case "WrittenLanguage":
            self.arrWrittenLanguageArray = ["French", "English", "Spanish", "Italian", "Greek", "Chinese", "Japanese", "Arabic", "Other"].map { SkillModel(name: $0, isSelected: false) }
            self.arrWrittenLanguageArrayFiltered = self.arrWrittenLanguageArray
            self.tblVw.reloadData()
        case "Desired":
            self.arrDesired = ["Accountability","Autonomy","Collaboration","Customer Focus","Diversity & Inclusion","Fairness","Family oriented","Flexibility Understanding","Fun","Growth Recognition","Honesty", "Innovation","Integrity","Learning","Loyalty","Passion","Promise to Customers","Quality","Respect","Teamwork","Transparency","Trust"].map { SkillModel(name: $0, isSelected: false) }
            self.arrDesiredFiltered = self.arrDesired
            self.tblVw.reloadData()
        default:
            break
        }
        
       
       
       
        self.lblTitle.text = self.strTitle
        self.tfSearch.addTarget(self, action: #selector(searchContactAsPerText(_ :)), for: .editingChanged)
        self.tblVw.delegate = self
        self.tblVw.dataSource = self

    }
    
    @IBAction func btnOnDoneTable(_ sender: Any) {
        var arrNames = [String]()
        var arrID = [Int]()
        var dict = [String:Any]()
        
            switch strIsComingFrom {
            case "City":
                let filtered = self.arrayMuncipalOptionsFiltered.filter{ $0.isSelected == true }
                if filtered.count != 0{
                    for i in 0...filtered.count-1{
                        arrNames.append(filtered[i].strName)
                        arrID.append(filtered[i].strID)
                    }
                    let name = arrNames.joined(separator: ",")
                    let arrid = arrID.map { String($0) }
                    let id = arrid.joined(separator: ",")
                    dict["City"] = name
                    dict["CityID"] = id
                    self.closerForSelectionTable?(dict)
                }
      
            case "Skill":
                let filtered = self.arrayOptionsFiltered.filter{ $0.isSelected == true }
                if filtered.count != 0{
                    for i in 0...filtered.count-1{
                        arrNames.append(filtered[i].strName)
                    }
                    let name = arrNames.joined(separator: ",")
                    print(name)
                    dict["Skill"] = name
                    self.closerForSelectionTable?(dict)
                }
            case "SpokenLanguage":
                let filtered = self.arrSpokenLanguageArrayFiltered.filter{ $0.isSelected == true }
                if filtered.count != 0{
                    for i in 0...filtered.count-1{
                        arrNames.append(filtered[i].strName)
                    }
                    let name = arrNames.joined(separator: ",")
                    print(name)
                    dict["SpokenLanguage"] = name
                    self.closerForSelectionTable?(dict)
                }
            case "WrittenLanguage":
                let filtered = self.arrWrittenLanguageArrayFiltered.filter{ $0.isSelected == true }
                if filtered.count != 0{
                    for i in 0...filtered.count-1{
                        arrNames.append(filtered[i].strName)
                    }
                    let name = arrNames.joined(separator: ",")
                    print(name)
                    dict["WrittenLanguage"] = name
                    self.closerForSelectionTable?(dict)
                }
            case "Desired":
                let filtered = self.arrDesiredFiltered.filter{ $0.isSelected == true }
                if filtered.count != 0{
                    for i in 0...filtered.count-1{
                        arrNames.append(filtered[i].strName)
                    }
                    let name = arrNames.joined(separator: ",")
                    print(name)
                    dict["Desired"] = name
                    self.closerForSelectionTable?(dict)
                }
            default:
                break
            }
        onBackPressed()
    }
    
}


//MARK:- Searching
extension PopUpViewController{
    
    @objc func searchContactAsPerText(_ textfield:UITextField) {
        switch strIsComingFrom {
        case "City":
            self.arrayMuncipalOptionsFiltered.removeAll()
            if textfield.text?.count != 0 {
                for dicData in self.arrayMuncipalOptions {
                    let isMachingWorker : NSString = (dicData.strName) as NSString
                    let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                    if range != nil {
                        arrayMuncipalOptionsFiltered.append(dicData)
                    }
                }
            } else {
                self.arrayMuncipalOptionsFiltered = self.arrayMuncipalOptions
            }
            if self.arrayMuncipalOptionsFiltered.count == 0{
                self.tblVw.displayBackgroundText(text: "no record found".localized())
            }else{
                self.tblVw.displayBackgroundText(text: "")
            }
            self.tblVw.reloadData()
            
        case "Skill":
            self.arrayOptionsFiltered.removeAll()
            if textfield.text?.count != 0 {
                for dicData in self.arrayOptions {
                    let isMachingWorker : NSString = (dicData.strName) as NSString
                    let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                    if range != nil {
                        arrayOptionsFiltered.append(dicData)
                    }
                }
            } else {
                self.arrayOptionsFiltered = self.arrayOptions
            }
            if self.arrayOptionsFiltered.count == 0{
                self.tblVw.displayBackgroundText(text: "no record found".localized())
            }else{
                self.tblVw.displayBackgroundText(text: "")
            }
            self.tblVw.reloadData()
        case "SpokenLanguage":
            self.arrSpokenLanguageArrayFiltered.removeAll()
            if textfield.text?.count != 0 {
                for dicData in self.arrSpokenLanguageArray {
                    let isMachingWorker : NSString = (dicData.strName) as NSString
                    let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                    if range != nil {
                        arrSpokenLanguageArrayFiltered.append(dicData)
                    }
                }
            } else {
                self.arrSpokenLanguageArrayFiltered = self.arrSpokenLanguageArray
            }
            if self.arrSpokenLanguageArrayFiltered.count == 0{
                self.tblVw.displayBackgroundText(text: "no record found".localized())
            }else{
                self.tblVw.displayBackgroundText(text: "")
            }
            self.tblVw.reloadData()
        case "WrittenLanguage":
            self.arrWrittenLanguageArrayFiltered.removeAll()
            if textfield.text?.count != 0 {
                for dicData in self.arrWrittenLanguageArray {
                    let isMachingWorker : NSString = (dicData.strName) as NSString
                    let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                    if range != nil {
                        arrWrittenLanguageArrayFiltered.append(dicData)
                    }
                }
            } else {
                self.arrWrittenLanguageArrayFiltered = self.arrWrittenLanguageArray
            }
            if self.arrWrittenLanguageArrayFiltered.count == 0{
                self.tblVw.displayBackgroundText(text: "no record found".localized())
            }else{
                self.tblVw.displayBackgroundText(text: "")
            }
            self.tblVw.reloadData()
        case "Desired":
            self.arrDesiredFiltered.removeAll()
            if textfield.text?.count != 0 {
                for dicData in self.arrDesired {
                    let isMachingWorker : NSString = (dicData.strName) as NSString
                    let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                    if range != nil {
                        arrDesiredFiltered.append(dicData)
                    }
                }
            } else {
                self.arrDesiredFiltered = self.arrDesired
            }
            if self.arrDesiredFiltered.count == 0{
                self.tblVw.displayBackgroundText(text: "no record found".localized())
            }else{
                self.tblVw.displayBackgroundText(text: "")
            }
            self.tblVw.reloadData()
        default:
            break
        }
    }
    
}


extension PopUpViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch strIsComingFrom {
        case "City":
            return self.arrayMuncipalOptionsFiltered.count
        case "Skill":
            return self.arrayOptionsFiltered.count
        case "SpokenLanguage":
            return self.arrSpokenLanguageArrayFiltered.count
        case "WrittenLanguage":
            return self.arrWrittenLanguageArrayFiltered.count
        case "Desired":
            return self.arrDesiredFiltered.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell")as! OptionsTableViewCell
        
        switch strIsComingFrom {
        case "City":
            cell.lblTitle.text = self.arrayMuncipalOptionsFiltered[indexPath.row].strName
            if self.arrayMuncipalOptionsFiltered[indexPath.row].isSelected == true{
                cell.vwBorder.borderColor = UIColor.init(named: "AppDefaultGolden")
                cell.vwTick.isHidden = false
            }else{
                cell.vwBorder.borderColor = UIColor.lightGray
                cell.vwTick.isHidden = true
            }
        case "Skill":
            cell.lblTitle.text = self.arrayOptionsFiltered[indexPath.row].strName
            if self.arrayOptionsFiltered[indexPath.row].isSelected == true{
                cell.vwBorder.borderColor = UIColor.init(named: "AppDefaultGolden")
                cell.vwTick.isHidden = false
            }else{
                cell.vwBorder.borderColor = UIColor.lightGray
                cell.vwTick.isHidden = true
            }
        case "SpokenLanguage":
            cell.lblTitle.text = self.arrSpokenLanguageArrayFiltered[indexPath.row].strName
            if self.arrSpokenLanguageArrayFiltered[indexPath.row].isSelected == true{
                cell.vwBorder.borderColor = UIColor.init(named: "AppDefaultGolden")
                cell.vwTick.isHidden = false
            }else{
                cell.vwBorder.borderColor = UIColor.lightGray
                cell.vwTick.isHidden = true
            }
        case "WrittenLanguage":
            cell.lblTitle.text = self.arrWrittenLanguageArrayFiltered[indexPath.row].strName
            if self.arrWrittenLanguageArrayFiltered[indexPath.row].isSelected == true{
                cell.vwBorder.borderColor = UIColor.init(named: "AppDefaultGolden")
                cell.vwTick.isHidden = false
            }else{
                cell.vwBorder.borderColor = UIColor.lightGray
                cell.vwTick.isHidden = true
            }
        case "Desired":
            cell.lblTitle.text = self.arrDesiredFiltered[indexPath.row].strName
            if self.arrDesiredFiltered[indexPath.row].isSelected == true{
                cell.vwBorder.borderColor = UIColor.init(named: "AppDefaultGolden")
                cell.vwTick.isHidden = false
            }else{
                cell.vwBorder.borderColor = UIColor.lightGray
                cell.vwTick.isHidden = true
            }
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch strIsComingFrom {
        case "City":
            let obj = self.arrayMuncipalOptionsFiltered[indexPath.row]
            let arr = self.arrayMuncipalOptionsFiltered.filter{$0.isSelected == true}
            if obj.isSelected == false{
                if arr.count > 4{
                    objAlert.showAlert(message: "You can Select Max 5", title: MessageConstant.k_AlertTitle, controller: self)
                }else{
                    obj.isSelected = obj.isSelected == false ? true : false
                    self.tblVw.reloadData()
                }
            }else{
                obj.isSelected = obj.isSelected == false ? true : false
                self.tblVw.reloadData()
            }
        case "Skill":
            let obj = self.arrayOptionsFiltered[indexPath.row]
            let arr = self.arrayOptionsFiltered.filter{$0.isSelected == true}
            if obj.isSelected == false{
                if arr.count > 4{
                    objAlert.showAlert(message: "You can Select Max 5", title: MessageConstant.k_AlertTitle, controller: self)
                }else{
                    obj.isSelected = obj.isSelected == false ? true : false
                    self.tblVw.reloadData()
                }
            }else{
                obj.isSelected = obj.isSelected == false ? true : false
                self.tblVw.reloadData()
            }
        case "SpokenLanguage":
            let obj = self.arrSpokenLanguageArrayFiltered[indexPath.row]
            let arr = self.arrSpokenLanguageArrayFiltered.filter{$0.isSelected == true}
            if obj.isSelected == false{
                if arr.count > 4{
                    objAlert.showAlert(message: "You can Select Max 5", title: MessageConstant.k_AlertTitle, controller: self)
                }else{
                    obj.isSelected = obj.isSelected == false ? true : false
                    self.tblVw.reloadData()
                }
            }else{
                obj.isSelected = obj.isSelected == false ? true : false
                self.tblVw.reloadData()
            }
        case "WrittenLanguage":
            let obj = self.arrWrittenLanguageArrayFiltered[indexPath.row]
            let arr = self.arrWrittenLanguageArrayFiltered.filter{$0.isSelected == true}
            if obj.isSelected == false{
                if arr.count > 4{
                    objAlert.showAlert(message: "You can Select Max 5", title: MessageConstant.k_AlertTitle, controller: self)
                }else{
                    obj.isSelected = obj.isSelected == false ? true : false
                    self.tblVw.reloadData()
                }
            }else{
                obj.isSelected = obj.isSelected == false ? true : false
                self.tblVw.reloadData()
            }
        case "Desired":
            let obj = self.arrDesiredFiltered[indexPath.row]
            let arr = self.arrDesiredFiltered.filter{$0.isSelected == true}
            if obj.isSelected == false{
                if arr.count > 4{
                    objAlert.showAlert(message: "You can Select Max 5", title: MessageConstant.k_AlertTitle, controller: self)
                }else{
                    obj.isSelected = obj.isSelected == false ? true : false
                    self.tblVw.reloadData()
                }
            }else{
                obj.isSelected = obj.isSelected == false ? true : false
                self.tblVw.reloadData()
            }
        default:
            break
        }
    }
    
}

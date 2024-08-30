//
//  IndustryExpertiseViewController.swift
//  SignOn
//
//  Created by Callsoft on 26/03/19.
//  Copyright © 2019 Callsoft. All rights reserved.
//

import UIKit
import CloudTagView
import RealmSwift


class IndustryExpertiseViewController: UIViewController,UITextFieldDelegate,backDataToEditProfileMentor {
    func backDataToMentor(id: String, name: String) {
        industriesNameArr.append(name)
        industriesIDArr.add(id)
        self.tblView.reloadData()
    }
    

   // let cloudView = CloudTagView()

    @IBOutlet weak var myView: UIView!
   
    @IBOutlet weak var tblView: UITableView!
    let realm = try! Realm()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    
    
    
    //VARIABLES FOR MENTOR
    var totalWorkingExperience = Int()
    var professionalSummary = String()
    var userName = String()
    var yearVariable = Int()
    var monthVariable = Int()
    var m_name = String()
    var m_email = String()
    var m_companyName = String()
    var designationID = String()
    
    var industriesNameArr = [String]()
    var industriesIDArr = NSMutableArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "IndustryExpertiseTableViewCell", bundle: nil), forCellReuseIdentifier: "IndustryExpertiseTableViewCell")
//        cloudView.frame = CGRect(x: 25, y: 30, width: 341, height: 482)
//        cloudView.delegate = self
        
      //  addTextField.addSubview(cloudView)
       // addingNormalTags()

        // Do any additional setup after loading the view.
        
        appliedJobsAPI()
    }
    @IBAction func backCtion(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        saveManageProfile()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
         return true
    }
    
    // MARK: Actions
    
    @IBAction func addTag(_ sender: UIButton)
    {
      //  cloudView.tags.append(TagView(text: addTextField.text!))
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddKeySkillsMentorVC") as! AddKeySkillsMentorVC
        vc.backObj = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func deleteRow(_ sender: UIButton) {
        self.industriesIDArr.removeObject(at: sender.tag)
        self.industriesNameArr.remove(at: sender.tag)
        self.tblView.reloadData()
    }
    
    func appliedJobsAPI() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            //GET https://portal.signon.co.in/api/v1/candidates/12893
            
            var token = String()
            var userID =  String()
            var userType = Bool()
            var apiName = String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                userType = userInfo.isMentor
            }
            
            if userType{
                apiName = "/mentors/"
            }else{
                apiName = "/candidates/"
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("\(apiName)\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    
                  
                        print(responseJASON)
                        if let dataArr = responseJASON.dictionaryObject as NSDictionary?{
                            self.macroObj.hideLoader()
                            print(dataArr)
                            
                            if let name = dataArr.value(forKey: "Name") as? String{
                                self.m_name = name
                            }
                            
                            if let email = dataArr.value(forKey: "Email") as? String{
                                self.m_email = email
                            }
                            
                            if let companyName = dataArr.value(forKey: "CompanyName") as? String{
                                self.m_companyName = companyName
                            }
                            
                            if let designationDict = dataArr.value(forKey: "Designation") as? NSDictionary{
                                if let designationID = designationDict.value(forKey: "Id") as? String{
                                    self.designationID = designationID
                                }
                                
                                if let designationID = designationDict.value(forKey: "Id") as? Int{
                                    self.designationID = String(designationID)
                                }
                                
                                
                                
                            }
                            
                            if let totalWorkingExperience = dataArr.value(forKey: "TotalWorkingExperience") as? Int{
                                self.totalWorkingExperience = totalWorkingExperience
                                
                            }
                            
                            
                          
                            
                            if let professionalSummary = dataArr.value(forKey: "ProfessionalSummary") as? String{
                                self.professionalSummary = professionalSummary
                                
                            }
                            
                            if let UserName = dataArr.value(forKey: "UserName") as? String{
                                self.userName = UserName
                            }
                            
                        }
                        
                    
                    
                }else{
                    self.macroObj.hideLoader()
                }
                
                
            }, failure: { (error,responseCode) in
                print(error.localizedDescription)
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            })
        }
        else {
            //LODER HIDE
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    
    func saveManageProfile(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var token = String()
            var userID =  String()
            var isMentor = Bool()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                isMentor = userInfo.isMentor
            }
            
            // self.totalWorkingExperience = self.yearVariable + self.monthVariable
            let totalWorkExp = "\(self.totalWorkingExperience)"
            
            print(totalWorkExp)
            let passDict = ["CompanyName":self.m_companyName,
                            "DesignationId":self.designationID,
                            "Email":self.m_email,
                            "Industries":[],
                            "IndustryId":0,
                            "IndustryIds":industriesIDArr,
                            "Name":m_name,
                            "ProfessionalSummary":self.professionalSummary,
                            "ProfileImageId":0,
                            "ProfileStatus":0,
                            "Status":false,
                            "TotalWorkingExperience":totalWorkExp,
                            "UserName":self.userName,
                            "CreatedAt":"",
                            "Id":userID,
                            "UpdatedAt":""] as [String: Any]
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
                
            ]
            
            print(passDict)
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.mentor)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.navigationController?.popViewController(animated: true)
                    //                    if (UserDefaults.standard.value(forKey: "IMG_DATA") != nil){
                    //                      //  self.ImageApiCall()
                    //                    }else{
                    //                        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
                    //                        self.navigationController?.pushViewController(home, animated: true)
                    //                    }
                    
                    
                    
                    
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }
                
                
            }) { (error,responseCode) in
                print(error.localizedDescription)
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            }
            
            
        }else{
            //LODER HIDE
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
            
        }
    }
    
}

/* extension IndustryExpertiseViewController : TagViewDelegate {
    func tagDismissed(_ tag: TagView) {
        print("tag dismissed: " + tag.text)
    }

    func tagTouched(_ tag: TagView) {
        print("tag touched: " + tag.text)
    }
    
    
        func addingNormalTags() {
            let normalTags = self.industriesNameArr
    
            for s in normalTags {
                let fatTag = TagView(text: s)
                fatTag.marginTop = 20
                cloudView.tags.append(fatTag)
            }
        }
    
        func addingSpecialTags() {
            let normalTag = TagView(text: "normal tag")
            cloudView.tags.append(normalTag)
    
            let fatTag = TagView(text: "fat tag")
            fatTag.marginTop = 20
            cloudView.tags.append(fatTag)
    
            let longTag = TagView(text: "stretched tag")
            longTag.marginLeft = 40
            cloudView.tags.append(longTag)
    
            let trimmedTag = TagView(text: "Trimmed: This tag is a example of tag with a huge text.")
            trimmedTag.maxLength = 15
            cloudView.tags.append(trimmedTag)
    
            let noIconTag = TagView(text: "tag without dismiss icon")
            noIconTag.iconImage = nil
            cloudView.tags.append(noIconTag)
    
            let otherNormalTag = TagView(text: "other normal tag")
            cloudView.tags.append(otherNormalTag)
    
            let differentFontTag = TagView(text: "different font tag")
            differentFontTag.font = UIFont(name: "Baskerville", size: 12)!
            cloudView.tags.append(differentFontTag)
    
            let coloredTag = TagView(text: "colored tag")
            coloredTag.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
            cloudView.tags.append(coloredTag)
    
            let tintColorTag = TagView(text: "tint color tag")
            tintColorTag.tintColor = UIColor.yellow
            cloudView.tags.append(tintColorTag)
        }
    
    
    

    
} */

    // MARK: Methods
    



extension IndustryExpertiseViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return industriesNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "IndustryExpertiseTableViewCell", for: indexPath) as! IndustryExpertiseTableViewCell
        
        cell.lblTitle.text = industriesNameArr[indexPath.row]
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(deleteRow), for: .touchUpInside)
         
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

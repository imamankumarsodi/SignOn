//
//  ProfessionalSummaryVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import RSKPlaceholderTextView

class ProfessionalSummaryVC: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var specailProjectTextView: RSKPlaceholderTextView!
    
    let realm = try! Realm()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    
    var directRepo = String()
    var IndirectRepo = String()
    var EmploymentTypes = Int()
    var jobType = Int()
    var NoticePeriod = String()
    var roleId = String()
    var functionalAreaId = String()
    var preferedLocationIdArray = NSArray()
    var industryID = String()
    var toolsArray = NSArray()
    var txtViewCertification = String()
    var totlalWorkExp = Int()
    var annualSalary = Int()
    var bio = String()
    var keywordArray = NSMutableArray()
    var keywordsIDArray = NSMutableArray()
    var salaryResult = Float()
    var RegionsServeIdsArray = NSArray()
    
    var valPass = Bool()
    var workPermit = Bool()
    var valVisa = Bool()
    
    
    
    //VARIABLES FOR MENTOR
    var totalWorkingExperience = Int()
    var InduStrArrId = NSMutableArray()
    var professionalSummary = String()
    var userName = String()
    var yearVariable = Int()
    var monthVariable = Int()
    var m_name = String()
    var m_email = String()
    var m_companyName = String()
    var designationID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.specailProjectTextView.text = "Write here..."
        self.specailProjectTextView.textColor = UIColor.lightGray
        self.specailProjectTextView.delegate = self
        appliedJobsAPI()
    }
    

    @IBAction func btn_backToProfile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btn_saveToProfile(_ sender: Any) {
        var userType = Bool()
        if let userInfo = realm.objects(LoginDataModal.self).first{
            userType = userInfo.isMentor
        }
        
        if userType{
            saveManageProfile()
        }else{
            saveCandidateData()
        }
        
        
       
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if specailProjectTextView.textColor == UIColor.lightGray {
            specailProjectTextView.text = ""
            specailProjectTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if specailProjectTextView.text == "" {
            specailProjectTextView.text = "Enter here..."
            specailProjectTextView.textColor = UIColor.lightGray
        }
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
                    
                     if !userType{
                    self.macroObj.hideLoader()
                    
                    var rname = String()
                    print(responseJASON)
                    
                    if let Bio = responseJASON["Bio"].stringValue as? String{
                        self.bio = Bio
                    }
                    
                    self.specailProjectTextView.text = self.bio
                    
                    let annualSalary = responseJASON["AnnualSalary"].intValue as? Int ?? 0
                    if annualSalary != 0{
                        print(annualSalary)
                        self.annualSalary = annualSalary
                    }
                    
                    self.totlalWorkExp = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                    
                    if let keywordsIDArray = responseJASON["SkillIds"].arrayObject as? NSArray{
                        self.keywordsIDArray = keywordsIDArray.mutableCopy() as! NSMutableArray
                    }
                    
                   
                    print(self.keywordsIDArray)
                    
                    
                    if let PreferedLocationIds = responseJASON["PreferedLocationIds"].arrayObject as? NSArray{
                        self.preferedLocationIdArray = PreferedLocationIds
                        print(self.preferedLocationIdArray)
                    }
                    
                    if let Name = responseJASON["Name"].stringValue as? String{
                        rname = Name
                        UserDefaults.standard.set(rname, forKey: "NAME")
                        
                    }
                    
                    if let Industry = responseJASON["Industry"].dictionaryObject as? NSDictionary{
                        
                        if let Id = Industry.value(forKey: "Id") as? String{
                            self.industryID = String(Id)
                        }
                        
                    }
                    
//                    if self.toolsArray.count > 0{
//                        self.toolsArray.removeAllObjects()
//                    }
                    
                    
                    if let Tools = responseJASON["Tools"].arrayObject as? NSArray{
                        
                        var tools = String()
                        
                        for index in 0..<Tools.count{
                            if let itemDict = Tools[index] as? NSDictionary{
                                
                              //  self.toolsArray.add(itemDict.value(forKey: "Id") as? Int ?? 0)
                                
                                
                                if index == 0{
                                    tools.append("\(itemDict.value(forKey: "Name") as? String ?? "")")
                                }else{
                                    tools.append(" , \(itemDict.value(forKey: "Name") as? String ?? "")")
                                }
                                
                                
                                
                            }
                        }
                        
                    }
                    
                    
                    self.totlalWorkExp = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                    
                    
                    
                   
                    
                    
                    if let Certification = responseJASON["Certification"].stringValue as? String{
                        self.txtViewCertification = Certification
                    }
                    
                    print(self.toolsArray)
                    
                    
                    let totalExp = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                    
                    
                    
                    let expSalary = responseJASON["AnnualSalary"].doubleValue as? Double ?? 0
                    
                    if let profileImage = responseJASON["ProfileImage"].dictionaryObject as? NSDictionary{
                        if let url = profileImage.value(forKey: "Url") as? String{
                            if url == ""{
                                
                            }
                            else{
                                UserDefaults.standard.set(url, forKey: "IMAGE")
                                //                                    let URL = NSURL(string:(url as? String)!)
                                //                                    let data = NSData(contentsOf: URL! as URL)
                                
                                //                                self.imgProfile.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "groupicon"))
                            }
                            
                            
                            
                        }
                    }
                    
                    let email = responseJASON["Email"].stringValue as? String ?? ""
                    
                    let mobile = responseJASON["UserName"].stringValue as? String ?? ""
                    
                    let bio = responseJASON["Bio"].stringValue as? String ?? ""
                    
                    var doubleStr = String(format: "%.2f", expSalary.truncatingRemainder(dividingBy: 1))
                    print(doubleStr)
                    if doubleStr.hasPrefix("0.0") { // true
                        print("Prefix exists")
                        doubleStr = doubleStr.replacingOccurrences(of: "0.0", with: "")
                    }else{
                        doubleStr = doubleStr.replacingOccurrences(of: "0.", with: "")
                        
                    }
                    
                    
                    
                    var keySkillsString = String()
                    
                    if let keySkills = responseJASON["Skills"].arrayObject as? NSArray{
                        var keySkillsArray = [String]()
                        for keySkillsItem in keySkills{
                            if let keySkillsDict = keySkillsItem as? NSDictionary{
                                if let keySkillsString = keySkillsDict.value(forKey: "Name") as? String{
                                    keySkillsArray.append(keySkillsString)
                                }
                                
                            }
                        }
                        keySkillsString = keySkillsArray.joined(separator: ",")
                    }
                    
                    print(keySkillsString)
                    
                    
                    
                    if let educationArr = responseJASON["EducationProfiles"].arrayObject as? NSArray{
                        var heading = String()
                        var content = String()
                        for educationItem in educationArr{
                            if let educationDict = educationItem as? NSDictionary{
                                if let qualiDict = educationDict.value(forKey: "Qualification") as? NSDictionary{
                                    heading = qualiDict.value(forKey: "Name") as? String ?? ""
                                }
                                
                                if let degreeDict = educationDict.value(forKey: "Degree") as? NSDictionary{
                                    content = degreeDict.value(forKey: "Name") as? String ?? ""
                                    print(content)
                                }
                                
                                content.append(contentsOf: ", \(educationDict.value(forKey: "InstitutionName") as? String ?? "")")
                                print(content)
                                
                                content.append(contentsOf: ", \(educationDict.value(forKey: "PassingYear") as? Int ?? 0)")
                                print(content)
                                
                                if let courseDict = educationDict.value(forKey: "Course") as? NSDictionary{
                                    content.append(", \(courseDict.value(forKey: "Name") as? String ?? "")")
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    
                    if let employementArr = responseJASON["Employments"].arrayObject as? NSArray{
                        if employementArr.count > 0{
                            if let employementDict = employementArr.object(at: 0) as? NSDictionary{
                                let startMonth = employementDict.value(forKey: "StartMonth") as? Int ?? 0
                                let endMonth = employementDict.value(forKey: "EndMonth") as? Int ?? 0
                                let endYear = employementDict.value(forKey: "EndYear") as? Int ?? 0
                                var endString = String()
                                if endMonth == 0 || endYear == 0{
                                    endString = "Till Present"
                                }else{
                                    endString = "\(MacrosForAll.sharedInstanceMacro.returnMonth(month: endMonth)) \(endYear)"
                                }
                                
                                
                            }
                        }
                    }
                    
                    
                    
                    //CODE BY AMAN
                    
                    
                    self.roleId =  String(responseJASON["CandidateRoleId"].intValue as? Int ?? 0)
                    print(self.roleId)
                    
                    if self.roleId == "0"{
                        self.roleId = ""
                    }
                    
                    
                    self.functionalAreaId =  String(responseJASON["CandidateFunctionalAreaId"].intValue as? Int ?? 0)
                    print(self.functionalAreaId)
                    
                    if self.functionalAreaId == "0"{
                        self.functionalAreaId = ""
                    }
                    
                    if let jobType = responseJASON["JobTypes"].intValue as? Int{
                        self.jobType = jobType
                    }
                    
                    
                    if let jobType = responseJASON["EmploymentTypes"].intValue as? Int{
                        self.EmploymentTypes = jobType
                    }
                    
                    
                    
                    var locStringArray = [String]()
                    if let locArray = responseJASON["PreferredLocations"].arrayObject as? NSArray{
                        
                        for keywordsItem in locArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    locStringArray.append(keyWordString)
                                }
                            }
                        }
                    }
                    
                    var locString = String()
                    
                    if locStringArray.count > 0{
                        
                        locString = locStringArray.joined(separator: " ")
                        
                    }else{
                        locString = "No Desired Location Added"
                    }
                    
                    
                    
                    var toolStringArray = [String]()
                    if let toolsArray = responseJASON["Tools"].arrayObject as? NSArray{
                        
                        for keywordsItem in toolsArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    toolStringArray.append(keyWordString)
                                }
                            }
                        }
                    }
                    else{
                        
                    }
                    
                    var toosString = String()
                    if toolStringArray.count > 0{
                        toosString = toolStringArray.joined(separator: " ")
                        
                    }else{
                        toosString = "No Tools Added"
                    }
                    
                    
                    
                    var regiStringArray = [String]()
                    if let toolsArray = responseJASON["RegionsServes"].arrayObject as? NSArray{
                        
                        for keywordsItem in toolsArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    regiStringArray.append(keyWordString)
                                }
                            }
                        }
                    }
                    
                    
                    var regiString = String()
                    if regiStringArray.count > 0{
                        regiString = regiStringArray.joined(separator: " ")
                        
                    }else{
                        regiString = "No Region Added"
                    }
                    
                    
                    
                    
                    
                    let workPermit = responseJASON["HasWorkPermit"].boolValue as?  Bool ?? false
                    self.workPermit = workPermit
                    
                    
                    
                    let valPass = responseJASON["HasValidPassport"].boolValue as?  Bool ?? false
                    self.valPass = valPass
                    
                    
                    
                    let valVisa = responseJASON["IsValidVisa"].boolValue as?  Bool ?? false
                    
                    self.valVisa = valVisa
                    
                    self.IndirectRepo = responseJASON["IndirectRepotees"].stringValue as? String ?? ""
                    
                    self.directRepo = responseJASON["DirectRepotees"].stringValue as?  String ?? ""
                    
                    
                    
                    
                    let NoticePeriod = responseJASON["NoticePeriod"].stringValue as? String ?? "N/A"
                    self.NoticePeriod = NoticePeriod
                    
                    
                    
                    
                    
                    
                    
                    
                    let dob = responseJASON["Dob"].stringValue as? String ?? "2019-05-21T11:38:52"
                    
                    let newString = dob.replacingOccurrences(of: "T", with: " ", options: .literal, range: nil)
                    if newString != ""{
                        if let myDateString = newString as? String {
                            
                            print(myDateString)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let myDate = dateFormatter.date(from: myDateString)!
                            
                            dateFormatter.dateFormat = "dd/MM/YYYY"
                            let somedateString = dateFormatter.string(from: myDate)
                            
                            
                        }
                    }
                    
                    
                    
                    let gen = responseJASON["Gender"].intValue as?  Int ?? 0
                    
                    var genString = String()
                    if gen == 0{
                        genString = "Male"
                    }else{
                        genString = "Female"
                    }
                    
                    
                    
                    let merSt = responseJASON["MaritalStatus"].intValue as?  Int ?? 0
                    
                    var MerString = String()
                    if merSt == 0{
                        MerString = "Single"
                    }else{
                        MerString = "Married"
                    }
                    
                    
                    let IsPhysicallyChallenged = responseJASON["IsPhysicallyChallenged"].intValue as?  Int ?? 1
                    
                    var IsPhysicallyChallengedString = String()
                    if IsPhysicallyChallenged != 1{
                        IsPhysicallyChallengedString = "No"
                    }else{
                        IsPhysicallyChallengedString = "Yes"
                    }
                    
                    self.industryID =  String(responseJASON["CandidateIndustryId"].intValue as? Int ?? 0)
                    print(self.industryID)
                    
                    if self.industryID == "0"{
                        self.industryID = ""
                    }
                    
                    self.toolsArray = responseJASON["ToolIds"].arrayObject as? NSArray ?? [""]
                    print(self.toolsArray)
                    
                    self.RegionsServeIdsArray = responseJASON["RegionsServeIds"].arrayObject as? NSArray ?? [""]
                    print(self.RegionsServeIdsArray)
                    
                    self.macroObj.hideLoader()
                    
                     }else{
                        
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
                            
                            
                            if self.InduStrArrId.count > 0{
                                self.InduStrArrId.removeAllObjects()
                            }
                            
                            if let industryIds = dataArr.value(forKey: "IndustryIds") as? NSArray{
                                
                                if let arrayMutable = industryIds.mutableCopy() as? NSMutableArray{
                                    self.InduStrArrId = arrayMutable
                                }
                                
                                
                            }
                            
                            if let professionalSummary = dataArr.value(forKey: "ProfessionalSummary") as? String{
                                self.professionalSummary = professionalSummary
                                self.specailProjectTextView.text = professionalSummary
                                self.specailProjectTextView.textColor = UIColor.black
                            }
                            
                            if let UserName = dataArr.value(forKey: "UserName") as? String{
                                self.userName = UserName
                            }
                            
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
    
    
//    func appliedJobsAPI() {
//        if InternetConnection.internetshared.isConnectedToNetwork() {
//            //GET https://portal.signon.co.in/api/v1/candidates/12893
//            
//            var token = String()
//            var userID =  String()
//            if let userInfo = realm.objects(LoginDataModal.self).first{
//                token = userInfo.token
//                userID = userInfo.Id
//            }
//            
//            let header = [
//                "Content-Type": "application/json; charset=UTF-8",
//                "Authorization" : "Bearer \(token)"
//            ]
//            macroObj.showLoader(view: self.view)
//            alamObject.getRequestURL("/candidates/\(userID)", headers: header, success: { (responseJASON,responseCode) in
//                if responseCode == 200{
//                    var preferedLocations = String()
//                    self.macroObj.hideLoader()
//                    print(responseJASON)
//                    if let Bio = responseJASON["Bio"].stringValue as? String{
//                        self.specailProjectTextView.text = Bio
//                    }
//                    
//                }else{
//                    self.macroObj.hideLoader()
//                }
//                
//                
//            }, failure: { (error,responseCode) in
//                print(error.localizedDescription)
//                self.macroObj.hideLoader()
//                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
//            })
//        }
//        else {
//            //LODER HIDE
//            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
//        }
//    }
    
    func validationSetup()->Void{
        
        var message = ""
        if !validation.validateBlankField(specailProjectTextView.text!) || specailProjectTextView.text == "Write here..."{
            message = MacrosForAll.VALIDMESSAGE.EnterFullBio.rawValue
        }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            saveCandidateData()
        }
    }
    
    
    
    func saveCandidateData(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }
            
            
            let passDict = ["DirectRepotees":String(self.directRepo),
                            "EmploymentTypes":self.EmploymentTypes,
                            "HasValidPassport":self.valPass,
                            "HasWorkPermit":self.workPermit,
                            "IndirectRepotees":String(self.IndirectRepo),
                            "IsValidVisa":self.valVisa,
                            "JobTypes":self.jobType,
                            "NoticePeriod":self.NoticePeriod,
                            "CandidateRoleId":String(self.roleId),
                            "CandidateFunctionalAreaId":String(self.functionalAreaId),
                            "PreferedLocationIds":self.preferedLocationIdArray,
                            "CandidateIndustryId":String(self.industryID),
                            "ToolIds":self.toolsArray,
                            "Certification":self.txtViewCertification,
                            "Id":userID,
//                            "Mobile":txtPhoneNumber.text!,
//                            "Email":txtEmailID.text!,
//                            "Name":txtFullName.text!,
//                            "Phone":txtPhoneNumber.text!,
                            "TotalWorkingExperience":self.totlalWorkExp,
                            "Bio":specailProjectTextView.text!,
                            "AnnualSalary":self.annualSalary,
                            "Skills":self.keywordArray,
                            "SkillIds":self.keywordsIDArray,
                            "RegionsServeIds":RegionsServeIdsArray] as? [String:Any]

            
            
            
            
            print(passDict)
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.firstGetAllHomeData)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                // self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    print(responseJson)
                    
                    self.navigationController?.popViewController(animated: true)
                                        
                    //                    let manageProfile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmploymentManageProfileVC") as! EmploymentManageProfileVC
                    //                    manageProfile.passDict = self.passDict
                    self.navigationController?.popViewController(animated: true)
                    
                    
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
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
                            "IndustryIds":InduStrArrId,
                            "Name":m_name,
                            "ProfessionalSummary":self.specailProjectTextView.text!,
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

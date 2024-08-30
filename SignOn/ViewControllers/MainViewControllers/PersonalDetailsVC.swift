//
//  PersonalDetailsVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import DatePickerDialog
import DropDown

class PersonalDetailsVC: UIViewController {

    
    
    @IBOutlet weak var txtDob: UITextField!
    
    @IBOutlet weak var txtGender: UITextField!
    
    @IBOutlet weak var txtMaritalStatus: UITextField!
    
    @IBOutlet weak var txtPhysicallyChallenged: UITextField!
    
    @IBOutlet weak var txtLine1: UITextField!
    
    @IBOutlet weak var txtLine2: UITextField!
    
    @IBOutlet weak var txtLandmark: UITextField!
    
    
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var txtState: UITextField!
    
    
    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var txtPincode: UITextField!
    
    
    var IsPhysicallyChallengedStatus = Bool()
    var genderStatus = Int()
    var MaritalStatus = Int()
    var defaultDate: Date!
    let dropDown = DropDown()
    var dropDownTag = Int()
    var genderArr: [String] = ["Male","Female"]
    var maritalStatusArr: [String] = ["Single","Married"]
    
    var physiscalChlangedArr = ["Yes","No"]
    
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let realm = try! Realm()
    
    
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
    
    var salaryResult = Float()
    var RegionsServeIdsArray = NSArray()
    
    var valPass = Bool()
    var workPermit = Bool()
    var valVisa = Bool()
    
    
   
    var keywordArray = NSMutableArray()
    var keywordsIDArray = NSMutableArray()
    
    
    
    
  
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appliedJobsAPI()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if self.dropDownTag == 1{
                self.txtGender.text = "\(item)"
                if  self.txtGender.text == "Male"{
                    self.genderStatus = 0
                }
                else {
                    self.genderStatus = 1
                }
            }
            else if self.dropDownTag == 2{
                self.txtPhysicallyChallenged.text = "\(item)"
                if  self.txtGender.text == "No"{
                    self.IsPhysicallyChallengedStatus = false
                }
                else {
                    self.IsPhysicallyChallengedStatus = true
                    
                }
            }
                
            else if self.dropDownTag == 3{
//                self.txtYears.text = "\(item)"
//                let str = self.txtYears.text!
//                if str == "Year"{
//                    self.txtYears.text = ""
//                }
//                else{
//                    let arr = str.components(separatedBy: " ").compactMap{Int($0)}
//                    self.yearId = Int(arr[0])
//                }
            }
            else if self.dropDownTag == 4{
//                self.txtMonth.text = "\(item)"//done
//                let str = self.txtMonth.text!
//                if str == "Month"{
//                    self.txtMonth.text = ""
//                }
//                else{
//                    let arr = str.components(separatedBy: " ").compactMap{Int($0)}
//                    self.monthId = Int(arr[0])
//                }
            }
            else if self.dropDownTag == 5{
                self.txtMaritalStatus.text = "\(item)"
                if  self.txtMaritalStatus.text == "Single"{
                    self.MaritalStatus = 0
                }
                else {
                    self.MaritalStatus = 1
                }
            }else{
                print("do nothing with dropdown")
            }
        }
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        JobseekarManageProfileApiMethod()
        
    }

    @IBAction func btn_backToProfile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

    
    @IBAction func dobBtnAction(_ sender: UIButton) {
        //show date picker
        dobDropDown()
    }
    
    @IBAction func genderBtnAction(_ sender: Any)
    {
        dropDownTag = 1
        dropDown.dataSource = genderArr
        dropDown.anchorView = txtGender
        dropDown.show()
    }
    
    @IBAction func maritalBtnAction(_ sender: UIButton) {
        dropDownTag = 5
        dropDown.dataSource = maritalStatusArr
        dropDown.anchorView = txtMaritalStatus
        dropDown.show()
    }
    
    func dobDropDown() {
        
        let date = Date()
        DatePickerDialog().show("Select date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: defaultDate ?? Date(), minimumDate: nil, maximumDate: date, datePickerMode: .date) { (date) -> Void in
            if let dt = date
            {
                let formatter  = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.defaultDate = dt
                print(formatter.string(from: dt))
                self.txtDob.text! = formatter.string(from: dt)
            }
        }
    }
    
    @IBAction func physicalChallangedBtnAction(_ sender: Any)
    {
        dropDownTag = 2
        dropDown.dataSource = physiscalChlangedArr
        dropDown.anchorView = txtPhysicallyChallenged
        dropDown.show()
        
    }
    
    func appliedJobsAPI() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            //GET https://portal.signon.co.in/api/v1/candidates/12893
            
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            alamoFireObj.getRequestURL("/candidates/\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                  
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    
                    if let Dob = responseJASON["Dob"].stringValue as? String {
                        self.txtDob.text = Dob
                    }
                    
                    
                    if let Gender = responseJASON["Gender"].intValue as? Int {
                        self.genderStatus = Gender
                        if Gender == 0{
                            self.txtGender.text = "Male"
                        }else{
                           self.txtGender.text = "Female"
                        }
                        
                        
                    }
                    
                    if let IsPhysicallyChallenged = responseJASON["IsPhysicallyChallenged"].boolValue as? Bool {
                        self.IsPhysicallyChallengedStatus = IsPhysicallyChallenged
                        
                        if IsPhysicallyChallenged == false{
                            self.txtPhysicallyChallenged.text = "No"
                        }else{
                            self.txtPhysicallyChallenged.text = "Yes"
                        }
                    }
                    
                    
                    if let MaritalStatus = responseJASON["MaritalStatus"].intValue as? Int {
                        self.MaritalStatus = MaritalStatus
                        
                        if MaritalStatus == 0{
                            self.txtMaritalStatus.text = "Single"
                        }else{
                            self.txtMaritalStatus.text = "Married"
                        }
                    }
                    
                    
                    if let Address = responseJASON["Address"].dictionaryObject as? NSDictionary {
                        if let Country = Address.value(forKey: "Country") as? String{
                            self.txtCountry.text = Country
                        }
                        
                        if let State = Address.value(forKey: "State") as? String{
                            self.txtState.text = State
                        }
                        
                        if let City = Address.value(forKey: "City") as? String{
                            self.txtCity.text = City
                        }
                        
                        if let Pincode = Address.value(forKey: "Pincode") as? String{
                            self.txtPincode.text = Pincode
                        }
                        
                        if let Landmark = Address.value(forKey: "Landmark") as? String{
                            self.txtLandmark.text = Landmark
                        }
                        
                        if let Line1 = Address.value(forKey: "Line1") as? String{
                           self.txtLine1.text = Line1
                        }
                        
                        if let Line2 = Address.value(forKey: "Line2") as? String{
                            self.txtLine2.text = Line2
                        }
                        
                        if let Bio = responseJASON["Bio"].stringValue as? String{
                            self.bio = Bio
                        }
                        
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
                           // rname = Name
                          //  UserDefaults.standard.set(rname, forKey: "NAME")
                            
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
                        
                        
                        
                        
                        
                        let workPermit = responseJASON["HasWorkPermit"].boolValue as? Bool ?? false
                        self.workPermit = workPermit
                        
                        
                        
                        let valPass = responseJASON["HasValidPassport"].boolValue as? Bool ?? false
                        self.valPass = valPass
                        
                        
                        
                        let valVisa = responseJASON["IsValidVisa"].boolValue as? Bool ?? false
                        
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
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    func JobseekarManageProfileApiMethod(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            var token = String()
            var userID =  String()
            var isMentor = Bool()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                isMentor = userInfo.isMentor
            }
            
            let apiname = isMentor ? "mentors" : "candidates"
            
            let addressDict = ["City":self.txtCity.text!,
                               "Country":self.txtCountry.text!,
                               "Landmark":txtLandmark.text!,
                               "Line1":txtLine1.text!,
                               "Line2":txtLine2.text!,
                               "Pincode":txtPincode.text!,
                               "State":txtState.text!]
           
            
            let passDict = ["Address":addressDict,
                            "Dob":txtDob.text!,
                            "Gender":self.genderStatus,
                            "IsPhysicallyChallenged":self.IsPhysicallyChallengedStatus,
                            "MaritalStatus":MaritalStatus,
                            "Id":userID,
                            "DirectRepotees":String(self.directRepo),
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
                            "TotalWorkingExperience":self.totlalWorkExp,
                            "Bio":bio,
                            "AnnualSalary":self.annualSalary,
                            "Skills":self.keywordArray,
                            "SkillIds":self.keywordsIDArray,
                            "RegionsServeIds":RegionsServeIdsArray] as? [String:AnyObject]
            
            
      
            
            
            
            print("PASSDICT", passDict)
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            print(apiname)
            print(header)
            macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURL("\(apiname)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    self.navigationController?.popViewController(animated: true)
                    
//                    if (UserDefaults.standard.value(forKey: "IMG_DATA") != nil) && (UserDefaults.standard.value(forKey: "RES_DATA") != nil){
//                        self.ImageResumeApiCall(passDictData: passDict!)
//                    }else if (UserDefaults.standard.value(forKey: "IMG_DATA") != nil){
//                        self.ImageApiCall(passDictData: passDict!)
//                    }else if (UserDefaults.standard.value(forKey: "RES_DATA") != nil){
//                        self.resumeApiCall(passDictData: passDict!)
//                    }else{
//                        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManagePFLEducationVC") as! ManagePFLEducationVC
//                        home.passDict = passDict!
//                        self.navigationController?.pushViewController(home, animated: true)
//                    }
                    
                    
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
    
}

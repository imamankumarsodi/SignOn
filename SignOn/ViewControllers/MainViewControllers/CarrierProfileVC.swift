//
//  CarrierProfileVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
import RealmSwift
import DropDown

class CarrierProfileVC: UIViewController,searchData {
    
    func searchData(selecetdNameArray: NSMutableArray, selecetdIdArray: NSMutableArray, isComingFromIndex: Int) {
        if isComingFromIndex == 1{
            print("selected name array",selecetdNameArray)
            print("selected Id array",selecetdIdArray)
            self.preferedLocationIdArray = selecetdIdArray
            print("selected MyId array",preferedLocationIdArray)
            
            let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
            
            print("THE BREAK STR",breakStr)
            self.txtPreferedLocation.text! = breakStr
        }else if isComingFromIndex == 2{
            print("selected name array",selecetdNameArray)
            print("selected Id array",selecetdIdArray)
            self.RegionIdArr = selecetdIdArray
            print("selected MyId array",preferedLocationIdArray)
            
            let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
            
            print("THE BREAK STR",breakStr)
            self.txtRegionServed.text! = breakStr
        }
        else if isComingFromIndex == 10{
            print("selected name array",selecetdNameArray)
            print("selected Id array",selecetdIdArray)
            self.toolsArray = selecetdIdArray
            
            
            let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
            
            print("THE BREAK STR",breakStr)
            self.txtViewTools.text! = breakStr
        }
        
    }
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtPreferedLocation: UITextField!
    
    @IBOutlet weak var txtJobType: UITextField!
    @IBOutlet weak var txtEmployementType: UITextField!
    @IBOutlet weak var txtWorkPermit: UITextField!
    
    @IBOutlet weak var txtValidPassport: UITextField!
    @IBOutlet weak var txtValidVisa: UITextField!
    
    @IBOutlet weak var txtNoticePeriod: UITextField!
    
    @IBOutlet weak var txtFunctionalArea: UITextField!
    @IBOutlet weak var txtJobRole: UITextField!
    
    @IBOutlet weak var txtViewTools: RSKPlaceholderTextView!
    @IBOutlet weak var txtIndustries: UITextField!
    
    @IBOutlet weak var txtRegionServed: UITextField!
    
    @IBOutlet weak var txtViewCertification: RSKPlaceholderTextView!
    
    @IBOutlet weak var txtNoOfDirectReporties: UITextField!
    
    @IBOutlet weak var txtNoOfIndirectReporties: UITextField!
    
    
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    var previousOffset: CGFloat = 0
    let realm = try! Realm()
    
    var preferedLocationIdArray = NSArray()
    var jobType = Int()
    var EmploymentType = Int()
    var workPermit = Bool()
    var validPassport = Bool()
    var validVisa = Bool()
    var roleId = String()
    var functionalAreaId = String()
    var industryID = String()
    var toolsArray = NSMutableArray()
    var RegionsServeIdsArray = NSArray()
    var directReporties = Int()
    var inDirectReporties = Int()
    let dropDown = DropDown()
    var dropDownTag = Int()
    
    var RoleArr = [String]()
    var RoleIdArr = NSMutableArray()
    var resutResponseArray = NSArray()
    var FuncitionalAreaArr = [String]()
    var FunctionalAreaID =   NSMutableArray()
    var IndustriesArr = [String]()
    var InduStrArrId =  NSMutableArray()
    var RegionArr = [String]()
    var RegionIdArr = NSMutableArray()
    var selectedToolsArrId = NSMutableArray()
    var toolsResponseArray = [String]()
    
    var jobTypeArr =   ["Permanent","Temporary","Permanent or Temporary"]
    var empTypeArr =    ["FullTime","PartTime","FullTime or PartTime"]
    var workPermitArr = ["Yes","No"]
    var validVisaArr = ["Yes","No"]
    var validPasPortArr = ["Yes","No"]
    var noticePeriodArr = ["1 month","2 month","3 month"]
    var DirectReportiseArr = ["DirectReporitse","B","C", "D"]
    var InDirectReportiseArr = ["DirectReporitse","B","C", "D"]
    var bio = String()
    var annualSalary = Int()
    var keywordArray = NSMutableArray()
    var keywordsIDArray = NSMutableArray()
    var salaryResult = Float()
    var totlalWorkExp = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtViewTools.isEditable = false
        self.txtViewCertification.isEditable = true
        // Do any additional setup after loading the view.
        if let userInfo = realm.objects(LoginDataModal.self).first{
            if let totalExperience = Int(userInfo.TotalWorkingExperience) as? Int{
//                txtYear.text = "\(totalExperience/12) Year"
//                txtMonth.text = "\(totalExperience%12) Month"
                
                self.totlalWorkExp = totalExperience
            }
            if let AnnualSalary = userInfo.AnnualSalary as? Int{
                salaryResult = Float(AnnualSalary)
//                txtLacks.text = "\(AnnualSalary/100000) Lakhs"
//                txtThousands.text = "\((AnnualSalary%100000)/1000) Thousands"
            }
//            self.imgProfile.sd_setImage(with: URL(string: userInfo.Url), placeholderImage: UIImage(named: "groupicon"))
        }
        appliedJobsAPI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            // print("Selected item: \(item) at index: \(index)")
            
            if self.dropDownTag == 1{
                //                self.txtLack.text = "\(item)"
                //                let str = self.txtLack.text!
                //                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                //                self.lacksStr = Float(arr[0])
                //                self.salaryResult = Float(self.lacksStr + (self.thousandStr * 0.01))
                //                print(self.salaryResult)
                
            }
                
            else if self.dropDownTag == 2{
                //                self.txtThousand.text = "\(item)"
                //                let str = self.txtThousand.text!
                //                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                //                self.thousandStr = Float(arr[0])
                //                self.salaryResult = Float(self.lacksStr + (self.thousandStr * 0.01))
                //                print(self.salaryResult)
            }
            else if self.dropDownTag == 3{
                self.txtJobType.text = "\(item)"
                self.jobType = index
                print(index)
            }
            else if self.dropDownTag == 4{
                self.txtEmployementType.text = "\(item)"
                self.EmploymentType = index
            }
            else if self.dropDownTag == 5{
                self.txtWorkPermit.text = "\(item)"
                if  self.txtWorkPermit.text! == "No"{
                    self.workPermit = false
                }
                else{
                    self.workPermit = true
                }
            }
            else if self.dropDownTag == 6{
                self.txtValidPassport.text = "\(item)"
                if self.txtValidPassport.text! == "No"{
                    self.validPassport = false
                }
                else{
                    self.validPassport = true
                }
            }
                
            else if self.dropDownTag == 7{
                self.txtValidVisa.text = "\(item)"
                if self.txtValidVisa.text  == "No"{
                    self.validVisa = false
                }
                else{
                    self.validVisa = true
                }
            }
                
            else if self.dropDownTag == 8{
                //                self.txtPhysicalChalanged.text = "\(item)"
                //                if self.txtPhysicalChalanged.text == "NO"{
                //                    self.physicalChallangd = false
                //                }
                //                else{
                //                    self.physicalChallangd = true
                //                }
            }
                
            else if self.dropDownTag == 9{
                self.txtNoticePeriod.text = "\(item)"
            }
            else if self.dropDownTag == 10{
                self.txtJobRole.text = "\(item)"
                self.roleId  =  String(self.RoleIdArr.object(at: index) as? String ?? "")
                print("roleId31",self.roleId)
            }
                
            else if self.dropDownTag == 11{
                self.txtFunctionalArea.text = "\(item)"
                self.functionalAreaId  =  String(self.FunctionalAreaID.object(at: index) as? String ?? "")
                print(self.functionalAreaId)
                
            }
            else if self.dropDownTag == 12{
                self.txtIndustries.text = "\(item)"
                self.industryID  =  String(self.InduStrArrId.object(at: index) as? String ?? "")
                print("industryArrId",self.industryID)
            }
            else if self.dropDownTag == 13{
                //  self.txtRegionServed.text = "\(item)"
            }
            else if self.dropDownTag == 14{
                self.txtNoOfDirectReporties.text = "\(item)"
            }
            else if self.dropDownTag == 15{
                self.txtNoOfIndirectReporties.text = "\(item)"
            }
        }
    }
    
    
    @IBAction func btn_backToProfile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btn_Save(_ sender: Any) {
        JobseekarManageProfileApiMethod()
        
    }
    
    
    @IBAction func regionBtnAction(_ sender: Any) {
        //        dropDownTag = (sender as AnyObject).tag
        //        dropDown.dataSource = RegionArr
        //        dropDown.anchorView = regionBtn
        //        dropDown.show()
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "SearchTabViewController") as! SearchTabViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // popoverContent.preferredContentSize = CGSize(500,600)
        //  popover!.delegate = self
        popover!.sourceView = self.view
        popoverContent.searchDataDelegate = self
        
        popoverContent.passDict = ["fields":["*"],"filter":"DataType=7","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
        popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
        popoverContent.isComingFromIndex = 1
        self.present(nav, animated: true, completion: nil)
        
    }
    
    @IBAction func jobtypeBtnAction(_ sender: Any) {
        dropDownTag = 3
        dropDown.dataSource = jobTypeArr
        dropDown.anchorView = txtJobType
        dropDown.show()
    }
    
    @IBAction func employementBtnAction(_ sender: Any) {
        dropDownTag = 4
        dropDown.dataSource = empTypeArr
        dropDown.anchorView = txtEmployementType
        dropDown.show()
    }
    
    
    @IBAction func workPermitBtnAction(_ sender: Any) {
        dropDownTag = 5
        dropDown.dataSource = workPermitArr
        dropDown.anchorView = txtWorkPermit
        dropDown.show()
    }
    
    @IBAction func validPassportAction(_ sender: Any) {
        dropDownTag = 6
        dropDown.dataSource = validPasPortArr
        dropDown.anchorView = txtValidPassport
        dropDown.show()
    }
    
    @IBAction func validVisaBtn(_ sender: Any) {
        dropDownTag = 7
        dropDown.dataSource = validVisaArr
        dropDown.anchorView = txtValidVisa
        dropDown.show()
    }
    
    @IBAction func noticePeriodBtnAction(_ sender: Any) {
        dropDownTag = 9
        dropDown.dataSource = noticePeriodArr
        dropDown.anchorView = txtNoticePeriod
        dropDown.show()
    }
    @IBAction func roleBtnAction(_ sender: Any) {
        
        dropDownTag = 10
        dropDown.dataSource = RoleArr
        dropDown.anchorView = txtJobRole
        dropDown.show()
    }
    
    
    @IBAction func funcitionalAreaAction(_ sender: Any) {
        dropDownTag = 11
        dropDown.dataSource = FuncitionalAreaArr
        dropDown.anchorView = txtFunctionalArea
        dropDown.show()
    }
    
    @IBAction func industriesBtnAction(_ sender: Any) {
        dropDownTag = 12
        dropDown.dataSource = IndustriesArr
        dropDown.anchorView = txtIndustries
        dropDown.show()
    }
    
    @IBAction func toolsBtnAction(_ sender: Any)
    {
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "SearchTabViewController") as! SearchTabViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // popoverContent.preferredContentSize = CGSize(500,600)
        //  popover!.delegate = self
        popover!.sourceView = self.view
        popoverContent.searchDataDelegate = self
        
        popoverContent.passDict = ["fields":["*"],"filter":"DataType=5","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
        popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
        popoverContent.isComingFromIndex = 10
        self.present(nav, animated: true, completion: nil)
        
    }
    
    @IBAction func regionBtnAction2(_ sender: Any) {
        //        dropDownTag = (sender as AnyObject).tag
        //        dropDown.dataSource = RegionArr
        //        dropDown.anchorView = regionBtn
        //        dropDown.show()
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "SearchTabViewController") as! SearchTabViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // popoverContent.preferredContentSize = CGSize(500,600)
        //  popover!.delegate = self
        popover!.sourceView = self.view
        popoverContent.searchDataDelegate = self
        
        popoverContent.passDict = ["fields":["*"],"filter":"DataType=7","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
        popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
        popoverContent.isComingFromIndex = 2
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    @IBAction func directReportiseAction(_ sender: Any) {
        dropDownTag = 13
        dropDown.dataSource = DirectReportiseArr
        dropDown.anchorView = txtNoOfDirectReporties
        dropDown.show()
    }
    @IBAction func indirectReprtiseAction(_ sender: Any) {
        dropDownTag = 14
        dropDown.dataSource = InDirectReportiseArr
        dropDown.anchorView = txtNoOfIndirectReporties
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
                    var preferedLocations = String()
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    
                  if self.toolsArray.count > 0 {
                        
                        self.toolsArray.removeAllObjects()
                        
                    }
                    
                    if let Roles = responseJASON["Role"].dictionaryObject as? NSDictionary{
                        self.roleId = Roles.value(forKey: "Id") as? String ?? ""
                    }
                    
                   
                    self.roleId =  String(responseJASON["CandidateRoleId"].intValue as? Int ?? 0)
                    print(self.roleId)
                   
                    
                    let annualSalary = responseJASON["AnnualSalary"].intValue as? Int ?? 0
                    if annualSalary != 0{
                        print(annualSalary)
                        self.annualSalary = annualSalary
                    }
                    
                    if let keywordsIDArray = responseJASON["SkillIds"].arrayObject as? NSArray{
                        self.keywordsIDArray = keywordsIDArray.mutableCopy() as! NSMutableArray
                    }
                    
                    
                    if let Certification = responseJASON["Bio"].stringValue as? String{
                        self.bio = Certification
                    }
                    
                    if let PreferedLocationIds = responseJASON["PreferedLocationIds"].arrayObject as? NSArray{
                        self.preferedLocationIdArray = PreferedLocationIds
                        print(self.preferedLocationIdArray)
                    }
                    
                    if let PreferredLocations = responseJASON["PreferredLocations"].arrayObject as? NSArray{
                        
                        for index in 0..<PreferredLocations.count{
                            if let itemDict = PreferredLocations[index] as? NSDictionary{
                                if index == 0{
                                    preferedLocations.append("\(itemDict.value(forKey: "Name") as? String ?? "")")
                                }else{
                                    preferedLocations.append(" , \(itemDict.value(forKey: "Name") as? String ?? "")")
                                }
                                
                                
                            }
                        }
                        self.txtPreferedLocation.text = preferedLocations
                    }
                    
                    
                    if let JobTypes = responseJASON["JobTypes"].intValue as? Int{
                        self.jobType = JobTypes
                        if JobTypes == 0{
                            self.txtJobType.text = "Permanent"
                        }else if JobTypes == 1{
                            self.txtJobType.text = "Temporary"
                        }else{
                            self.txtJobType.text = "Permanent or Temporary"
                            
                        }
                    }
                    
                    if let EmploymentTypes = responseJASON["EmploymentTypes"].intValue as? Int{
                        self.EmploymentType = EmploymentTypes
                        if EmploymentTypes == 0{
                            self.txtEmployementType.text = "Full Time"
                        }else if EmploymentTypes == 1{
                            self.txtEmployementType.text = "Part Time"
                        }else{
                            self.txtEmployementType.text = "Full Time or Part Time"
                            
                        }
                    }
                    
                    if let HasWorkPermit = responseJASON["HasWorkPermit"].boolValue as? Bool{
                        self.workPermit = HasWorkPermit
                        if HasWorkPermit == true{
                            self.txtWorkPermit.text = "Yes"
                        }else{
                            self.txtWorkPermit.text = "No"
                            
                        }
                    }
                    
                    if let HasValidPassport = responseJASON["HasValidPassport"].boolValue as? Bool{
                        self.validPassport = HasValidPassport
                        if HasValidPassport == true{
                            self.txtValidPassport.text = "Yes"
                        }else{
                            self.txtValidPassport.text = "No"
                            
                        }
                    }
                    
                    if let IsValidVisa = responseJASON["IsValidVisa"].boolValue as? Bool{
                        self.validVisa = IsValidVisa
                        if IsValidVisa == true{
                            self.txtValidVisa.text = "Yes"
                        }else{
                            self.txtValidVisa.text = "No"
                            
                        }
                    }
                    
                    
                    if let NoticePeriod = responseJASON["NoticePeriod"].stringValue as? String{
                        self.txtNoticePeriod.text = NoticePeriod
                    }
                    
                    if let Role = responseJASON["Role"].dictionaryObject as? NSDictionary{
                        if let Name = Role.value(forKey: "Name") as? String{
                            self.txtJobRole.text = Name
                        }
                        
                        if let Id = Role.value(forKey: "Id") as? String{
                            self.roleId = Id
                            print(self.roleId)
                        }
                        
                    }
                    
                    if let FunctionalArea = responseJASON["FunctionalArea"].dictionaryObject as? NSDictionary{
                        
                        if let Name = FunctionalArea.value(forKey: "Name") as? String{
                            self.txtFunctionalArea.text = Name
                        }
                        
                        if let Id = FunctionalArea.value(forKey: "Id") as? String{
                            self.functionalAreaId = Id
                        }
                        
                    }
                    
                    
                    self.functionalAreaId =  String(responseJASON["CandidateFunctionalAreaId"].intValue as? Int ?? 0)
                    print(self.functionalAreaId)
                    
                    if let Industry = responseJASON["Industry"].dictionaryObject as? NSDictionary{
                        
                        if let Name = Industry.value(forKey: "Name") as? String{
                            self.txtIndustries.text = Name
                        }
                        
                        if let Id = Industry.value(forKey: "Id") as? String{
                            self.industryID = Id
                        }
                        
                    }
                    
                   
                    
                    
                    self.industryID =  String(responseJASON["CandidateIndustryId"].intValue as? Int ?? 0)
                    print(self.industryID)
                    
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
                        self.txtViewTools.text = tools
                    }
                    
                  
                    
                    if let RegionsServes = responseJASON["RegionsServes"].arrayObject as? NSArray{
                        
                        var regionServed = String()
                        
                        for index in 0..<RegionsServes.count{
                            if let itemDict = RegionsServes[index] as? NSDictionary{
                                if index == 0{
                                    regionServed.append("\(itemDict.value(forKey: "Name") as? String ?? "")")
                                }else{
                                    regionServed.append(" , \(itemDict.value(forKey: "Name") as? String ?? "")")
                                }
                                
                                
                            }
                        }
                        self.txtRegionServed.text = regionServed
                    }
                    
                    if let RegionsServeIds = responseJASON["RegionsServeIds"].arrayObject as? NSArray{
                        self.RegionsServeIdsArray = RegionsServeIds
                        print(self.RegionsServeIdsArray)
                    }
                    
                    
                    if let Certification = responseJASON["Certification"].stringValue as? String{
                        self.txtViewCertification.text = Certification
                    }
                    
                    if let DirectRepotees = responseJASON["DirectRepotees"].intValue as? Int{
                        self.directReporties = DirectRepotees
                        self.txtNoOfDirectReporties.text = "\(DirectRepotees)"
                    }
                    
                    if let IndirectRepotees = responseJASON["IndirectRepotees"].intValue as? Int{
                        self.inDirectReporties = IndirectRepotees
                        self.txtNoOfIndirectReporties.text = "\(IndirectRepotees)"
                    }
                    
                    
                    if let Tools = responseJASON["ToolIds"].arrayObject as? NSArray{
                        for tool in Tools{
                            self.toolsArray.add(tool)
                        }
                    }
                    
                    //self.toolsArray = responseJASON["ToolIds"].arrayObject as? NSMutableArray ?? []
                    
                    
                    
                    print(self.toolsArray)
                    
                    if self.RegionIdArr.count > 0 {
                        self.RegionIdArr.removeAllObjects()
                    }
                    
                    
                    if let Tools = responseJASON["RegionsServeIds"].arrayObject as? NSArray{
                        for tool in Tools{
                            self.RegionIdArr.add(tool)
                        }
                    }
                    
                    
//                    self.RegionIdArr = responseJASON["RegionsServeIds"].arrayObject as? NSMutableArray ?? [""]
                    print(self.RegionIdArr)
                    
                    self.dataForRoleSearchTap()
                    
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
            
            
            
            
          
           
            
            
            let passDict = ["DirectRepotees":String(self.txtNoOfDirectReporties.text!),
                            "EmploymentTypes":String(self.EmploymentType),
                            "HasValidPassport":self.validPassport,
                            "HasWorkPermit":self.workPermit,
                            "IndirectRepotees":String(self.txtNoOfIndirectReporties.text!),
                            "IsValidVisa":self.validVisa,
                            "JobTypes":String(self.jobType),
                            "NoticePeriod":txtNoticePeriod.text!,
                            "CandidateRoleId":String(self.roleId),
                            "CandidateFunctionalAreaId":String(self.functionalAreaId),
                            "PreferedLocationIds":self.preferedLocationIdArray,
                            "CandidateIndustryId":String(self.industryID),
                            "Certification":self.txtViewCertification.text!,
                            "TotalWorkingExperience":self.totlalWorkExp,
                            
                            "Id":userID,
                            //                            "Mobile":txtPhoneNumber.text!,
                //                            "Email":txtEmailID.text!,
                //                            "Name":txtFullName.text!,
                //                            "Phone":txtPhoneNumber.text!,
                //                            "TotalWorkingExperience":self.totlalWorkExp,
                "Bio":bio,
                "AnnualSalary":self.salaryResult,
                "Skills":self.keywordArray,
                "SkillIds":self.keywordsIDArray,
                "ToolIds":self.toolsArray,
                "RegionsServeIds":RegionIdArr] as? [String:Any]
            
            
            //            let passDict1 = ["DirectRepotees":String(self.txtNoOfDirectReporties.text!),
            //                            "EmploymentTypes":String(self.EmploymentType),
            //                            "HasValidPassport":String(self.validPassport),
            //                            "HasWorkPermit":String(self.workPermit),
            //                            "IndirectRepotees":String(self.txtNoOfIndirectReporties.text!),
            //                            "IsValidVisa":String(self.validVisa),
            //                            "JobTypes":String(self.jobType),
            //                            "NoticePeriod":txtNoticePeriod.text!,
            //                            "CandidateRoleId":String(self.roleId),
            //                            "CandidateFunctionalAreaId":String(self.functionalAreaId),
            //                            "PreferedLocationIds":self.preferedLocationIdArray,
            //                            "CandidateIndustryId":String(self.industryID),
            //                            "ToolIds":self.toolsArray,
            //                            "Certification":self.txtViewCertification.text!,
            //                            "Id":userID] as? [String:Any]
            
            
            
            print("PASSDICT", passDict)
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            print(apiname)
            print(header)
            macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURL("/\(APIName.firstGetAllHomeData)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.fillFields.rawValue, style: AlertStyle.error)
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
    
    
    
    func dataForRoleSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            passDict = ["fields":["*"],"filter":"DataType=16","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.RoleArr.removeAll()
                    self.RoleIdArr.removeAllObjects()                     //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                self.RoleArr.append(Name)
                                self.RoleIdArr.add(String(Id))
                                
                            }
                        }
                        
                        print(self.RoleIdArr)
                        self.dataForFuncitionalAreaSearchTap()
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.RoleArr)
                        print("THE ID ARRAY IS", self.RoleIdArr)
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    func dataForFuncitionalAreaSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            
            passDict = ["fields":["*"],"filter":"DataType=2","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.FuncitionalAreaArr.removeAll()
                    self.FunctionalAreaID.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                self.FuncitionalAreaArr.append(Name)
                                self.FunctionalAreaID.add(String(Id))
                                self.dropDown.reloadAllComponents()
                            }
                        }
                        self.dataForIndustrySearchTap()
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.FuncitionalAreaArr)
                        print("THE ID ARRAY IS", self.FunctionalAreaID)
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    
    func dataForIndustrySearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            
            passDict = ["fields":["*"],"filter":"DataType=1","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.IndustriesArr.removeAll()
                    self.InduStrArrId.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.dropDown.reloadAllComponents()
                                self.IndustriesArr.append(Name)
                                self.InduStrArrId.add(String(Id))
                                
                            }
                        }
                        self.dataForRegionServedSearchTap()
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.IndustriesArr)
                        print("THE ID ARRAY IS", self.InduStrArrId)
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    
    func dataForRegionServedSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            
            passDict = ["fields":["*"],"filter":"DataType=7","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.RegionArr.removeAll()
                  //  self.RegionIdArr.removeAllObjects()
                      print(responseJson)
                    
                    
                   
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                //self.RoleArr.append(Name)
                                // self.RoleIdArr.append(String(Id))
                                
                            }
                        }
                        self.dropDown.reloadAllComponents()
                        
                        print("THE NAME ARRAY IS", self.RegionArr)
                        print("THE ID ARRAY IS", self.RegionIdArr)
                        
                        self.dataToolsServedSearchTap()
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    
    func dataToolsServedSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            
            passDict = ["fields":["*"],"filter":"DataType=5","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.toolsResponseArray.removeAll()
                    self.selectedToolsArrId.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                self.toolsResponseArray.append(Name)
                                self.selectedToolsArrId.add(String(Id))
                                
                            }
                        }
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.toolsResponseArray)
                        print("THE ID ARRAY IS", self.selectedToolsArrId)
                    }
                    // self.chkBoxTbl.reloadData()
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

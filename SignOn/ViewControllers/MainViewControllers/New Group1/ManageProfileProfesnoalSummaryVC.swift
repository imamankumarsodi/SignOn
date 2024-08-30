//
//  ManageProfileProfesnoalSummaryVC.swift
//  SignOn
//
//  Created by Callsoft on 23/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView
import DropDown
import RealmSwift

class ManageProfileProfesnoalSummaryVC: UIViewController, searchData {
    
    let  appDelegateObj = UIApplication.shared.delegate as! AppDelegate
    let realm = try! Realm()
    let validation:Validation = Validation.validationManager() as! Validation
    
    //Mark: AllHeaderLabel
    
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblFunctionalArea: UILabel!
    @IBOutlet weak var lblIndustries: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var txtViewBio: RSKPlaceholderTextView!
    @IBOutlet weak var txtLack: UITextField!
    @IBOutlet weak var txtThousand: UITextField!
    @IBOutlet weak var txtJob: UITextField!
    @IBOutlet weak var txtEmployeement: UITextField!
    @IBOutlet weak var txtWorkPermitOutside: UITextField!
    @IBOutlet weak var txtValidPassport: UITextField!
    @IBOutlet weak var txtvisa: UITextField!
    @IBOutlet weak var txtPhysicalChalanged: UITextField!
    @IBOutlet weak var txtNoticePeriod: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    @IBOutlet weak var txtfunctionalArea: UITextField!
    @IBOutlet weak var txtIndustries: UITextField!
    @IBOutlet weak var txtViewToolsWorkdOn: RSKPlaceholderTextView!
    @IBOutlet weak var txtRegionServed: UITextField!
    @IBOutlet weak var txtViewCertification: RSKPlaceholderTextView!
    @IBOutlet weak var txtDirectReportise: UITextField!
    @IBOutlet weak var txtindirectReportise: UITextField!
    
    @IBOutlet weak var lackBtn: UIButton!
    @IBOutlet weak var thousandBtn: UIButton!
    @IBOutlet weak var jobtypeBtn: UIButton!
    @IBOutlet weak var employementBtn: UIButton!
    @IBOutlet weak var btnWorkPermit: UIButton!
    @IBOutlet weak var validPassportBtn: UIButton!
    @IBOutlet weak var validVisaBtn: UIButton!
    @IBOutlet weak var physicalChalangedBtn: UIButton!
    @IBOutlet weak var noticePeriodBtn: UIButton!
    @IBOutlet weak var roleBtn: UIButton!
    @IBOutlet weak var funcitionalAreaBtn: UIButton!
    @IBOutlet weak var industriesBtn: UIButton!
    @IBOutlet weak var regionBtn: UIButton!
    @IBOutlet weak var directReportiseBtn: UIButton!
    @IBOutlet weak var indirectReportiseBtn: UIButton!
    
    //Mark:- AllArray
    
    var serachType =  String()
    var salaryLackArr = [String]()
    var salarythousandArr = [String]()
    var RoleArr = [String]()
    var RoleIdArr = NSMutableArray()
    var FuncitionalAreaArr = [String]()
    var FunctionalAreaID =   NSMutableArray()
    var IndustriesArr = [String]()
    var InduStrArrId =  NSMutableArray()
    var RegionArr = [String]()
    var RegionIdArr = NSMutableArray()
    var selectedRegionArrId = NSMutableArray()
    var resutResponseArray = NSArray()
    
    var selectedToolsArrId = NSMutableArray()
    var toolsResponseArray = [String]()
    //MARK: All variable
    
    var lacksStr = Float()
    var thousandStr = Float()
    var salaryResult = Float()
    let dropDown = DropDown()
    var dropDownTag = Int()
    var jodTypeId = Int()
    var employmentId = Int()
    var indirectReportise = Int()
    var workPermit = Bool()
    var validPassword = Bool()
    var validVisa = Bool()
    var physicalChallangd = Bool()
    var roleId = String()
    var funcitionalAreaId = String()
    var industryArrId = String()
    
    
var jobTypeArr =   ["Permanent","Temporary","Permanent or Temporary"]
var empTypeArr =    ["FullTime","PartTime","FullTime or PartTime"]
var workPermitArr = ["No","Yes"]
var validVisaArr = ["Yes","No"]
var validPasPortArr = ["Yes","No"]
var physiscalChlangedArr = ["Yes","No"]
var noticePeriodArr = ["1 month","2 month","3 month"]
var DirectReportiseArr = ["DirectReporitse","B","C", "D"]
var InDirectReportiseArr = ["DirectReporitse","B","C", "D"]
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var passDict = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        salaryLacs()
        headerLbl.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Manage Profile", " Professional summary")
        UpdateUI()
        MonthThousand()
        dataForRoleSearchTap()
        dataToolsServedSearchTap()
 
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
           // print("Selected item: \(item) at index: \(index)")
            
            if self.dropDownTag == 1{
              self.txtLack.text = "\(item)"
                 let str = self.txtLack.text!
                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                self.lacksStr = Float(arr[0])
                self.salaryResult = Float(self.lacksStr + (self.thousandStr * 0.01))
                print(self.salaryResult)
                
            }
                
            else if self.dropDownTag == 2{
             self.txtThousand.text = "\(item)"
                let str = self.txtThousand.text!
                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                self.thousandStr = Float(arr[0])
                self.salaryResult = Float(self.lacksStr + (self.thousandStr * 0.01))
                print(self.salaryResult)
              }
            else if self.dropDownTag == 3{
                self.txtJob.text = "\(item)"
                self.jodTypeId = index
                print(index)
            }
            else if self.dropDownTag == 4{
                self.txtEmployeement.text = "\(item)"
                self.employmentId = index
            }
            else if self.dropDownTag == 5{
                self.txtWorkPermitOutside.text = "\(item)"
                if  self.txtWorkPermitOutside.text! == "NO"{
                    self.workPermit = false
                    }
                else{
                    self.workPermit = true
                    }
            }
            else if self.dropDownTag == 6{
                self.txtValidPassport.text = "\(item)"
               if self.txtValidPassport.text! == "NO"{
                    self.validPassword = false
                }
               else{
                self.validPassword = true
                }
             }
                
            else if self.dropDownTag == 7{
            self.txtvisa.text = "\(item)"
                if self.txtvisa.text  == "NO"{
                    self.validVisa = false
                }
                else{
                    self.validVisa = true
                }
            }
                
            else if self.dropDownTag == 8{
                self.txtPhysicalChalanged.text = "\(item)"
                if self.txtPhysicalChalanged.text == "NO"{
                    self.physicalChallangd = false
                }
                else{
                    self.physicalChallangd = true
                }
            }
                
            else if self.dropDownTag == 9{
                self.txtNoticePeriod.text = "\(item)"
            }
            else if self.dropDownTag == 10{
                self.txtRole.text = "\(item)"
                self.roleId  =  self.RoleIdArr.object(at: index) as? String ?? ""
                print("roleId31",self.roleId)
                }
                
            else if self.dropDownTag == 11{
                self.txtfunctionalArea.text = "\(item)"
                self.funcitionalAreaId  =  self.FunctionalAreaID.object(at: index) as? String ?? ""
                print("funcitionalAreaId",self.funcitionalAreaId)
            }
            else if self.dropDownTag == 12{
                self.txtIndustries.text = "\(item)"
                self.industryArrId  =  self.InduStrArrId.object(at: index) as? String ?? ""
                print("industryArrId",self.industryArrId)
            }
            else if self.dropDownTag == 13{
                self.txtRegionServed.text = "\(item)"
            }
            else if self.dropDownTag == 14{
                self.txtDirectReportise.text = "\(item)"
            }
            else if self.dropDownTag == 15{
                self.txtindirectReportise.text = "\(item)"
            }
        }
    }
    
    
    @IBAction func toolsBtnAction(_ sender: Any)
        {
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
            
            popoverContent.passDict = ["fields":["*"],"filter":"DataType=5","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
            popoverContent.isComingFromIndex = 10
            self.present(nav, animated: true, completion: nil)
            
     }
//    func searchData(selecetdNameArray: NSMutableArray, selecetdIdArray: NSMutableArray, isComingFromIndex: Int) {
//        print("selected name array",selecetdNameArray)
//        print("selected Id array",selecetdIdArray)
//        self.selectedRegionArrId = selecetdIdArray
//        print("selected MyId array",selectedRegionArrId)
//        
//        let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
//        
//        print("THE BREAK STR",breakStr)
//        self.txtViewToolsWorkdOn.text! = breakStr
//        
//    }
    
    func salaryLacs() {
        for i in 0...91{
            if i == 0{
                salaryLackArr.append("Lakhs")
            }
            else{
                salaryLackArr.append("\(i - 1) Lacs")
                print(salaryLackArr)
            }
        }
    }
    
    func MonthThousand() {
        for i in 0...91{
            if i == 0{
                salarythousandArr.append("Thousands")
            }
            else{
                salarythousandArr.append("\(i - 1) Thousands")
                print(salarythousandArr)
            }
            
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        validationSetup()
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        _ = appDel.initLoginAtLogOut()
    }
    
    @IBAction func physicalChallangedBtnAction(_ sender: Any)
    {
                dropDownTag = (sender as AnyObject).tag
                dropDown.dataSource = physiscalChlangedArr
                dropDown.anchorView = physicalChalangedBtn
                dropDown.show()
        
    }
    @IBAction func skipButtonAction(_ sender: Any) {
        
        //CODE BY AMAN
        appDelegate.initHome()
    }
    
    @IBAction func lackBtnAction(_ sender: Any) {
         dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = salaryLackArr
        dropDown.anchorView = lackBtn
        dropDown.show()
    }
    
    @IBAction func thousandBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = salarythousandArr
        dropDown.anchorView = thousandBtn
        dropDown.show()
    }
    
    @IBAction func jobtypeBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = jobTypeArr
        dropDown.anchorView = jobtypeBtn
        dropDown.show()
    }
    
    @IBAction func employementBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = empTypeArr
        dropDown.anchorView = employementBtn
        dropDown.show()
    }
    
    @IBAction func workPermitBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = workPermitArr
        dropDown.anchorView = btnWorkPermit
        dropDown.show()
    }
    
    @IBAction func validPassportAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = validPasPortArr
        dropDown.anchorView = validPassportBtn
        dropDown.show()
    }
    
    @IBAction func validVisaBtn(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = validVisaArr
        dropDown.anchorView = validVisaBtn
        dropDown.show()
    }
    
    @IBAction func noticePeriodBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = noticePeriodArr
        dropDown.anchorView = noticePeriodBtn
        dropDown.show()
    }
    @IBAction func roleBtnAction(_ sender: Any) {
      
            dropDownTag = (sender as AnyObject).tag
            dropDown.dataSource = RoleArr
            dropDown.anchorView = roleBtn
            dropDown.show()
        }
 
    
    @IBAction func funcitionalAreaAction(_ sender: Any) {
          dropDownTag = (sender as AnyObject).tag
         dropDown.dataSource = FuncitionalAreaArr
         dropDown.anchorView = funcitionalAreaBtn
         dropDown.show()
    }
    
    @IBAction func industriesBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = IndustriesArr
        dropDown.anchorView = industriesBtn
        dropDown.show()
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
    
    func searchData(selecetdNameArray: NSMutableArray, selecetdIdArray: NSMutableArray, isComingFromIndex: Int) {
        if isComingFromIndex == 1{
        print("selected name array",selecetdNameArray)
        print("selected Id array",selecetdIdArray)
        self.selectedRegionArrId = selecetdIdArray
        print("selected MyId array",selectedRegionArrId)
        
        let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
        
        print("THE BREAK STR",breakStr)
        self.txtRegionServed.text! = breakStr
        }
        else if isComingFromIndex == 10{
            print("selected name array",selecetdNameArray)
            print("selected Id array",selecetdIdArray)
            self.selectedToolsArrId = selecetdIdArray
            print("selected MyId array",selectedRegionArrId)
            
            let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
            
            print("THE BREAK STR",breakStr)
            self.txtViewToolsWorkdOn.text! = breakStr
        }
        
    }
    
    @IBAction func directReportiseAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DirectReportiseArr
        dropDown.anchorView = directReportiseBtn
        dropDown.show()
    }
    @IBAction func indirectReprtiseAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = InDirectReportiseArr
        dropDown.anchorView = indirectReportiseBtn
        dropDown.show()
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func UpdateUI(){
        lblBio.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Bio")
        lblRole.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Role")
        lblFunctionalArea.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Functional Area")
        lblIndustries.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Industries")
        
      
        
//        if let userInfo = realm.objects(LoginDataModal.self).first{
//            txtViewBio.text! = userInfo.Bio
//            txtEmployeement.text! = String(userInfo.EmploymentTypes)
//            txtWorkPermitOutside.text! = userInfo.HasWorkPermit
//            txtJob.text! =  String(userInfo.JobTypes)
//            txtValidPassport.text! = userInfo.Bio
//            txtPhysicalChalanged.text! = String(userInfo.IsPhysicallyChallenged)
//            txtNoticePeriod.text! = userInfo.NoticePeriod
//            txtRole.text! = userInfo.Role
//            txtfunctionalArea.text! = userInfo.FunctionalArea
//            txtIndustries.text! = userInfo.Industry
//            txtViewCertification.text! = userInfo.Certification
//            txtDirectReportise.text! = String(userInfo.DirectRepotees)
//            txtindirectReportise.text! = userInfo.IndirectRepotees
//
//
//
//
//
//
//
//
//
//
//        }
        
//      txtYears.text! = userInfo.Name
//        txtEmail.text!    = userInfo.Email
//        txtPhoneNumber.text! =   userInfo.Mobile
//        txtDob.text!    = userInfo.Dob
//        txtGender.text!    = String(userInfo.Gender)
        
    }

}

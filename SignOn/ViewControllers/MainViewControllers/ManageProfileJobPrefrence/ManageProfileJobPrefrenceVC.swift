//
//  ManageProfileJobPrefrenceVC.swift
//  SignOn
//
//  Created by Callsoft on 23/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import DropDown

class ManageProfileJobPrefrenceVC: UIViewController, searchData {
  
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tblEditPrefrences: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var Duplicateindex = Int()
    var keywordArray = NSMutableArray()
    var locationArray = NSMutableArray()
    var locarionArray = NSMutableArray()
    var industryArray = NSMutableArray()
    var functionalArray = NSMutableArray()
    var rolesArray = NSMutableArray()
    var salaryLackArr = [String]()
    
    
    var keywordsIDArray = NSMutableArray()
    var locationIDArray = NSMutableArray()
    var industryIDArray = NSMutableArray()
    var functionalIDArray = NSMutableArray()
    var rolesIDArray = NSMutableArray()
    var cellStr = String()
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let realm = try! Realm()
    let dropDown = DropDown()

    
    var passDict = [String:AnyObject]()
    //MARK: - VARIABLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
         Duplicateindex = 0
        salaryLacs()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableHeight?.constant = tblEditPrefrences.contentSize.height
    }
    @IBAction func skipBtnAction(_ sender: Any) {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageProfileProfesnoalSummaryVC") as! ManageProfileProfesnoalSummaryVC
        home.passDict = self.passDict
        self.navigationController?.pushViewController(home, animated: true)
    }
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        jobPreferenceAPICall()
    }
   
    //for Gender DropDown
    func salaryLacs() {
        for i in 0...50{
            if i == 0{
                salaryLackArr.append("Select Salary")
            }
            else{
                salaryLackArr.append("\(i - 1) Lacs")
                print(salaryLackArr)
            }
        }
    }
    func dropDowns() {
        
       print(salaryLackArr)
        dropDown.dataSource = salaryLackArr
        dropDown.direction = .bottom
        
        let indexPath = IndexPath(row: 2, section: 0)
        guard let cell = tblEditPrefrences.cellForRow(at: indexPath) as? EditPreferenceTableViewCellandXib else { return }
        
        dropDown.anchorView = cell.txtFieldDetails

        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
              print("Selected item: \(item) at index: \(index)")
            
            
            let text = item
            if text == "Select Salary"{
                cell.txtFieldDetails.text! = ""
            }else{
                cell.txtFieldDetails.text! = item
            }
            
         }
            self.dropDown.show()
    }
    
    
    func searchData(selecetdNameArray: NSMutableArray, selecetdIdArray: NSMutableArray, isComingFromIndex: Int) {
        
        if isComingFromIndex == 0 {
            print("Save Data in Keyword Type Array", selecetdNameArray)
            print("Save Data in Keyword Type Array", selecetdIdArray)
            self.keywordArray = selecetdNameArray
            self.keywordsIDArray = selecetdIdArray
            
            let breakStr = self.keywordArray.componentsJoined(by: " ,")  // To Show on textField
            
            let indexPath = IndexPath(row: isComingFromIndex, section: 0)
            guard let cell = tblEditPrefrences.cellForRow(at: indexPath) as? EditPreferenceTableViewCellandXib else { return }
            
            cell.txtFieldDetails.text! = breakStr
            //tblEditPrefrences.reloadData()
            self.cellStr = breakStr
            print("THE BREAK STR",breakStr)
            
        }
        else if isComingFromIndex == 1 {
            print("Save Data in location Type Array", selecetdNameArray)
            print("Save Data in location Type Array", selecetdIdArray)
            self.locarionArray = selecetdNameArray
            self.locationIDArray = selecetdIdArray
            
            let breakStr = self.locarionArray.componentsJoined(by: " ,")  // To Show on textField
            let indexPath = IndexPath(row: isComingFromIndex, section: 0)
            guard let cell = tblEditPrefrences.cellForRow(at: indexPath) as? EditPreferenceTableViewCellandXib else { return }
            
            cell.txtFieldDetails.text! = breakStr
            //tblEditPrefrences.reloadData()
            self.cellStr = breakStr
            print("THE BREAK STR",breakStr)
        }
        else if isComingFromIndex == 2 {
            print("Save Data in salary Type Array", selecetdNameArray)
            print("Save Data in salary Type Array", selecetdIdArray)
            
            //Not Required Drop Down by self No data from API or in search screen
        }
        else if isComingFromIndex == 3 {
            print("Save Data in industry Type Array", selecetdNameArray)
            print("Save Data in industry Type Array", selecetdIdArray)
            
            self.industryArray = selecetdNameArray
            self.industryIDArray = selecetdIdArray
            
            let breakStr = self.industryArray.componentsJoined(by: " ,")  // To Show on textField
            
            let indexPath = IndexPath(row: isComingFromIndex, section: 0)
            guard let cell = tblEditPrefrences.cellForRow(at: indexPath) as? EditPreferenceTableViewCellandXib else { return }
            
            cell.txtFieldDetails.text! = breakStr
            //tblEditPrefrences.reloadData()
            self.cellStr = breakStr
            print("THE BREAK STR",breakStr)
        }
        else if isComingFromIndex == 4 {
            print("Save Data in functional Type Array", selecetdNameArray)
            print("Save Data in functional Type Array", selecetdIdArray)
            
            self.functionalArray = selecetdNameArray
            self.functionalIDArray = selecetdIdArray
            
            
            let breakStr = self.functionalArray.componentsJoined(by: " ,")  // To Show on textField
            
            let indexPath = IndexPath(row: isComingFromIndex, section: 0)
            guard let cell = tblEditPrefrences.cellForRow(at: indexPath) as? EditPreferenceTableViewCellandXib else { return }
            
            cell.txtFieldDetails.text! = breakStr
            //tblEditPrefrences.reloadData()
            self.cellStr = breakStr
            print("THE BREAK STR",breakStr)
        }
        else if isComingFromIndex == 5 {
            print("Save Data in roles Type Array", selecetdNameArray)
            print("Save Data in roles Type Array", selecetdIdArray)
            
            self.rolesArray = selecetdNameArray
            self.rolesIDArray = selecetdIdArray
            
            
            let breakStr = self.rolesArray.componentsJoined(by: " ,")  // To Show on textField
            
            let indexPath = IndexPath(row: isComingFromIndex, section: 0)
            guard let cell = tblEditPrefrences.cellForRow(at: indexPath) as? EditPreferenceTableViewCellandXib else { return }
            
            cell.txtFieldDetails.text! = breakStr
            //tblEditPrefrences.reloadData()
            self.cellStr = breakStr
            print("THE BREAK STR",breakStr)
        }
    }
    
  
    
    
}

//MARK: - Custom methods extension
extension ManageProfileJobPrefrenceVC{
    //TODO: Method initialSetup
    func initialSetup(){
        headerLbl.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Manage Profile", "Job Preference")
        tblEditPrefrences.tableFooterView = UIView()
        tblEditPrefrences.reloadData()
    }
    
    func updateTableViewCell(index:Int,cell:EditPreferenceTableViewCellandXib)->UITableViewCell{
        if index == 0{
            Duplicateindex = index
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = true
            cell.dropDownBtn.setImage(UIImage(named: ""), for: .normal)
            cell.imgView.image = #imageLiteral(resourceName: "_user_man_profile")
            cell.lblTitle.text = "Keywords"
            cell.txtFieldDetails.text = ""
            cell.dropDownBtn.isHidden = false
            cell.dropDownBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)

        }else if index == 1{
            Duplicateindex = index
            cell.dropDownBtn.tag = index
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = true
            cell.dropDownBtn.setImage(UIImage(named: ""), for: .normal)
            cell.imgView.image = #imageLiteral(resourceName: "_map_location")
            cell.lblTitle.text = "Location"
            cell.txtFieldDetails.text = ""
            cell.dropDownBtn.isHidden = false
            cell.dropDownBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
         }
        else if index == 2{
            Duplicateindex = index
             cell.dropDownBtn.tag = index
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.isHidden = false
             cell.imgView.image = #imageLiteral(resourceName: "minimum_salary")
            cell.lblTitle.text = "Minimum Salary"
            cell.txtFieldDetails.text = ""
             cell.dropDownBtn.semanticContentAttribute = .forceRightToLeft
             cell.dropDownBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
        }else if index == 3{
            Duplicateindex = index
            cell.dropDownBtn.tag = index
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.setImage(UIImage(named: ""), for: .normal)
            cell.dropDownBtn.isHidden = false
            cell.imgView.image = #imageLiteral(resourceName: "university")
            cell.lblTitle.text = "Industry"
            cell.txtFieldDetails.text = ""
             cell.dropDownBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
        }else if index == 4{
            Duplicateindex = index
             cell.dropDownBtn.tag = index
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.setImage(UIImage(named: ""), for: .normal)
            cell.dropDownBtn.isHidden = false
            cell.imgView.image = #imageLiteral(resourceName: "target_icon")
            cell.lblTitle.text = "Functional Area"
            cell.txtFieldDetails.text = ""
            cell.dropDownBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
        }else if index == 5{
            Duplicateindex = index
             cell.dropDownBtn.tag = index
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.setImage(UIImage(named: ""), for: .normal)
            cell.dropDownBtn.isHidden = false
            cell.imgView.image = #imageLiteral(resourceName: "_office_bag")
            cell.lblTitle.text = "Roles"
            cell.txtFieldDetails.text = ""
            cell.dropDownBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
        }
        return cell
    }
      @objc func checkBoxSelection(_ sender:UIButton) {
         print(sender.tag)
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "SearchTabViewController") as! SearchTabViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
         popover!.sourceView = self.view
        popoverContent.searchDataDelegate = self
        if sender.tag == 0 {
            popoverContent.passDict = ["fields":["*"],"filter":"DataType=4","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
            popoverContent.isComingFromIndex = 0
              self.present(nav, animated: true, completion: nil)
        }
        else if sender.tag == 1{
            popoverContent.passDict = ["fields":["*"],"filter":"DataType=7","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
            popoverContent.isComingFromIndex = 1
              self.present(nav, animated: true, completion: nil)
        }
        else if sender.tag == 2 {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblEditPrefrences.dequeueReusableCell(withIdentifier: "EditPreferenceTableViewCellandXib", for: indexPath) as? EditPreferenceTableViewCellandXib else {
                return
            }
            
            dropDowns()
          }
            
        else if sender.tag == 3  {
            popoverContent.passDict = ["fields":["*"],"filter":"DataType=1","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
            popoverContent.isComingFromIndex = 3
            self.present(nav, animated: true, completion: nil)
        }
        else if sender.tag == 4  {
            popoverContent.passDict = ["fields":["*"],"filter":"DataType=2","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
            popoverContent.isComingFromIndex = 4
            self.present(nav, animated: true, completion: nil)
        }
        else if sender.tag == 5  {
            popoverContent.passDict = ["fields":["*"],"filter":"DataType=16","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
            popoverContent.isComingFromIndex = 5
            self.present(nav, animated: true, completion: nil)
        }
        
        // popover!.sourceRect = CRectMake(100,100,0,0)
      
    }
 }

//Mark: Popover ButtonAction

//MARK: - TableView dataSource and delegates extension

extension ManageProfileJobPrefrenceVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblEditPrefrences.register(UINib(nibName: "EditPreferenceTableViewCellandXib", bundle: nil), forCellReuseIdentifier: "EditPreferenceTableViewCellandXib")
        let cell = tblEditPrefrences.dequeueReusableCell(withIdentifier: "EditPreferenceTableViewCellandXib", for: indexPath) as! EditPreferenceTableViewCellandXib
        return updateTableViewCell(index: indexPath.row,cell: cell)
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableHeight?.constant = tblEditPrefrences.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ManageProfileJobPrefrenceVC {
    
    
    func jobPreferenceAPICall() {
        
            if InternetConnection.internetshared.isConnectedToNetwork() {
                
                var token = String()
                var userID =  String()
                var phone = String()
                var name = String()
                var email = String()
                var address = String()
 
                if let userInfo = realm.objects(LoginDataModal.self).first{
                    token = userInfo.token
                    userID = userInfo.Id
                    phone = userInfo.Mobile
                    name = userInfo.Name
                    email = userInfo.Email
                    address = userInfo.Address
                    print(address)
                }
                
                
                
                
                
                
                let passDict = ["Keywords":self.keywordArray,
                                "Mobile":phone,
                                "PreferedFunctionalAreaIds":self.functionalIDArray,
                                "PreferedIndustryIds":self.industryIDArray,
                                "PreferedKeywordIds":self.keywordsIDArray,
                                "PreferedLocationIds":self.locationIDArray,
                                "PreferedRoleIds":self.rolesIDArray,
                                "PreferredFunctionalAreas":self.functionalArray,
                                "PreferredIndustries":self.industryArray,
                                "PreferredLocations":self.locarionArray,
                                "PreferredRoles":self.rolesArray,
                                "Email": email,
                                "IsPhoneVerified":true,
                                "Name":name,
                                "Phone":phone,
                                "UserName": phone,
                                "Id":userID] as [String: AnyObject]
                print("PASSDICT", passDict)
                let header = [
                    // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                    "Content-Type": "application/json; charset=utf-8",
                    "Authorization" : "Bearer \(token)"
                ]
                macroObj.showLoader(view: self.view)
                alamObject.postRequestURL("\(APIName.firstGetAllHomeData)/\(userID)/preferences", params: passDict, headers: header, success: { (responseJson,responseCode) in
                    print(responseJson)
                    print(responseCode)
                    if responseCode == 200{
                        self.macroObj.hideLoader()

                      print(self.passDict)
                        

                        
                        
                        self.passDict["PreferedFunctionalAreaIds"] = self.functionalIDArray
                        self.passDict["PreferedIndustryIds"] = self.industryIDArray
                        self.passDict["PreferedKeywordIds"] = self.keywordsIDArray
                        self.passDict["PreferedLocationIds"] = self.locationIDArray
                        self.passDict["PreferedRoleIds"] = self.rolesIDArray
                        self.passDict["PreferredFunctionalAreas"] = self.functionalArray
                        self.passDict["PreferredIndustries"] = self.industryArray
                        self.passDict["PreferredLocations"] = self.locarionArray
                        self.passDict["PreferredRoles"] = self.rolesArray
                        
                        print(self.passDict)
                        self.JobseekarManageProfileApiMethod()
                        
                        
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
            
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            print(apiname)
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(apiname)/\(userID)", params: self.passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageProfileProfesnoalSummaryVC") as! ManageProfileProfesnoalSummaryVC
                    home.passDict = self.passDict
                    self.navigationController?.pushViewController(home, animated: true)
                    
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

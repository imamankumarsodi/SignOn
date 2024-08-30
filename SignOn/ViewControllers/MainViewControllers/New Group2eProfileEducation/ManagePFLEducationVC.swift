//
//  ManagePFLEducationVC.swift
//  SignOn
//
//  Created by Callsoft on 23/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import DropDown

class ManagePFLEducationVC: UIViewController {
    
    //Mark: AllHeading Label
    
    
    @IBOutlet weak var headerLBL: UILabel!
    @IBOutlet weak var heighestLabel: UILabel!
    @IBOutlet weak var instiutionLbael: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var courseTypeLabel: UILabel!
    @IBOutlet weak var specilizationLbael: UILabel!
    @IBOutlet weak var passingYear: UILabel!
    
    //Mark:- AllOutlet
    
    @IBOutlet weak var txtSelectQualification: UITextField!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var txtInstitution: UITextField!
    @IBOutlet weak var txtDegree: UITextField!
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var txtSpecilization: UITextField!
    @IBOutlet weak var specilizationBtn: UIButton!
    @IBOutlet weak var txtCourse: UITextField!
    @IBOutlet weak var btnCourse: UIButton!
    @IBOutlet weak var txtPassing: UITextField!
    @IBOutlet weak var passingBtn: UIButton!
    
    //Mark:- All Array
    
    
    var qualiNameArray = [String]()
    var qualiIdArray = [String]()
    var qualiIndex = Int()
    
    var degNameArray = [String]()
    var degIdArray = [String]()
    var degIndex = Int()
    
    var speNameArray = [String]()
    var speIdArray = [String]()
    var speIndex = Int()
    
    var courseNameArray = [String]()
    var courseIdArray = [String]()
    var courseIndex = Int()
    
    
    let validation:Validation = Validation.validationManager() as! Validation
    
    
    
    
    
    //Mark:- All VAriables
    
    let realm = try! Realm()
    let dropDown = DropDown()
    var dropDownTag = Int()
    
    let dataLinq = Eductaion()
    var dropDownArray = [DropDownStruct]()
    var DegrreeDownArray = [DropDownStruct]()
    
    
    let dataLinqup = Degree()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    
    
    var passDict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        dropDownArray = dataLinq.prepareDropDown()
        DegrreeDownArray = dataLinqup.prepareDropDown()
        
        
        headerLBL.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Manage Profile", "Education")
        
        
        getDropDownForSearchQualification()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            
            if self.dropDownTag == 1{
                self.txtSelectQualification.text = item
                self.qualiIndex = index
            }
                
            else if self.dropDownTag == 2{
                
                self.txtDegree.text = item
                self.degIndex = index
            }
            else if self.dropDownTag == 3{
                self.txtSpecilization.text = "\(item)"
                self.speIndex = index
                
            }
            else if self.dropDownTag == 4{
                self.txtCourse.text = "\(item)"
                self.courseIndex = index
                
            }
            else if self.dropDownTag == 5{
                self.txtPassing.text = "\(item)"
                
            }
        }
    }
    
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectBtnAction(_ sender: UIButton) {
        
        
        dropDownTag = 1
        dropDown.dataSource = returnArrayStrigDropDownArray(dropDownArray:dropDownArray)
        dropDown.anchorView = selectBtn
        dropDown.direction = .bottom
        dropDown.show()
        
    }
    func returnArrayStrigDropDownArray(dropDownArray:[DropDownStruct])->[String]{
        var stringArray = [String]()
        for item in dropDownArray{
            print(item.text)
            stringArray.append(item.text)
        }
        return stringArray
    }
    
    @IBAction func courseBtnAction(_ sender: Any) {
        dropDownTag = 4
        dropDown.dataSource = courseNameArray
        dropDown.anchorView = btnCourse
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func degreeCourseBtnAction(_ sender: Any) {
        
        dropDownTag = 2
        dropDown.dataSource = degNameArray
        dropDown.anchorView = degreeBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func specilizationBtnAction(_ sender: Any) {
        dropDownTag = 3
        dropDown.dataSource = speNameArray
        dropDown.anchorView = specilizationBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func passingYerarBtnAction(_ sender: Any) {
        dropDownTag = 5
        dropDown.dataSource = DropDowns.shared.preparePassingYear()
        dropDown.anchorView = passingBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        print("Print Save")
        
        self.validationSetup()
        
        
        
    }
    
    
    
    func UpdateUI(){
        heighestLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Highest Qualification")
        instiutionLbael.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Institution")
        degreeLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Degree/Course")
        specilizationLbael.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Specialization")
        courseTypeLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Course Type")
        passingYear.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Passing Year")
        
        if let userInfo = realm.objects(EducationModalExtension.self).first{
            txtCourse.text = userInfo.CourseName
            txtSelectQualification.text    = userInfo.DegreeName
            
            txtInstitution.text! =   userInfo.InstitutionName
            txtDegree.text!    = userInfo.DegreeName
            txtSpecilization.text!    = userInfo.SpecialisationName
            txtCourse.text!    = userInfo.CourseName
            txtPassing.text!    = userInfo.CoursePassingYear
            
        }
     }
    
    
    
    // TODO: Validations for all input fields
    
    func validationSetup()->Void{
        
        var message = ""
        if !validation.validateBlankField(txtSelectQualification.text!){
            message = MacrosForAll.VALIDMESSAGE.selectQualification.rawValue
        }else if !validation.validateBlankField(txtInstitution.text!){
            message = MacrosForAll.VALIDMESSAGE.enterInstitution.rawValue
        }else if !validation.validateBlankField(txtDegree.text!){
            message = MacrosForAll.VALIDMESSAGE.selectDegree.rawValue
        }else if !validation.validateBlankField(txtSpecilization.text!){
            message = MacrosForAll.VALIDMESSAGE.selectSpecializion.rawValue
        }else if !validation.validateBlankField(txtCourse.text!){
            message = MacrosForAll.VALIDMESSAGE.selectCourseType.rawValue
        }else if !validation.validateBlankField(txtPassing.text!){
            message = MacrosForAll.VALIDMESSAGE.selectPassingYear.rawValue
        }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            saveCandidateData()
        }
    }
    
}


//MARK: - Extension API integration
extension ManagePFLEducationVC{
    
    
    
    
    func getDropDownForSearchQualification(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
 
            let passDict = ["fields":["*"],"filter":"DataType=9","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                  self.macroObj.hideLoader()
                    print(responseJson)
                    
                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
                        for item in dataArr{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.qualiNameArray.append(Name)
                                self.qualiIdArray.append(String(Id))
                                
                            }
                        }
                    }
                    print(self.qualiNameArray)
                    print(self.qualiIdArray)
                    self.getDropDownForSearchTapDegree()
                    
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
    
    
    
    
    
    
    func getDropDownForSearchTapDegree(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["fields":["*"],"filter":"DataType=10","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            
           macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                 self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                   self.macroObj.hideLoader()
                    print(responseJson)
                    
                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
                        for item in dataArr{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.degNameArray.append(Name)
                                self.degIdArray.append(String(Id))
                                
                            }
                        }
                    }
                    
                    print(self.degNameArray)
                    print(self.degIdArray)
                    self.getDropDownForSearchTapSpecialization()
                    
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
    
    
    func getDropDownForSearchTapSpecialization(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["fields":["*"],"filter":"DataType=11","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            
           macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
               self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJson)
                    
                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
                        for item in dataArr{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.speNameArray.append(Name)
                                self.speIdArray.append(String(Id))
                                
                            }
                        }
                    }
                    print(self.speNameArray)
                    print(self.speIdArray)
                    self.getDropDownForSearchTapCourseType()
                    
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
    
    
    
    func getDropDownForSearchTapCourseType(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["fields":["*"],"filter":"DataType=12","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJson)
                    
                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
                        for item in dataArr{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.courseNameArray.append(Name)
                                self.courseIdArray.append(String(Id))
                                
                            }
                        }
                    }
                    
                    print(self.courseNameArray)
                    print(self.courseIdArray)
                    
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
    
    
    
    
    
    func saveCandidateData(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }

            
            let passDict = ["CandidateId":userID,
                            "CourseId":courseIdArray[courseIndex],
                            "DegreeId":degIdArray[degIndex],
                            "Id":0,
                            "InstitutionName":txtInstitution.text!,
                            "PassingYear":self.txtPassing.text!,
                            "QualificationId":self.qualiIdArray[courseIndex],
                            "SpecialisationId":self.speIdArray[speIndex]] as! [String:AnyObject]
            
            
            print(passDict)
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.firstGetAllHomeData)/\(userID)/educations", params: passDict, headers: header, success: { (responseJson,responseCode) in
                // self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    print(responseJson)
                    
                    
                
                    
                    let manageProfile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmploymentManageProfileVC") as! EmploymentManageProfileVC
                    manageProfile.passDict = self.passDict
                    self.navigationController?.pushViewController(manageProfile, animated: true)
                    
                    
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

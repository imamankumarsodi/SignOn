//
//  BasicDetailsVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import DropDown

class BasicDetailsVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var txtThousands: UITextField!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtLacks: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmailID: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var lackBtn: UIButton!
    @IBOutlet weak var thousandBtn: UIButton!
    
    
    var bio = String()
    
    var imageData  = NSData()
    var cameraValue = Int()
    let realm = try! Realm()
    let dropDown = DropDown()
    var dropDownTag = Int()
    var itemIndex = Int()
    var monthArr: [String] = ["Start Month","1","2","3","4","5","6","7","8","9","10","11","12"]
    var monthIdArr = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    var salaryLackArr = [String]()
    var salarythousandArr = [String]()
    var lacksStr = Float()
    var thousandStr = Float()
    var salaryResult = Float()
    var imagePicker = UIImagePickerController()
    var filename = String()
    var totlalWorkExp = Int()
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    
    
    
    var directRepo = String()
    var IndirectRepo = String()
    var EmploymentTypes = Int()
    var valPass = Bool()
    var workPermit = Bool()
    var valVisa = Bool()
    var jobType = Int()
    var NoticePeriod = String()
    var roleId = String()
    var functionalAreaId = String()
    var preferedLocationIdArray = NSArray()
    var industryID = String()
    var toolsArray = NSArray()
    var txtViewCertification = String()
    var keywordsIDArray = NSMutableArray()
    var RegionsServeIdsArray = NSArray()
   // var RegionIdArr = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
        print(bio)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if self.dropDownTag == 1{
                self.txtYear.text = "\(item)"
            }
                
            else if self.dropDownTag == 2{
                self.txtMonth.text = "\(item)"
                self.itemIndex = index
                
            }else if self.dropDownTag == 3{
                self.txtLacks.text = "\(item)"
                let str = self.txtLacks.text!
                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                self.lacksStr = Float(arr[0])
                self.salaryResult = Float((self.lacksStr*100000) + ((self.thousandStr * 0.01)*1000))
                print(self.salaryResult)
               
                
            }
                
            else if self.dropDownTag == 4{
                self.txtThousands.text = "\(item)"
                let str = self.txtThousands.text!
                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                self.thousandStr = Float(arr[0])
                self.salaryResult = Float((self.lacksStr*100000) + ((self.thousandStr)*1000))
                print(self.salaryResult)
            }
        }
        
    }
    

    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnProfilePiTapped(_ sender: Any) {
        
    }
    
    
    
    @IBAction func yaerBtnAction(_ sender: Any) {
        dropDownTag = 1
        dropDown.dataSource = DropDowns.shared.prepareExperienceYear()
        dropDown.anchorView = yearBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func monthBtnAction(_ sender: Any) {
        dropDownTag = 2
        dropDown.dataSource =  monthArr
        dropDown.anchorView =  monthBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func lackBtnAction(_ sender: Any) {
        dropDownTag = 3
        dropDown.dataSource = salaryLackArr
        dropDown.anchorView = lackBtn
        dropDown.show()
    }
    
    @IBAction func thousandBtnAction(_ sender: Any) {
        dropDownTag = 4
        dropDown.dataSource = salarythousandArr
        dropDown.anchorView = thousandBtn
        dropDown.show()
    }
    @IBAction func uploadImageAction(_ sender: Any) {
        showImagePicker()
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        validationSetup()
    }
    
}


extension BasicDetailsVC{
    func initialSetup(){
        if let userInfo = realm.objects(LoginDataModal.self).first{
            txtFullName.text = userInfo.Name
            txtEmailID.text = userInfo.Email
            txtPhoneNumber.text = userInfo.Mobile
            if let totalExperience = Int(userInfo.TotalWorkingExperience) as? Int{
                txtYear.text = "\(totalExperience/12) Year"
                txtMonth.text = "\(totalExperience%12) Month"
            }
            if let AnnualSalary = userInfo.AnnualSalary as? Int{
                salaryResult = Float(AnnualSalary)
                txtLacks.text = "\(AnnualSalary/100000) Lakhs"
                txtThousands.text = "\((AnnualSalary%100000)/1000) Thousands"
            }
            self.imgProfile.sd_setImage(with: URL(string: userInfo.Url), placeholderImage: UIImage(named: "groupicon"))
        }
        salaryLacs()
        MonthThousand()
        appliedJobsAPI()
    }
    
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
    
    //////////////////-------------------------------------------------->>>>>>>>>>>>>>>>>>>>
    
    //Mark: ImagePickerMethod Here
    
    
    func camera(){
        
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
            cameraValue = 1
            
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func photoLibrary() {
        cameraValue = 0
        //        imagePicker.sourceType = .photoLibrary
        //        present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func showImagePicker(){
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.camera()
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.photoLibrary()
                
            }))
            
        }else {
            
            actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.photoLibrary()
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title:"Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad{
            
            let popup = UIPopoverController(contentViewController: actionSheet)
            
            popup.present(from: CGRect(), in: self.view!, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
            
        }else{
            
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]) {
        
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if cameraValue == 1{
            var selectedImage: UIImage!
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = image
                if (picker.sourceType == UIImagePickerController.SourceType.camera) {
                    imageData = selectedImage.jpegData(compressionQuality: 0.5)!  as NSData
                    UserDefaults.standard.set(imageData, forKey: "IMG_DATA")
                    let imgName = UUID().uuidString
                    let documentDirectory = NSTemporaryDirectory()
                    let localPath = documentDirectory.appending(imgName)
                    imageData.write(toFile: localPath, atomically: true)
                    let photoURL = URL.init(fileURLWithPath: localPath).lastPathComponent
                    let theFileName = URL(fileURLWithPath: #file).lastPathComponent
                    filename = photoURL
                    print(photoURL)
                  //  profileImgPath.text = "Profile Image\n\(photoURL)"
                    cameraValue = 0
                }
            }
        }else{
            
            if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageData = chosenImage.jpegData(compressionQuality: 0.5)!  as NSData
                UserDefaults.standard.set(imageData, forKey: "IMG_DATA")
                let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                print(imageURL)
                let path = imageURL.path!
                filename = path
             //   profileImgPath.text = "Profile Image\n\(path)"
                print("path of image is",path)
            } else{
                print("Something went wrong")
            }
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //Mark: SaveActionApiCall
    
    /////////////------------------------------------------------------>>>>>>>>>>>>>>>>>>
    
    //MArk: MentorMangaeProfileApiCall
    
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
            
            if self.txtYear.text != ""{
                self.totlalWorkExp = (Int(self.txtYear.text!) ?? 0)*12 + (Int(self.txtMonth.text!) ?? 0)
            }
            
          //  self.totlalWorkExp = (self.yearId)*12 + self.monthId
            
            if self.totlalWorkExp == 0{
                if let userInfo = realm.objects(LoginDataModal.self).first{
                    totlalWorkExp = Int(userInfo.TotalWorkingExperience) ?? 0
                }
               
            }
            
            print(self.totlalWorkExp)
            
            if txtLacks.text! != ""{
                
            }
            
            
//            let passDict = ["DirectRepotees":String(self.txtNoOfDirectReporties.text!),
//                            "EmploymentTypes":self.EmploymentType,
//                            "HasValidPassport":self.validPassport,
//                            "HasWorkPermit":self.workPermit,
//                            "IndirectRepotees":String(self.txtNoOfIndirectReporties.text!),
//                            "IsValidVisa":self.validVisa,
//                            "JobTypes":self.jobType,
//                            "NoticePeriod":txtNoticePeriod.text!,
//                            "CandidateRoleId":self.roleId,
//                            "CandidateFunctionalAreaId":self.self.functionalAreaId,
//                            "PreferedLocationIds":self.preferedLocationIdArray,
//                            "CandidateIndustryId":self.industryID,
//                            "ToolIds":self.toolsArray,
//                            "Certification":self.txtViewCertification.text!,
//                            "Id":userID] as? [String:AnyObject]

            
            
            
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
                            "Mobile":txtPhoneNumber.text!,
                            "Email":txtEmailID.text!,
                            "Name":txtFullName.text!,
                            "Phone":txtPhoneNumber.text!,
                            "TotalWorkingExperience":self.totlalWorkExp,
                            "Bio":bio,
                            "AnnualSalary":self.salaryResult,
                            "SkillIds":self.keywordsIDArray,
                            "RegionsServeIds":RegionsServeIdsArray] as? [String:Any]

            
            
    
            
            
            
            print("PASSDICT", passDict)
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            print(apiname)
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("/candidates/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    do{
                        try self.realm.write {
                            if let user = self.realm.objects(LoginDataModal.self).first{
                                user.Name = self.txtFullName.text!
                                user.Email = self.txtEmailID.text!
                                user.Mobile = self.txtPhoneNumber.text!
                                user.TotalWorkingExperience = String(self.totlalWorkExp)
                                user.AnnualSalary = Int(self.salaryResult)
                                
                                self.navigationController?.popViewController(animated: true)
                            }
                            
                        }
                    }catch{
                        print("Error in saving data :- \(error.localizedDescription)")
                    }
                    
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
    
    
    func validationSetup()->Void {
        var message = ""
        if !validation.validateBlankField(txtFullName.text!){
            
            message = MacrosForAll.VALIDMESSAGE.EnterFullName.rawValue
            
        }else if !validation.validateBlankField(txtEmailID.text!){
            
            message = MacrosForAll.VALIDMESSAGE.EmailAddressNotBeBlank.rawValue
            
        }else if !validation.validateEmail(txtEmailID.text!){
    
            message = MacrosForAll.VALIDMESSAGE.EnterValidEmail.rawValue
    
        }else if !validation.validateBlankField(txtPhoneNumber.text!){
            
            message = MacrosForAll.VALIDMESSAGE.EnterMobileNumber.rawValue
            
        }
       
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            
            
            
            JobseekarManageProfileApiMethod()
        }
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
            alamObject.getRequestURL("/candidates/\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    var rname = String()
                    print(responseJASON)
                    
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
                
                    
                    self.industryID =  String(responseJASON["CandidateIndustryId"].intValue as? Int ?? 0)
                    print(self.industryID)
                    
                    if self.industryID == "0"{
                        self.industryID = ""
                    }
                    
//                    if self.toolsArray.count > 0{
//                        self.toolsArray.removeAllObjects()
//                    }
//
                    
                    if let Tools = responseJASON["Tools"].arrayObject as? NSArray{
                        
                        var tools = String()
                        
                        for index in 0..<Tools.count{
                            if let itemDict = Tools[index] as? NSDictionary{
                                
                             //   self.toolsArray.add(itemDict.value(forKey: "Id") as? Int ?? 0)
                                
                                
                                if index == 0{
                                    tools.append("\(itemDict.value(forKey: "Name") as? String ?? "")")
                                }else{
                                    tools.append(" , \(itemDict.value(forKey: "Name") as? String ?? "")")
                                }
                                
                                
                                
                            }
                        }
                     
                    }
                    
                    
                    
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
                                
                                self.imgProfile.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "groupicon"))
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
                    
                    if self.roleId == "0"{
                        self.roleId = ""
                    }
                    
                    print(self.roleId)
                    
                  
                    self.functionalAreaId =  String(responseJASON["CandidateFunctionalAreaId"].intValue as? Int ?? 0)
                    
                    if self.functionalAreaId == "0"{
                        self.functionalAreaId = ""
                    }
                    
                    print(self.functionalAreaId)
                    
                    
                   
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
                    
                  
                    
                    if let RegionsServeIds = responseJASON["RegionsServeIds"].arrayObject as? NSArray{
                        self.RegionsServeIdsArray = RegionsServeIds
                        print(self.RegionsServeIdsArray)
                    }
                    
                    let workPermit = responseJASON["HasWorkPermit"].boolValue as?  Bool ?? false
                    self.workPermit = workPermit
                   
                    
                    
                    let valPass = responseJASON["HasValidPassport"].boolValue as?  Bool ?? false
                    self.valPass = valPass
                    print(self.valPass)
                   
                  
                    
                    let valVisa = responseJASON["IsValidVisa"].boolValue as?  Bool ?? false
                    
                    self.valVisa = valVisa
                    
                    self.IndirectRepo = responseJASON["IndirectRepotees"].stringValue as? String ?? ""
                    
                    
                   self.directRepo = responseJASON["DirectRepotees"].stringValue as? String ?? ""
                    
                    
                  
                 
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
                    
                   self.toolsArray = responseJASON["ToolIds"].arrayObject as? NSArray ?? [""]
                    print(self.toolsArray)
                    
                    self.RegionsServeIdsArray = responseJASON["RegionsServeIds"].arrayObject as? NSArray ?? [""]
                    print(self.RegionsServeIdsArray)
                   
                    self.macroObj.hideLoader()
                    
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
    
}


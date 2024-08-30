//
//  MentorBasicProfileVC.swift
//  SignOn
//
//  Created by Callsoft on 13/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import DropDown

class MentorBasicProfileVC: UIViewController {
    
    let dataLinq = DesignationDropDown()
    let dropDown = DropDown()
    var dropDownTag = Int()
    var dropDownArray = [DropDownStruct]()
    var id = String()
    let realm = try! Realm()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    
    var designationID = String()
    var imageData  = NSData()
    var cameraValue = Int()
    var imagePicker = UIImagePickerController()
    var filename = String()
    
    var totalWorkingExperience = Int()
    var InduStrArrId = NSMutableArray()
    var professionalSummary = String()
    var userName = String()
    var yearVariable = Int()
    var monthVariable = Int()
    
    //Mark: AllOulet
    
    @IBOutlet weak var desingnationBtn: UIButton!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var txt_Desingnation: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    
    @IBOutlet weak var txtDesignationName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownArray = dataLinq.prepareDropDown()
        // Do any additional setup after loading the view.
        getMentorApiJobs()
    }
    
    
    //Mark: ViewWiilAppearMethod
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            
            if self.dropDownTag == 0{
                self.txt_Desingnation.text = item
                self.id = self.dropDownArray[index].id
                self.designationID = self.dropDownArray[index].id
            }
            else if self.dropDownTag == 2{
                self.txtYear.text = "\(item)"
                let str = self.txtYear.text!
                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                let yearvar = Int(arr[0])
                self.yearVariable = (yearvar * 12)
                print( self.yearVariable)
            }
            else if self.dropDownTag == 3{
                self.txtMonth.text = "\(item)"
                let str = self.txtMonth.text!
                let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                let month = Int(arr[0])
                self.monthVariable = month
                
            }
        }
    }
    
    func returnArrayStrigDropDownArray(dropDownArray:[DropDownStruct])->[String]{
        var stringArray = [String]()
        for item in dropDownArray{
            print(item.text)
            stringArray.append(item.text)
        }
        return stringArray
    }
    
    
    //Mark:AllBtnAction
    
    @IBAction func desingnationBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = returnArrayStrigDropDownArray(dropDownArray:dropDownArray)
        dropDown.anchorView = desingnationBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func yearBtnAction(_ sender: Any) {
        dropDownTag = 2
        dropDown.dataSource = DropDowns.shared.prepareYearDropDown()
        dropDown.anchorView = txtYear
        // dropDown.direction = .bottom
        dropDown.show()
    }
    
    
    @IBAction func backBtn_Action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraTapped(_ sender: UIButton) {
        
        showImagePicker()
        
    }
    
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        validationSetup()
    }
    
    @IBAction func monthBtnAction(_ sender: Any) {
        dropDownTag = 3
        dropDown.dataSource = DropDowns.shared.prepareMonthDropDown()
        dropDown.anchorView = monthBtn
        dropDown.show()
    }
}



extension MentorBasicProfileVC{
    
    
    func validationSetup()->Void {
        var message = ""
        if !validation.validateBlankField(txtName.text!){
            
            message = MacrosForAll.VALIDMESSAGE.EnterFullName.rawValue
            
        }else if !validation.validateBlankField(txtEmail.text!){
            
            message = MacrosForAll.VALIDMESSAGE.EmailAddressNotBeBlank.rawValue
            
        }else if !validation.validateEmail(txtEmail.text!){
            
            message = MacrosForAll.VALIDMESSAGE.EnterValidEmail.rawValue
            
        }
        
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            
            saveManageProfile()
            
            //  JobseekarManageProfileApiMethod()
        }
    }
    
    
    func getMentorApiJobs() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
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
            alamObject.getRequestURL( "\(APIName.mentor)/\(userID)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    
                    print(responseJASON)
                    if let dataArr = responseJASON.dictionaryObject as NSDictionary?{
                        self.macroObj.hideLoader()
                        print(dataArr)
                        
                        if let name = dataArr.value(forKey: "Name") as? String{
                            self.txtName.text = name
                        }
                        
                        if let email = dataArr.value(forKey: "Email") as? String{
                            self.txtEmail.text = email
                        }
                        
                        if let companyName = dataArr.value(forKey: "CompanyName") as? String{
                            self.txtCompanyName.text = companyName
                        }
                        
                        if let designationDict = dataArr.value(forKey: "Designation") as? NSDictionary{
                            if let designationName = designationDict.value(forKey: "Name") as? String{
                                self.txt_Desingnation.text = designationName
                            }
                            if let designationID = designationDict.value(forKey: "Id") as? String{
                                self.designationID = designationID
                            }
                            
                            if let designationID = designationDict.value(forKey: "Id") as? Int{
                                self.designationID = String(designationID)
                            }
                            
                            
                            
                        }
                        
                        if let totalWorkingExperience = dataArr.value(forKey: "TotalWorkingExperience") as? Int{
                            self.totalWorkingExperience = totalWorkingExperience
                            self.yearVariable = totalWorkingExperience/12
                            self.monthVariable = totalWorkingExperience%12
                            self.txtYear.text = "\(totalWorkingExperience/12) years"
                            self.txtMonth.text = "\(totalWorkingExperience%12) months"
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
                        }
                        
                        if let UserName = dataArr.value(forKey: "UserName") as? String{
                            self.userName = UserName
                        }
                        
                    }
                    
                }else{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                }
                
            },
                                      failure: { (error,responseCode) in
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
            
            self.totalWorkingExperience = self.yearVariable + self.monthVariable
            let totalWorkExp = "\(self.totalWorkingExperience)"
            
            print(totalWorkExp)
            let passDict = ["CompanyName":txtCompanyName.text!,
                            "DesignationId":self.designationID,
                            "Email":txtEmail.text!,
                            "Industries":[],
                            "IndustryId":0,
                            "IndustryIds":InduStrArrId,
                            "Name":txtName.text!,
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


extension MentorBasicProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
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
}

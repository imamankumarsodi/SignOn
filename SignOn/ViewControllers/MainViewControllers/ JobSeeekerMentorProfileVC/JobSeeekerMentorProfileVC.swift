//
//  JobSeeekerMentorProfileVC.swift
//  SignOn
//
//  Created by Callsoft on 15/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

var userProfileName = String()
var userProfile = String()

import UIKit
import DropDown
import RealmSwift
import MobileCoreServices
import DatePickerDialog
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import LinkedinSwift
import SwiftyJSON

class JobSeeekerMentorProfileVC: UIViewController,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var profileImgPath: UILabel!
    @IBOutlet weak var resumePathLbl: UILabel!
    
    
    let appDelegateObj = UIApplication.shared.delegate as! AppDelegate
    var registerDataFromReg = [String:AnyObject]()
    var filename = String()
    
    var resumeName = String()
    private let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: "81c57y2bn7ybub", clientSecret: "Qv6ztuUYHoeoe0Aq", state: "DLKDJF46ikMMZADfdfds", permissions: ["r_liteprofile", "r_emailaddress"], redirectUrl: "https://portal.signon.co.in/"))
    //Uidate picker
    var datePicker = UIDatePicker()
    
    //Mark: All LabelField Mendotry
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var Dob: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    
    //Mark:- AllOutlet
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtIndustryExpertise: UITextField!
    @IBOutlet weak var txtYears: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtMarital: UITextField!
    @IBOutlet weak var txtLine1: UITextField!
    @IBOutlet weak var txtLine2: UITextField!
    @IBOutlet weak var txtLandMark: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtPinCode: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var indusryExpertiseBtn: UIButton!
    @IBOutlet weak var yearsBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var maritalBtn: UIButton!
    @IBOutlet weak var line1Btn: UIButton!
    @IBOutlet weak var btnLandMark: UIButton!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var line2Btn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var pinCodeBtn: UIButton!
    
    var imageData  = NSData()
    let dropDown = DropDown()
    var dropDownTag = Int()
    var genderArr: [String] = ["Male","Female"]
    var yearArr: [String] = ["yearArr","B","C","D","E","F"]
    var monthArr: [String] = ["monthArr","B","C","D","E","F"]
    var line1Arr: [String] = ["line1Arr","B","C"]
    var line2Arr: [String] = ["lin21Arr","B","C"]
    var landMarkArr: [String] = ["landMark","B","C"]
    var cityArr: [String] = ["city","B","C"]
    var stateArr: [String] = ["state","B","C"]
    var CountryArr: [String] = ["country","B","C"]
    var pincodeArr: [String] = ["pincode","B","C"]
    var imagePicker = UIImagePickerController()
    let realm = try! Realm()
    let toolbar = UIToolbar();
    var defaultDate: Date!
    var datePickerContainer = UIView()
    var date = String()
    var genderStatus = Int()
    var maritalStatus = Int()
    
    var indusryId = String()
    var yearId = Int()
    var monthId = Int()
    var cameraValue = Int()
    var totlalWorkExp = Int()
    var maritalStatusArr: [String] = ["Single","Married"]
    var industryExpertiseArr = [String]()
    var industryExpertiseIdArr = [String]()
    var dropDownArray = [DropDownStruct]()
    
    var FacebookUrl = String()
    var LinkedinUrl = String()
    var GoogleUrl = String()
    
    //Mark:- PickerViewCode
    //    pickerController.delegate = self
    //    pickerController.allowsEditing = true
    //    pickerController.mediaTypes = ["public.image", "public.movie"]
    //    pickerController.sourceType = .camera
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLbl.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Manage Profile", "Personal")
        UpdateUI()
        
        //    dropDownArray = dataLinq.prepareDropDown()
        imagePicker.delegate = self
        
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
                self.txtIndustryExpertise.text = item
                self.indusryId = self.industryExpertiseIdArr[index]
                print( self.indusryId)
            }
                
            else if self.dropDownTag == 3{
                self.txtYears.text = "\(item)"
                let str = self.txtYears.text!
                if str == "Year"{
                    self.txtYears.text = ""
                }
                else{
                    let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                    self.yearId = Int(arr[0])
                }
            }
            else if self.dropDownTag == 4{
                self.txtMonth.text = "\(item)"//done
                let str = self.txtMonth.text!
                if str == "Month"{
                    self.txtMonth.text = ""
                }
                else{
                    let arr = str.components(separatedBy: " ").compactMap{Int($0)}
                    self.monthId = Int(arr[0])
                }
            }
            else if self.dropDownTag == 5{
                self.txtMarital.text = "\(item)"
                if  self.txtMarital.text == "Single"{
                    self.maritalStatus = 0
                }
                else {
                    self.maritalStatus = 1
                }
            }else{
                print("do nothing with dropdown")
            }
        }
    }
    
    
    // TODO: DateDrop downs
    
    
    func dobDropDown() {
        
        let date = Date()
        DatePickerDialog().show("Select date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: defaultDate ?? Date(), minimumDate: nil, maximumDate: date, datePickerMode: .date) { (date) -> Void in
            if let dt = date
            {
                let formatter  = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.defaultDate = dt
                print(formatter.string(from: dt))
                self.date = formatter.string(from: dt)
                self.txtDob.text! = self.date
                print(date)
                //  self.filterStatus = !self.filterStatus
                //self.postlistService()
            }
        }
    }
    
    
    //Mark:- DocumenDeleagteMethod
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        if let myURL = url as? URL {
            do {
                let resumeData = try Data(contentsOf: myURL as URL)
                UserDefaults.standard.set(resumeData, forKey: "RES_DATA")
                resumeName = "\(url)"
            } catch {
                print("Unable to load data: \(error)")
            }
            let fileName = myURL.lastPathComponent
            resumePathLbl.text! = "Upload Resume\n\(fileName)"
        }
        
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    //Mark:- AllButtonAction
    
    
    @IBAction func facebookBtnAction(_ sender: Any){
       
        FBLoginSetup()
    }
    
    
    func FBLoginSetup()
    {
        let fbloginManager:FBSDKLoginManager = FBSDKLoginManager()
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            
            fbloginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
                self.macroObj.showLoader(view: self.view)
                if error != nil{
                    self.macroObj.hideLoader()
                    print("Get an error\(error?.localizedDescription)")
                }else{
                    self.macroObj.hideLoader()
                    self.getFbData()
                    fbloginManager.logOut()
                }
            }
        }else{
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    func getFbData()
    {
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            if (FBSDKAccessToken.current != nil){
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id ,name , first_name , last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                    self.macroObj.showLoader(view: self.view)
                    if error != nil{
                        self.macroObj.hideLoader()
                        print("Get error\(error?.localizedDescription)")
                    }
                    else{
                        self.macroObj.hideLoader()
                        if let dataDict = result as? [String : AnyObject]{
                            print(dataDict)
                            
                            guard let socialID = dataDict["id"] as? String else {
                                print("No socialID")
                                return
                            }
                            guard let first_name = dataDict["first_name"] as? String else {
                                print("No first_name")
                                return
                            }
                            guard let last_name = dataDict["last_name"] as? String else {
                                print("No last_name")
                                return
                            }
                            guard let name = dataDict["name"] as? String else {
                                print("No name")
                                return
                            }
                            if let email = dataDict["email"] as? String{
                               // self.emailString = email
                            }else{
                                print("No email")
                            }
                            
                            
                            if let pictureDict = dataDict["picture"] as? [String:AnyObject]{
                                if let pictureData = pictureDict["data"] as? [String:AnyObject]{
                                    guard let url = pictureData["url"] as? String else {
                                        print("No url")
                                        return
                                    }
                                    //                                    let theProfileImageUrl:URL! = URL(string: url as! String)
                                    //                                    do{
                                    //                                        let imageData = try NSData(contentsOf: theProfileImageUrl as URL)
                                    //                                        UserDefaults.standard.set(imageData, forKey: "imageData")
                                    //                                    }catch{
                                    //                                        print("Error :- \(error.localizedDescription)")
                                    //                                    }
                                }
                            }
                            
                            self.FacebookUrl = "https://www.facebook.com/\(socialID)"
                            print(self.FacebookUrl)
                            
//                            self.isComingThrough = "SOCIAL_LOGIN"
//                            self.apiCallForSocialLogin(fullname:name,socialID:socialID,isComing:"btnFB")
                        }
                        
                    }
                })
            }
        }else{
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    @IBAction func linkdinBtnAction(_ sender: Any) {
       getLinkedInToken()
    }
    
    
    @IBAction func googleBtnAction(_ sender: Any) {
        if InternetConnection.internetshared.isConnectedToNetwork(){
            self.macroObj.showLoader(view: self.view)
            GIDSignIn.sharedInstance().signOut()
            GIDSignIn.sharedInstance().delegate=self
            GIDSignIn.sharedInstance().uiDelegate=self
            GIDSignIn.sharedInstance().signIn()
        }else{
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    @IBAction func resumeUploadAction(_ sender: Any) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF),String("com.microsoft.word.doc")], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func line1BtnAcion(_ sender: Any) {
        
    }
    @IBAction func line2BtnAction(_ sender: Any) {
        
    }
    @IBAction func cityBtnAction(_ sender: Any) {
        
    }
    @IBAction func stateBtnAction(_ sender: Any) {
        
    }
    @IBAction func landMarkBtnAction(_ sender: Any) {
        
    }
    @IBAction func maritalBtnAction(_ sender: UIButton) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = maritalStatusArr
        dropDown.anchorView = maritalBtn
        dropDown.show()
    }
    
    @IBAction func yearsBtnAction(_ sender: UIButton) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DropDowns.shared.prepareYearDropDown()
        dropDown.anchorView = yearsBtn
        dropDown.width = self.yearsBtn.frame.size.width
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func monthBtnAction(_ sender: UIButton) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DropDowns.shared.prepareMonthDropDown()
        dropDown.anchorView = monthBtn
        dropDown.width = self.monthBtn.frame.size.width
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func dobBtnAction(_ sender: UIButton) {
        //show date picker
        dobDropDown()
    }
    
    @IBAction func genderBtnAction(_ sender: Any)
    {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = genderArr
        dropDown.anchorView = genderBtn
        dropDown.show()
    }
    
    @IBAction func industryExpertiseAction(_ sender: Any) {
        
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource =  self.industryExpertiseArr
        dropDown.anchorView = indusryExpertiseBtn
        dropDown.width = indusryExpertiseBtn.frame.size.width
        dropDown.direction = .bottom
        dropDown.show()
        
    }
    
    @IBAction func countryBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func pinCodeBtnAction(_ sender: Any) {
        
    }
    
    @IBAction func uploadImageAction(_ sender: Any) {
        showImagePicker()
    }
    
    //MARK: - Open the camera
    //MARK: - Choose image from camera roll
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController (animated: true)
    }
    
    @IBAction func saveAction_Btn(_ sender: UIButton) {
        validationSetup()
        
    }
    
    
    
    
    func UpdateUI(){
        fullNameLbl.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Full Name")
        emailIdLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Email ID")
        Dob.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Date of Birth")
        addressLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Address")
        lineLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Line 1")
        cityLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "City")
        stateLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "State")
        countryLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Country")
        pincodeLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Pincode")
        dataForSearchTap()
    }
}


//MARK: - Extension google signIn
extension JobSeeekerMentorProfileVC:GIDSignInDelegate,GIDSignInUIDelegate{
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
        if error != nil {
            self.macroObj.hideLoader()
            print("\(error.localizedDescription)")
        }
        else
        {
            self.macroObj.hideLoader()
            if let profilePicUrlString = user.profile.imageURL(withDimension: 300) as? String{
                let theProfileImageUrl:URL! = URL(string: profilePicUrlString )
                do{
                    let imageData = try NSData(contentsOf: theProfileImageUrl as URL)
                    UserDefaults.standard.set(imageData, forKey: "imageData")
                }catch{
                    print("Error :- \(error.localizedDescription)")
                }
            }
            guard let userId = user.userID  else{ return }              // For client-side use only!
            guard let idToken = user.authentication.idToken else{ return}// Safe to send to the server
            guard let fullName = user.profile.name else {return }
            guard let givenName = user.profile.givenName else { return}
            guard let familyName = user.profile.familyName else {return }
            guard let email = user.profile.email else { return }
            self.GoogleUrl = "https://plus.google.com/\(userId)"
            print(GoogleUrl)
           
        }
    }
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension JobSeeekerMentorProfileVC{
    
    func getLinkedInToken(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
          //  self.macroObj.showLoader(view: self.view)
            /**
             *  Yeah, Just this simple, try with Linkedin installed and without installed
             *
             *   Check installed if you want to do different UI: linkedinHelper.isLinkedinAppInstalled()
             *   Access token later after login: linkedinHelper.lsAccessToken
             */
            
            linkedinHelper.authorizeSuccess({ [unowned self] (lsToken) -> Void in
                self.macroObj.hideLoader()
                print("Login success lsToken: \(lsToken.accessToken)")
                
                if let accessToken = lsToken.accessToken as? String{
                    self.getLinkedInData(accessToken: accessToken)
                }
                
                
                }, error: { [unowned self] (error) -> Void in
                    self.macroObj.hideLoader()
                    print("Encounter error: \(error.localizedDescription)")
                }, cancel: { [unowned self] () -> Void in
                    self.macroObj.hideLoader()
                    print("User Cancelled!")
            })
        }else{
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    
    
    func getLinkedInData(accessToken:String){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            self.macroObj.showLoader(view: self.view)
            /**
             *  Yeah, Just this simple, try with Linkedin installed and without installed
             *
             *   Check installed if you want to do different UI: linkedinHelper.isLinkedinAppInstalled()
             *   Access token later after login: linkedinHelper.lsAccessToken
             */
            
            linkedinHelper.requestURL("https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))", requestType: LinkedinSwiftRequestGet, success: { (response) in
                
                self.macroObj.hideLoader()
                if let dict = response.jsonObject as NSDictionary? as! [String:Any]? {
                    
                    if let id = dict["id"] as? String{
                        print(id)
                        
                        self.LinkedinUrl = "https://api.linkedin.com/v1/people/~?format=json&oauth2_access_token=\(accessToken)"
                        print(self.LinkedinUrl)
                        
                    }
                    
                }
                
                
                
            }) { (error) in
                self.macroObj.hideLoader()
                print(error)
            }
        }else{
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    
   
}

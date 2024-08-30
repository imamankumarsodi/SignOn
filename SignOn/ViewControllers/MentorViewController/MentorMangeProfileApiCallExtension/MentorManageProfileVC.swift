//
//  MentorManageProfileVC.swift
//  SignOn
//
//  Created by Callsoft on 22/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift
import RSKPlaceholderTextView

class MentorManageProfileVC: UIViewController,searchData {
    
    //Mark: AllObject
    
    @IBOutlet weak var profileImgLbl: UILabel!
    
    
    var registerDic = [String:AnyObject]()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    var imageData = NSData()
    let  appDelegateObj = UIApplication.shared.delegate as! AppDelegate
    var registerDataFromReg = [String:AnyObject]()
    var imagePicker = UIImagePickerController()
    var imageDataProfilePic = NSData()
    let dropDown = DropDown()
    var cameravalue = Int()
    let dataLinq = DesignationDropDown()
    var dropDownArray = [DropDownStruct]()
    var yearVariable = Int()
    var monthVariable = Int()
    var desingnatioId = String()
    var yearId = String()
    var monthId = String()
    var indusryId = Int()
    var DegingNationArr = [String]()
    var DegingNationIdArr = NSMutableArray()
    var resutResponseArray = NSArray()
    var IndustriesArr = [String]()
    var InduStrArrId =  NSMutableArray()
    var dropDownTag = Int()
    var industryExpertiseArr: [String] = ["A","B","C","D","E","F"]
    var maritalStatusArr: [String] = ["maritalStatusArr","B","C"]
    var line1Arr: [String] = ["line1Arr","B","C"]
    var line2Arr: [String] = ["lin21Arr","B","C"]
    var landMarkArr: [String] = ["landMark","B","C"]
    var cityArr: [String] = ["city","B","C"]
    var stateArr: [String] = ["state","B","C"]
    var CountryArr: [String] = ["country","B","C"]
    var pincodeArr: [String] = ["pincode","B","C"]
    
    //All LabelOutLet:-
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var lblDesingnation: UILabel!
    @IBOutlet weak var lblProfesnalSumary: UILabel!
    @IBOutlet weak var lblWorkExpeerience: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var desingNationBtn: UIButton!
    @IBOutlet weak var industryBtn: UIButton!
    @IBOutlet weak var yearsBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var maritalBtn: UIButton!
    @IBOutlet weak var imgUrlLbl: UILabel!
    
    //Mark: AllTetxFieldOutlet
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txt_Desingnation: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
     @IBOutlet weak var txtYears: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtSelectIndustry: UITextField!
     @IBOutlet weak var txtProfesionalView: RSKPlaceholderTextView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        UPdateUi()
       
//        UpdateProfileStatus()
        
        
       
         // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        imagePicker.delegate = self
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if self.dropDownTag == 1{
                self.txt_Desingnation.text = item
                self.desingnatioId =  self.DegingNationIdArr.object(at: index) as? String ?? ""
                print("roleId31",self.desingnatioId)
                
            }
            else if self.dropDownTag == 2{
                self.txtYears.text = "\(item)"
                let str = self.txtYears.text!
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
 
            }else if self.dropDownTag == 4{
                self.txtSelectIndustry.text = "\(item)"
                //self.indusryId = self.dropDownArray[index].id

            }
        }
    }
    
    
    @IBAction func facbookBtnAction(_ sender: Any) {
        let facebookURL = NSURL(string: "fb://profile/PageId")!
        if UIApplication.shared.canOpenURL(facebookURL as URL) {
            UIApplication.shared.openURL(facebookURL as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://www.facebook.com/PageName")! as URL)
        }
    }
    
    
    @IBAction func linkdinBtnAction(_ sender: Any) {
        if let url = URL(string: "linkedin://#profile/35932112") {
            if !UIApplication.shared.openURL(url) {
                 // opening the app didn't work - let's open Safari
                 if let url = URL(string: "http://www.linkedin.com/company/pinkstone-pictures") {
                    if !UIApplication.shared.openURL(url) {
                         // nothing works - perhaps we're not onlye
                        print("LinkedIn doesn't works. Punt.")
                    }
                }
            }
        }
    }
    
    
    @IBAction func googleBtnAction(_ sender: Any) {
        let googlePlusURL = NSURL(string: "gplus://plus.google.com/u/0/PageId")!
        if UIApplication.shared.canOpenURL(googlePlusURL as URL) {
            UIApplication.shared.openURL(googlePlusURL as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://plus.google.com/PageId")! as URL)
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
    @IBAction func desingNationBtnAction(_ sender: UIButton) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DegingNationArr
        dropDown.anchorView = desingNationBtn
        dropDown.direction = .bottom
        dropDown.show()
        
    }
    @IBAction func imageUploadBtnAction(_ sender: Any) {
        showImagePicker()
    }
    
    @IBAction func selectIndustryBtnAction(_ sender: Any) {
//        dropDownTag = (sender as AnyObject).tag
//        dropDown.dataSource =  DropDowns.shared.prepareYearDropDown()
//        dropDown.anchorView = industryBtn
//        dropDown.show()
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "SearchTabViewController") as! SearchTabViewController
        let nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        // popoverContent.preferredContentSize = CGSize(500,600)
        //  popover!.delegate = self
        popover!.sourceView = self.view
        
        
        popoverContent.searchDataDelegate = self
        
        popoverContent.passDict = ["fields":["*"],"filter":"DataType=1","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
        popoverContent.APIURL = "https://api.searchtap.io/v1/collections/prod_staticData/query"
        popoverContent.isComingFromIndex = 1
        self.present(nav, animated: true, completion: nil)
    }
    
    func searchData(selecetdNameArray: NSMutableArray, selecetdIdArray: NSMutableArray, isComingFromIndex: Int) {
        print("selected name array",selecetdNameArray)
        print("selected Id array",selecetdIdArray)
        self.InduStrArrId  = selecetdIdArray
        print("selected MyId array",InduStrArrId)
        
        let breakStr = selecetdNameArray.componentsJoined(by: ",")  // To Show on textField
        
        print("THE BREAK STR",breakStr)
        self.txtSelectIndustry.text! = breakStr
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func yearsBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DropDowns.shared.prepareYearDropDown()
        dropDown.anchorView = yearsBtn
     // dropDown.direction = .bottom
        dropDown.show()
    }
   
    @IBAction func monthBtnAction(_ sender: UIButton) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DropDowns.shared.prepareMonthDropDown()
         dropDown.anchorView = monthBtn
        dropDown.show()
    }
    
    @IBAction func maritalBtnAction(_ sender: UIButton) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = maritalStatusArr
        dropDown.anchorView = maritalBtn
        dropDown.show()
    }
    
    func UpdateProfileStatus(){
        if let userInfo = realm.objects(LoginDataModal.self).first{
            txtFullName.text! = userInfo.Name
            txtEmail.text!    = userInfo.Email
            txtPhoneNumber.text! =   userInfo.Mobile
             txtSelectIndustry.text!    = userInfo.Industry
          //  let genderStr = String(userInfo.Gender)
            let maritalStr = String(userInfo.MaritalStatus)
        
    }
}
    
    
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        
        
        validationSetup()
//        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
//        self.navigationController?.pushViewController(home, animated: true)
    }
    
    func UPdateUi() {
           lblFullName.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Full Name")
        emailLbl.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "EmailId")
         lblDesingnation.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Designation")
         lblWorkExpeerience.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Work Experience")
         lblProfesnalSumary.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Professional Summary")
         headerLabel.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Manage Profile", "Personal")
        dropDownArray = dataLinq.prepareDropDown()
        MentorManagePersonalProfileApi()
         
    }
 }




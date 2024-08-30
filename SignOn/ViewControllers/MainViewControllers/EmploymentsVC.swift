//
//  EmploymentsVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import DropDown
import RSKPlaceholderTextView

class EmploymentsVC: UIViewController,UITextViewDelegate {
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    
    var dropDownArray = [DropDownStruct]()
    var indusryId = String()
    var yearId = String()
    var monthId = String()
    var passDict = [String:AnyObject]()
    
    //Mark: AllLabel Mendetory
    
    @IBOutlet weak var btnYesRef: UIButton!
    @IBOutlet weak var btnNoRef: UIButton!
    
    
    
    @IBOutlet weak var specailProjectTextView: RSKPlaceholderTextView!

    @IBOutlet weak var txtDesingnation: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtmonth: UITextField!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    
    
    @IBOutlet weak var txtYearEnd: UITextField!
    @IBOutlet weak var txtmonthEnd: UITextField!
    @IBOutlet weak var yearBtnEnd: UIButton!
    @IBOutlet weak var monthBtnEnd: UIButton!
    
    var itemIndex = Int()
    var endIndex = Int()
    
    var dropDownTag = Int()
    
    var monthArr: [String] = ["Start Month","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    var monthIdArr = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    
    
    
    //Mark:- Variable
    let realm = try! Realm()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.specailProjectTextView.text = "Enter Special Project"
        self.specailProjectTextView.textColor = UIColor.lightGray
        self.specailProjectTextView.delegate = self
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
                self.txtmonth.text = "\(item)"
                self.itemIndex = index
            }else if self.dropDownTag == 3{
                self.txtYearEnd.text = "\(item)"
               
            }else{
                self.txtmonth.text = "\(item)"
                self.endIndex = index
            }
        }
        
    }

    
    
  
    
    @IBAction func btn_backToProfile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func yaerBtnAction(_ sender: Any) {
        dropDownTag = 1
        dropDown.dataSource = DropDowns.shared.preparePassingYear()
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
    
    @IBAction func EndyaerBtnAction(_ sender: Any) {
        dropDownTag = 3
        dropDown.dataSource = DropDowns.shared.preparePassingYear()
        dropDown.anchorView = yearBtnEnd
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func EndmonthBtnAction(_ sender: Any) {
        dropDownTag = 4
        dropDown.dataSource =  monthArr
        dropDown.anchorView =  monthBtnEnd
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func yesBtnAction(_ sender: Any) {
       btnYesRef.setImage(#imageLiteral(resourceName: "yellow_circle"), for: .normal)
        btnNoRef.setImage(#imageLiteral(resourceName: "_circke"), for: .normal)
    }
    
    @IBAction func noBtnAction(_ sender: Any) {
        btnYesRef.setImage(#imageLiteral(resourceName: "_circke"), for: .normal)
        btnNoRef.setImage(#imageLiteral(resourceName: "yellow_circle"), for: .normal)
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        validationSetup()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if specailProjectTextView.textColor == UIColor.lightGray {
            specailProjectTextView.text = ""
            specailProjectTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if specailProjectTextView.text == "" {
            specailProjectTextView.text = "Enter Special Project"
            specailProjectTextView.textColor = UIColor.lightGray
        }
    }
  
}

extension EmploymentsVC{
    func validationSetup()->Void {
        var message = ""
        if !validation.validateBlankField(txtDesingnation.text!){
            message = MacrosForAll.VALIDMESSAGE.DesingnationField.rawValue
        }  else if !validation.validateBlankField(txtCompanyName.text!){
            message = MacrosForAll.VALIDMESSAGE.CompanyName.rawValue
        }
        else if !validation.validateBlankField(txtYear.text!){
            message = MacrosForAll.VALIDMESSAGE.Year.rawValue
        }
        else if !validation.validateBlankField(txtmonth.text!){
            message = MacrosForAll.VALIDMESSAGE.Month.rawValue
        }
        else if !validation.validateBlankField(specailProjectTextView.text!){
            message = MacrosForAll.VALIDMESSAGE.specialProjectPlan.rawValue
        }
        
        
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            manageProfileApiCall()
        }
    }
    
    func manageProfileApiCall() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            var token = String()
            var userID =  String()
            
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }
            
            //   https://portal.signon.co.in/api/v1/candidates/12926/employments
            let passDict = ["CandidateId":userID,
                            "CompanyName":txtCompanyName.text!,
                            "Designation":txtDesingnation.text!,
                            "Id":0,
                            "SpecialProjects":specailProjectTextView.text!,
                            "StartMonth":self.monthIdArr[itemIndex],
                            "StartYear":txtYear.text!,
                            "EndMonth":self.monthArr[endIndex],
                            "EndYear":self.txtYearEnd.text!] as [String: AnyObject]
            
            
           
            
            
            
            print("PASSDICT", passDict)
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.firstGetAllHomeData)/\(userID)/employments", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.smothingWentWrong.rawValue, style: AlertStyle.error)
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

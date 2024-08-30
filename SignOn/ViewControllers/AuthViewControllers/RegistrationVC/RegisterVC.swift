//
//  RegisterVC.swift
//  SignOn

//  Created by abc on 26/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//


// var flage:Int?

import UIKit
import RealmSwift
import DropDown

class RegisterVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var lblHeaderObj: UILabel!
    @IBOutlet weak var lblFooterObj: UILabel!
    @IBOutlet weak var btnRef_JobSeeker: UIButton!
    @IBOutlet weak var btnRef_Mentor: UIButton!
    @IBOutlet weak var checkRef_Btn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var txtFieldMobile: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    
    
    //MARK: - VARIABLES
    var userName:String?
    var userMobileNo:String?
    var userPassword:String?
    var userConfirmPassword:String?
    var isMentor = Bool()
    var checkBtn = Bool()
    var UserRole = Bool()
    var registerDic = [String:AnyObject]()
    let dropDown = DropDown()
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // Do any additional setup after loading the view.
        self.isMentor = false
       // self.checkBtn = false
       // flage = 1
        initialSetup()
    }
    
    @IBAction func btn_BackToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_JobSeeker(_ sender: Any) {
        self.isMentor = false
        //flage = 1
        self.btnRef_JobSeeker.backgroundColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.7529411765, alpha: 1)
        self.btnRef_JobSeeker.setTitleColor(.white, for: .normal)
        self.btnRef_Mentor.backgroundColor = #colorLiteral(red: 0.9405930638, green: 0.9456291795, blue: 0.9646478295, alpha: 1)
        self.btnRef_Mentor.setTitleColor(.darkGray, for: .normal)
        self.btnRef_Mentor.layer.borderWidth = 1
        self.btnRef_Mentor.layer.borderColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.7529411765, alpha: 1)
        
        nameTextField.text   = ""
        txtFieldMobile.text = ""
        txtFieldPassword.text  = ""
        txtFieldConfirmPassword.text = ""
     }
    
    
    @IBAction func btn_Mentor(_ sender: Any) {
        self.isMentor = true
      //  flage = 2
        self.btnRef_Mentor.backgroundColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.7529411765, alpha: 1)
        self.btnRef_Mentor.setTitleColor(.white, for: .normal)
        self.btnRef_JobSeeker.backgroundColor = #colorLiteral(red: 0.9405930638, green: 0.9456291795, blue: 0.9646478295, alpha: 1)
        self.btnRef_JobSeeker.setTitleColor(.darkGray, for: .normal)
        self.btnRef_JobSeeker.layer.borderWidth = 1
        self.btnRef_JobSeeker.layer.borderColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 0.7529411765, alpha: 1)
        
        nameTextField.text   = ""
        txtFieldMobile.text = ""
        txtFieldPassword.text  = ""
        txtFieldConfirmPassword.text = ""
    }
    
    @IBAction func btn_CheckTerm(_ sender: Any) {
        
        if (checkRef_Btn.isSelected == true)
        {
            checkRef_Btn.isSelected = false
            checkRef_Btn.setImage(#imageLiteral(resourceName: "_note_selected"), for: .normal)
          //  checkBtn = false
        }
        else
        {
            checkRef_Btn.isSelected = true
            checkRef_Btn.setImage(#imageLiteral(resourceName: "_selected_circle"), for: .normal)
           // checkBtn = true
        }
    }
    
    
    @IBAction func btn_Register(_ sender: Any) {
       validationSetup()
//          let manageJobSeeker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobSeeekerMentorProfileVC") as! JobSeeekerMentorProfileVC
//
//         self.navigationController?.pushViewController(manageJobSeeker, animated: true)
        
    }
  }


//MARK: - Extention user defined methods

extension RegisterVC{
    //TODO: Initial Setup
    func initialSetup(){
        //flage = 1
        UpdateUIClass.updateSharedInstance.gettingCustomFonts()
        lblHeaderObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Register", "Fill out the form below to get started")
        lblFooterObj.attributedText = UpdateUIClass.updateSharedInstance.updateTermAndConditionLabel()
    }
}

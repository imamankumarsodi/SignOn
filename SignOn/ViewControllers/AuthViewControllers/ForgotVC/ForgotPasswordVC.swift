//
//  ForgotPasswordVC.swift
//  SignOn
//
//  Created by abc on 01/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
class ForgotPasswordVC: UIViewController {

    
    @IBOutlet weak var txtForgot: UITextField!
    @IBOutlet weak var lblHeaderObj: UILabel!
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    @IBAction func btn_backToLogin(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btn_SendOTP(_ sender: Any) {
        
        validationSetup()
        
     
        
    }
}

//MARK: - Extention user defined methods
extension ForgotPasswordVC{
    //TODO: Initial Setup
    func initialSetup(){
        
        UpdateUIClass.updateSharedInstance.gettingCustomFonts()
        lblHeaderObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Forgot Password", "Please enter your registered phone number")
        
    }
}

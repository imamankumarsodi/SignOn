//
//  LoginVC.swift
//  SignOn
//
//  Created by abc on 26/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
class LoginVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var lblHeaderObj     : UILabel!
    @IBOutlet weak var txt_MobileNumber : UITextField!
    @IBOutlet weak var txt_Password     : UITextField!
    
    //MARK: - VARIABLES
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
  
    
    override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
        initialSetup()
    }
    
    
    @IBAction func btn_Login(_ sender: Any) {
        validationSetup()
    }
    
    @IBAction func btn_ForgotPassword(_ sender: Any) {
        
        let forgotVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    
    @IBAction func btn_RegisterNow(_ sender: Any) {
        
        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(regVC, animated: true)
    }
}

//MARK: - Extention user defined methods
extension LoginVC{
    //TODO: Initial Setup
    func initialSetup(){
        UpdateUIClass.updateSharedInstance.gettingCustomFonts()
        lblHeaderObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Login", "Welcome to SignOn Portal")
    }
    
    // TODO: Validations for all input fields
    
    func validationSetup()->Void{
        var message = ""
                if !validation.validateBlankField(txt_MobileNumber.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterMobileNumber.rawValue
        }else if !validation.validateBlankField(txt_Password.text!){
            message = MacrosForAll.VALIDMESSAGE.PasswordNotBeBlank.rawValue
        }else if (txt_Password.text!.characters.count < 6 ){
            message = MacrosForAll.VALIDMESSAGE.PasswordShouldBeLong.rawValue
        }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            LoginApi()
        }
    }
    

    //TODO: Save data to realm
    
    func save(userInfo:LoginDataModal,id:String,token:String){
            do{
                try realm.write {
                    if let user = realm.objects(LoginDataModal.self).first{
                        user.token = userInfo.token
                        user.Id = userInfo.Id
                        user.isMentor = userInfo.isMentor
                        sendToControllers()
                        
                    }else{
                        realm.add(userInfo)
                        sendToControllers()
                    }
                    
                }
            }catch{
                print("Error in saving data :- \(error.localizedDescription)")
            }
        
    }
    
    
    func saveUserCandidate(userInfo:LoginDataModal){
        do{
            try realm.write {
                if let user = realm.objects(LoginDataModal.self).first{
                    user.Name = userInfo.Name
                    user.Email = userInfo.Email
                    user.Mobile = userInfo.Mobile
                    user.TotalWorkingExperience = userInfo.TotalWorkingExperience
                    user.AnnualSalary = userInfo.AnnualSalary
                    user.Url = userInfo.Url
                
                    self.appDelegate.initHome()
                }
                
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
    }
    
   

}


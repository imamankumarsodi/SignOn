//
//  VarificationVC.swift
//  SignOn
//
//  Created by abc on 26/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class VarificationVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var lblHeaderObj: UILabel!
    @IBOutlet weak var txtVarification: UITextField!
    
    //MARK: - VARIABLES
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    var isComingFrom = String()
    var mobileStr = String()
    var responseCode = Int()
    var isMentor = Bool()
    
    let  appDelegateObj = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("THE DETAILS OF SIGNUP", registerDataFromReg)
        
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    @IBAction func btn_BackToRegistration(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Verify(_ sender: Any) {
        validationSetup()
        
//        if flage == 1{
//
////              appDelegateObj.initHome()
//
//            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobSeeekerMentorProfileVC") as! JobSeeekerMentorProfileVC
//            self.navigationController?.pushViewController(home, animated: true)
//        }
//        else{
//            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MentorManageProfileVC") as! MentorManageProfileVC
//            self.navigationController?.pushViewController(home, animated: true)
//           // appDelegateObj.homeMentor()
//
//        }
    }
    
    @IBAction func btn_Resend(_ sender: Any) {
        sendOtpApi()
    }
    
    //Mark:-- ResendApi
    func sendOtpApi(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            self.txtVarification.text! = ""
            let passDict = ["Mobile":mobileStr]
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8"
                ] as [String : AnyObject]
            
            alamObject.postRequestURL(APIName.OTPApi, params: passDict as [String : AnyObject], headers: header as! [String : String], success: { (responseJson,responseCode) in
                
                print(responseJson)
                print("THE RSPONSE CODE", responseCode)
                if responseCode == 200{
                  
                }
                else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }
                
            }, failure: { (error,responseCode) in
                print(error)
                print(responseCode)
                
                if responseCode == 200{
                    let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "VarificationVC") as! VarificationVC
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }
                    
                else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ALERT_MESSAGES.SomethingWentWrong, style: AlertStyle.error)
                }
                print("ERROR IS", error.localizedDescription)
                // self.alert(message: ALERT_MESSAGES.SomethingWentWrong, title: ALERT_MESSAGES.AppName)
            })
        }
        else {
            //LODER HIDE
            alert(message: ALERT_MESSAGES.internetConnectionError, title: ALERT_MESSAGES.AppName)
        }
    }
}
//MARK: - Extention user defined methods
extension VarificationVC{
    
    
    
    
}

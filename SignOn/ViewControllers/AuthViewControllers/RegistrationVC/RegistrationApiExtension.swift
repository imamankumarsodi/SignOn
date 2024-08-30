//
//  RegistrationApiExtension.swift
//  SignOn
//
//  Created by Callsoft on 18/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

extension RegisterVC{
    
    
   //  TODO: Validations for all input fields
    
    func validationSetup()->Void{
        var message = ""
        if !validation.validateBlankField(nameTextField.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterFullName.rawValue
        }else if !validation.validateBlankField(txtFieldMobile.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterMobileNumber.rawValue
        }else if (!validation.validateBlankField(txtFieldPassword.text!) ){
            message = MacrosForAll.VALIDMESSAGE.PasswordNotBeBlank.rawValue
        }else if (txtFieldPassword.text!.characters.count < 6 ){
            message = MacrosForAll.VALIDMESSAGE.PasswordShouldBeLong.rawValue
        }else if (!validation.validateBlankField(txtFieldConfirmPassword.text!) ){
            message = MacrosForAll.VALIDMESSAGE.ConfirmPasswordNotBeBlank.rawValue
        }else if (txtFieldConfirmPassword.text!.characters.count < 6 ){
            message = MacrosForAll.VALIDMESSAGE.ConfirmPasswordShouldBeLong.rawValue
        }else if (txtFieldPassword.text! != txtFieldConfirmPassword.text!){
            message = MacrosForAll.VALIDMESSAGE.PasswordAndConfimePasswordNotMatched.rawValue
        }else if (checkRef_Btn.isSelected == false){
            message = MacrosForAll.VALIDMESSAGE.AcceptTermsAndConditions.rawValue

        }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
       //   sendOtpApi()
        signUpAPI()
        }
    }
    
    //MARK:- Registration Api
    
    func sendOtpApi() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
           
            let passDict = ["Mobile":self.txtFieldMobile.text!]
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8"
            ] as [String : AnyObject]
              macroObj.showLoader(view: self.view)
            alamObject.postRequestURL(APIName.OTPApi, params: passDict as [String : AnyObject], headers: header as! [String : String], success: { (responseJson,responseCode) in
                
                print(responseJson)
                self.macroObj.hideLoader()
               if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.UserRole = self.isMentor
                
                    let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "VarificationVC") as! VarificationVC
                    otpVC.isComingFrom = "SignUp"
                    otpVC.isMentor = self.isMentor
                    otpVC.mobileStr = self.txtFieldMobile.text!
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }
               else{
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.SignupErrorMsgAlert.rawValue, style: AlertStyle.error)
                }
              
                
            }, failure: { (error,responseCode) in
                print(error)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.UserRole = self.isMentor
                    self.registerDic = ["Name":  self.nameTextField.text!,
                                        "Mobile": self.txtFieldMobile.text!,
                                        "Password": self.txtFieldPassword.text!,
                                       // "UserRole": self.UserRole,
                                        "IsMentor": true] as! [String : AnyObject]
                    
                    let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "VarificationVC") as! VarificationVC
                    otpVC.isComingFrom = "SignUp"
                    otpVC.mobileStr = self.txtFieldMobile.text!
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }else{
                    
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.SignupErrorMsgAlert.rawValue, style: AlertStyle.error)
                }

//                self.macroObj.hideLoader()
//                print("ERROR IS", error.localizedDescription)
//                self.alert(message: ALERT_MESSAGES.SomethingWentWrong, title: ALERT_MESSAGES.AppName)
            })
        }
        else {
            //LODER HIDE
            self.macroObj.hideLoader()
            alert(message: ALERT_MESSAGES.internetConnectionError, title: ALERT_MESSAGES.AppName)
              }
    }
    
    func signUpAPI() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            let header = [
                "Content-Type": "application/json"
            ] as! [String:String]
            print(header)
            self.registerDic = ["Name":  self.nameTextField.text!,
                                "Mobile": self.txtFieldMobile.text!,
                                "Password": self.txtFieldPassword.text!,
                                "IsMentor": self.isMentor] as! [String : AnyObject]
            
            print(self.registerDic)
            macroObj.showLoader(view: self.view)
           alamObject.postRequestURL(APIName.registration, params: registerDic as [String : AnyObject], headers: header, success: { (responseJson,responseCode) in
            print(responseJson)
            self.macroObj.hideLoader()
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.sendOtpApi()

                }
                else{
                    
                  self.macroObj.hideLoader()
                     self.alert(message: ALERT_MESSAGES.numberIsAllreadyUse, title: ALERT_MESSAGES.AppName)
                }
                
            }, failure: { (error,responseCode) in
                self.macroObj.hideLoader()
                print(error)
                print("The Error is:", error.localizedDescription)
                self.alert(message: ALERT_MESSAGES.SomethingWentWrong, title: ALERT_MESSAGES.AppName)
                
            })
            
        }
        else {
            self.macroObj.hideLoader()
            alert(message: ALERT_MESSAGES.internetConnectionError, title: ALERT_MESSAGES.AppName)
        }
        
    }
    
    
}



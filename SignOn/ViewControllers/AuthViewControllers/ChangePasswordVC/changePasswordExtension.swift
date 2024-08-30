//
//  changePasswordExtension.swift
//  SignOn
//
//  Created by Callsoft on 29/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
extension ChangePasswordVC{
    
    
    // TODO: Validations for all input fields
    func validationSetup()->Void{
        var message = ""
        if !validation.validateBlankField(txtNewPassword.text!){
            message = MacrosForAll.VALIDMESSAGE.NewPasswordNotBeBlank.rawValue
        }
        else if (txtNewPassword.text!.characters.count < 6 ){
            message = MacrosForAll.VALIDMESSAGE.NewPasswordShouldBeLong.rawValue
        }
        else if !validation.validateBlankField(newConfirmPassword.text!){
             message = MacrosForAll.VALIDMESSAGE.ConfirmPasswordNotBeBlank.rawValue
        }
        else if (newConfirmPassword.text!.characters.count < 6 ){
            message = MacrosForAll.VALIDMESSAGE.ConfirmPasswordShouldBeLong.rawValue
        }
          else if (txtNewPassword.text! != newConfirmPassword.text!){
                message = MacrosForAll.VALIDMESSAGE.PasswordAndConfimePasswordNotMatched.rawValue
              }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }
        else{
            if isComingFrom == "SignUp"{
                self.forgotApi()
            }else{
                roforgotApi()
            }
            
            
        }
    }
    
    func forgotApi() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            let passDict = ["NewPassword": self.txtNewPassword.text!,
                            "ConfirmPassword": self.newConfirmPassword.text!] as! [String: AnyObject]
            
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                print(userID)
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)

            alamObject.postRequestURL(APIName.setPassword, params: passDict as [String : AnyObject], headers:header, success: { (responseJson,responseCode) in
                
                print(responseJson)
                print(responseCode)
                 if responseCode == 200{
                    self.macroObj.hideLoader()
                        if self.isComingFrom == "forgotPassword" {
                             self.macroObj.hideLoader()
                            let appDel = UIApplication.shared.delegate as! AppDelegate
                            _ = appDel.initLoginAtLogOut()
                        }
                        else {
                             self.macroObj.hideLoader()
                            self.macroObj.hideLoader()
                             self.alert(message: ALERT_MESSAGES.setPassword, title: ALERT_MESSAGES.AppName)
                        }
                }else{
                     self.macroObj.hideLoader()
                    }
            }, failure: { (error,responseCode)  in
                 self.macroObj.hideLoader()
                print("The Error is:", error.localizedDescription)
                self.alert(message: ALERT_MESSAGES.SomethingWentWrong, title: ALERT_MESSAGES.AppName)
                
            })
            
        }
        else {
             self.macroObj.hideLoader()
            alert(message: ALERT_MESSAGES.internetConnectionError, title: ALERT_MESSAGES.AppName)
        }
        
    }
    
    
    
    func roforgotApi() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            let passDict = ["NewPassword": self.txtNewPassword.text!,
                            "ConfirmPassword": self.newConfirmPassword.text!] as! [String: AnyObject]
            
            let token = tokenF
            _ =  userIDF
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            
            alamObject.postRequestURL(APIName.setPassword, params: passDict as [String : AnyObject], headers:header, success: { (responseJson,responseCode) in
                
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    if self.isComingFrom == "forgotPassword" {
                        self.macroObj.hideLoader()
                        let appDel = UIApplication.shared.delegate as! AppDelegate
                        _ = appDel.initLoginAtLogOut()
                    }
                    else {
                        self.macroObj.hideLoader()
                        self.macroObj.hideLoader()
                        self.alert(message: ALERT_MESSAGES.setPassword, title: ALERT_MESSAGES.AppName)
                    }
                }else{
                    self.macroObj.hideLoader()
                }
            }, failure: { (error,responseCode)  in
                self.macroObj.hideLoader()
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

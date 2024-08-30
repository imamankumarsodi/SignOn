//
//  ForgotExtension.swift
//  SignOn
//
//  Created by Callsoft on 29/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
extension ForgotPasswordVC{
    
    //TODO: Initial Setup
    
    // TODO: Validations for all input fields
    func validationSetup()->Void{
        var message = ""
        if !validation.validateBlankField(txtForgot.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterMobileNumber.rawValue
        }
        else if (txtForgot.text!.characters.count < 6 ){
            message = MacrosForAll.VALIDMESSAGE.PasswordLong.rawValue
        }
        //  else if (txtFieldPassword.text! != txtFieldConfirmPassword.text!){
        //        message = MacrosForAll.VALIDMESSAGE.PasswordAndConfimePasswordNotMatched.rawValue
        //      }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }
        else{
            self.sendOtpApi()
        }
    }
    
    func sendOtpApi() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
           
            let passDict = ["Mobile":self.txtForgot.text!]
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8"
                ] as [String : AnyObject]
            
            alamObject.postRequestURL(APIName.OTPApi, params: passDict as [String : AnyObject], headers: header as! [String : String], success: { (responseJson,responseCode) in
                self.macroObj.showLoader(view: self.view)

                print(responseJson)
                self.macroObj.hideLoader()
                print("THE RSPONSE CODE", responseCode)
                if responseCode == 200{
                      self.macroObj.hideLoader()
                let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "VarificationVC") as! VarificationVC
                    otpVC.mobileStr = self.txtForgot.text!
                    otpVC.isComingFrom = "FORGOTPASSORD"
                self.navigationController?.pushViewController(otpVC, animated: true)
                }
                else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.ForgotWrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }

            }, failure: { (error,responseCode) in
                print(error)
                print(responseCode)
                self.macroObj.hideLoader()
                if responseCode == 200{
                    let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "VarificationVC") as! VarificationVC
                    otpVC.mobileStr = self.txtForgot.text!
                    self.navigationController?.pushViewController(otpVC, animated: true)
                }
                else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ALERT_MESSAGES.SomethingWentWrong, style: AlertStyle.error)
                }
                print("ERROR IS", error.localizedDescription)
//                self.alert(message: ALERT_MESSAGES.SomethingWentWrong, title: ALERT_MESSAGES.AppName)
            })
        }
        else {
            //LODER HIDE
              self.macroObj.hideLoader()
            alert(message: ALERT_MESSAGES.internetConnectionError, title: ALERT_MESSAGES.AppName)
             }
    }
}
    

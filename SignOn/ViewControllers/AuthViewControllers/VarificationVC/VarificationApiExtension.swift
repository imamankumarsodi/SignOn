//
//  VarificationApiExtension.swift
//  SignOn
//
//  Created by Callsoft on 29/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

extension VarificationVC{
    
    //TODO: Initial Setup
    
    func initialSetup(){
        UpdateUIClass.updateSharedInstance.gettingCustomFonts()
        lblHeaderObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("OTP Verification", "Please verify your phone number")
    }
    // TODO: Validations for all input fields
    func validationSetup()->Void{
        var message = ""
        if !validation.validateBlankField(txtVarification.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterOTP.rawValue
        }
        
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }
        else{
            
            otpVerifyApi()
        }
    }
    
    
    func otpVerifyApi() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            let passDict = ["otp": self.txtVarification.text!,"Mobile":mobileStr]  as! [String: AnyObject]
            print("PASSDICT", passDict)
            
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8"
            ]
            macroObj.showLoader(view: self.view)
            
            alamObject.postRequestURL(APIName.OTPVerify, params: passDict as [String : AnyObject], headers: header , success: { (responseJson,responseCode) in
                if responseCode == 200{
                    
                    print(responseJson)
                    self.macroObj.hideLoader()
                    
                    if self.isComingFrom == "SignUp"{
                        
                        
                        let userInfo = LoginDataModal()
                        
                        guard let token = responseJson["Token"].stringValue as? String else {
                            print("No Token")
                            return
                        }
                        print(token)
                        guard let id = responseJson["Id"].stringValue as? String else {
                            print("No Id")
                            return
                        }
                        guard let isMentor = responseJson["IsMentor"].boolValue as? Bool else {
                            print("No IsMentor Value")
                            return
                        }
                        userInfo.token = token
                        userInfo.Id = id
                        userInfo.isMentor = isMentor
                        userInfo.Mobile = self.mobileStr
                        
                        //SAVE KARA DO DATA REALM M
                        var apiName = String()
                        if isMentor{
                            apiName = "mentors"
                        }else{
                            apiName = "candidates"
                        }
                        
                        self.save(userInfo: userInfo, id: id, apiName: apiName, token: token)
                        
                        
                    }
                    else{
                        self.macroObj.hideLoader()
                        
                        //  ChangePasswordVC
                        
                        guard let token = responseJson["Token"].stringValue as? String else {
                            print("No Token")
                            return
                        }
                        print(token)
                        guard let id = responseJson["Id"].stringValue as? String else {
                            print("No Id")
                            return
                        }
                        guard let isMentor = responseJson["IsMentor"].boolValue as? Bool else {
                            print("No IsMentor Value")
                            return
                        }
                        
                        
                        let ChangePassVC = UIStoryboard(name: "AuthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                        
                        ChangePassVC.tokenF = token
                        ChangePassVC.userIDF = id
                        ChangePassVC.isMentorF = isMentor
                        ChangePassVC.mobileF = self.mobileStr
                        
                        ChangePassVC.isComingFrom = "forgotPassword"
                        self.navigationController?.pushViewController(ChangePassVC, animated: true)
                    }
                }else{
                    self.macroObj.hideLoader()
                    
                     self.alert(message: ALERT_MESSAGES.OtpWrong, title: ALERT_MESSAGES.AppName)
                    
                }
                
            }, failure: { (error,responseCode) in
                self.macroObj.hideLoader()
                
                print("The Error is:", error.localizedDescription)
                self.alert(message: ALERT_MESSAGES.SomethingWentWrong, title: ALERT_MESSAGES.AppName)
                
            })
            
        }
        else {
            
            alert(message: ALERT_MESSAGES.internetConnectionError, title: ALERT_MESSAGES.AppName)
        }
        
    }
    
    
    
    //TODO: Save data to realm
    
    func save(userInfo:LoginDataModal,id:String,apiName:String,token:String){
        do{
            try realm.write {
                if let user = realm.objects(LoginDataModal.self).first{
                    user.token = userInfo.token
                    user.Id = userInfo.Id
                    user.isMentor = userInfo.isMentor
                    
                }else{
                    realm.add(userInfo)
                }
                
                self.getUserData(id: id, apiName: apiName, token: token)
                
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
    }
    func getUserData(id:String,apiName:String,token:String) {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            let header = [
                "Content-Type": "application/json",
                "Authorization" : "Bearer \(token)"
            ]
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("\(apiName)/\(id)", headers: header, success: { (responseJASON,responseCode)  in
                
                self.macroObj.hideLoader()
                
                print(responseCode)
                if responseCode == 200{
                    print(responseJASON)
                    self.macroObj.hideLoader()
                    if let UserRole = responseJASON["UserRole"].stringValue as? String{
                        if UserRole == "Candidate"{
                            let manageJobSeeker = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobSeeekerMentorProfileVC") as! JobSeeekerMentorProfileVC
                            
                            self.navigationController?.pushViewController(manageJobSeeker, animated: true)
                        }else{
                            let manageJobMentor = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MentorManageProfileVC") as! MentorManageProfileVC
                            
                            self.navigationController?.pushViewController(manageJobMentor, animated: true)
                        }
                    }
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
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


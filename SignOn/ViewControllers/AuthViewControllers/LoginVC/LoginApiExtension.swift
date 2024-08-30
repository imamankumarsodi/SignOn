//
//  LoginApiExtension.swift
//  SignOn
//
//  Created by Callsoft on 18/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
extension LoginVC {

    func LoginApi() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            let passDict = ["Mobile":txt_MobileNumber.text!,
                            "Password":txt_Password.text!] as! [String: AnyObject]
            print("PASSDICT", passDict)
            let header = [

                "Content-Type": "application/json; charset=utf-8"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL(APIName.login, params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
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
                    
                    self.save(userInfo: userInfo, id: id, token: token)
                    
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
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
    
    func viewProfileAPI(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("/mentors/\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    if let isVarified = responseJASON["IsActive"].boolValue as? Bool{
                        if isVarified == true{
                        self.appDelegate.homeMentor()
                        }else{
                            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
                            self.navigationController?.pushViewController(home, animated: true)
                        }
                    }
                }else{
                    self.macroObj.hideLoader()
                }
                
                
            }, failure: { (error,responseCode) in
                print(error.localizedDescription)
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            })
        }
        else {
            //LODER HIDE
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    func viewProfileCandidateAPI(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("/candidates/\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    let info = LoginDataModal()
                    print(responseJASON)
                    
                    if let Name = responseJASON["Name"].stringValue as? String{
                       info.Name = Name
                    }
                    
                    if let Email = responseJASON["Email"].stringValue as? String{
                        info.Email = Email
                    }
                    
                    if let Mobile = responseJASON["Mobile"].stringValue as? String{
                        info.Mobile = Mobile
                    }
                    
                    if let TotalWorkingExperience = responseJASON["TotalWorkingExperience"].stringValue as? String{
                        info.TotalWorkingExperience = TotalWorkingExperience
                        print(info.TotalWorkingExperience)
                    }
                    
                    if let AnnualSalary = responseJASON["AnnualSalary"].intValue as? Int{
                        info.AnnualSalary = AnnualSalary
                        print(info.AnnualSalary)
                    }
                    
                    if let profileDict = responseJASON["ProfileImage"].dictionaryObject as? NSDictionary{
                        if let url = profileDict.value(forKey: "Url") as? String{
                            info.Url = url
                        }
                    }
                    
                    self.saveUserCandidate(userInfo:info)
                    
                }else{
                    self.macroObj.hideLoader()
                }
                
                
            }, failure: { (error,responseCode) in
                print(error.localizedDescription)
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            })
        }
        else {
            //LODER HIDE
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
  
    
    //TODO: Redirections to classes
    func sendToControllers(){
        if let userInfo = realm.objects(LoginDataModal.self).first{
            if userInfo.isMentor{
               viewProfileAPI()
            }else{
                viewProfileCandidateAPI()
                
            }
        }
    }
}

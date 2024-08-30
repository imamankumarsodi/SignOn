//
//  EmploymentManageProfileExtension.swift
//  SignOn
//
//  Created by Callsoft on 27/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
extension EmploymentManageProfileVC{
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
                                "StartYear":txtYear.text!] as [String: AnyObject]
                
                
                
                
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
                                let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageProfileJobPrefrenceVC")as! ManageProfileJobPrefrenceVC
                        home.passDict = self.passDict
                                  self.navigationController?.pushViewController(home, animated: true)
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

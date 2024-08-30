//
//  ManagePFLSummaryExtension.swift
//  SignOn
//
//  Created by Callsoft on 30/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

extension ManageProfileProfesnoalSummaryVC{
    
    
    //Mark: Validation of TextFieldMetod
    
    func validationSetup()->Void {
        var message = ""
        if !validation.validateBlankField(txtViewBio.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterFullBio.rawValue
        }  else if !validation.validateBlankField(txtRole.text!){
            message = MacrosForAll.VALIDMESSAGE.Role.rawValue
        }
        else if !validation.validateBlankField(txtfunctionalArea.text!){
            message = MacrosForAll.VALIDMESSAGE.Funcitionality.rawValue
        }
        else if !validation.validateBlankField(txtIndustries.text!){
            message = MacrosForAll.VALIDMESSAGE.Industry.rawValue
        }
        
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            SaveBtnApiCall()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func dataForRoleSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
               passDict = ["fields":["*"],"filter":"DataType=16","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
                print("PASSDICT", passDict)
 
             let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.RoleArr.removeAll()
                    self.RoleIdArr.removeAllObjects()                     //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                            for item in self.resutResponseArray{
                                                if let itmeDict  = item as? NSDictionary{
                                                    guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                                        print("NO Name")
                                                        return
                                                    }
                                                    guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                                        print("NO Id")
                                                        return
                                                    }
                    
                                                    self.RoleArr.append(Name)
                                                    self.RoleIdArr.add(String(Id))
                    
                                                }
                                            }
                                            self.dataForFuncitionalAreaSearchTap()
                                            self.dropDown.reloadAllComponents()
                                            print("THE NAME ARRAY IS", self.RoleArr)
                                            print("THE ID ARRAY IS", self.RoleIdArr)
                                         }
                   // self.chkBoxTbl.reloadData()
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
    
    
    func dataForFuncitionalAreaSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
           
                passDict = ["fields":["*"],"filter":"DataType=2","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
                print("PASSDICT", passDict)
                
           
           
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.FuncitionalAreaArr.removeAll()
                    self.FunctionalAreaID.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                self.FuncitionalAreaArr.append(Name)
                                self.FunctionalAreaID.add(String(Id))
                                 self.dropDown.reloadAllComponents()
                            }
                        }
                        self.dataForIndustrySearchTap()
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.FuncitionalAreaArr)
                        print("THE ID ARRAY IS", self.FunctionalAreaID)
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    
    func dataForIndustrySearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            
                passDict = ["fields":["*"],"filter":"DataType=1","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
                print("PASSDICT", passDict)
                
         
        
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.IndustriesArr.removeAll()
                    self.InduStrArrId.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.dropDown.reloadAllComponents()
                                self.IndustriesArr.append(Name)
                                self.InduStrArrId.add(String(Id))
                                
                            }
                        }
                        self.dataForRegionServedSearchTap() 
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.IndustriesArr)
                        print("THE ID ARRAY IS", self.InduStrArrId)
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    func dataForRegionServedSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
         
                passDict = ["fields":["*"],"filter":"DataType=7","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
                print("PASSDICT", passDict)
     
        
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.RegionArr.removeAll()
                    self.RegionIdArr.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                //self.RoleArr.append(Name)
                               // self.RoleIdArr.append(String(Id))
                                
                            }
                        }
                        self.dropDown.reloadAllComponents()
                      
                        print("THE NAME ARRAY IS", self.RegionArr)
                        print("THE ID ARRAY IS", self.RegionIdArr)
                    }
                    // self.chkBoxTbl.reloadData()
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
  
    
    
  /////---------------------------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>
    
    func dataToolsServedSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            
            passDict = ["fields":["*"],"filter":"DataType=5","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.toolsResponseArray.removeAll()
                    self.selectedToolsArrId.removeAllObjects()
                    //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as NSArray? ?? []
                    
                    if self.resutResponseArray == responseJson["results"].arrayObject as NSArray? {
                        for item in self.resutResponseArray{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                
                                self.toolsResponseArray.append(Name)
                               self.selectedToolsArrId.add(String(Id))
                                
                            }
                        }
                        self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.toolsResponseArray)
                        print("THE ID ARRAY IS", self.selectedToolsArrId)
                    }
                    // self.chkBoxTbl.reloadData()
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
    
    
    
    
    //MARK: SaveBtnActionApiCall
    
    func SaveBtnApiCall() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
 
            var token = String()
            var userID =  String()
            var isMentor = Bool()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                isMentor = userInfo.isMentor
            }
          
 
            let dirRep = Int(self.txtDirectReportise.text as? String ?? "0")
            let inDirRep = Int(self.txtindirectReportise.text as? String ?? "0")
            
            print(self.salaryResult)
            print(self.txtThousand.text!)
            print(self.txtLack.text!)
            
            let passDict = ["Bio":self.txtViewBio.text!,
                            "AnnualSalary": self.salaryResult,
                            "EmploymentTypes":self.employmentId,
                            "JobTypes": self.jodTypeId,
                            "HasWorkPermit": self.workPermit,
                            "CandidateIndustryId":self.industryArrId,
                            "HasValidPassport":self.validPassword,
                            "IsValidVisa":self.validVisa,
                            "IsPhysicallyChallenged":self.physicalChallangd,
                            "NoticePeriod":self.txtNoticePeriod.text!,
                            "CandidateRoleId":Int(roleId),
                            "PreferedFunctionalAreaIds":Int(funcitionalAreaId),
                            "PreferedIndustryIds":Int(industryArrId),
                            "Tools":selectedRegionArrId,
                            "ToolIds":selectedToolsArrId,
                            "RegionsServeIds":selectedRegionArrId,
                            "Certification":self.txtViewCertification.text!,
                            "DirectRepotees":dirRep,
                            "IndirectRepotees":inDirRep,
                            "ProfileImageId":"0",
                            "ProfileStatus":"0",
                            "Status":Bool()] as [String: AnyObject]
            print(passDict)
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.firstGetAllHomeData)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    
                    self.passDict["Bio"] = self.txtViewBio.text! as AnyObject
                    self.passDict["AnnualSalary"] = self.salaryResult as AnyObject
                    self.passDict["EmploymentTypes"] = self.employmentId as AnyObject
                    self.passDict["JobTypes"] = self.jodTypeId as AnyObject
                    self.passDict["HasWorkPermit"] = self.workPermit as AnyObject
                    self.passDict["CandidateIndustryId"] = self.industryArrId as AnyObject
                    self.passDict["HasValidPassport"] = self.validPassword as AnyObject
                    self.passDict["IsValidVisa"] = self.validVisa as AnyObject
                    self.passDict["IsPhysicallyChallenged"] = self.physicalChallangd as AnyObject
                    self.passDict["NoticePeriod"] = self.txtNoticePeriod.text! as AnyObject
                    self.passDict["CandidateRoleId"] = Int(self.roleId) as AnyObject
                    self.passDict["PreferedFunctionalAreaIds"] = Int(self.funcitionalAreaId) as AnyObject
                    self.passDict["PreferedIndustryIds"] = Int(self.industryArrId) as AnyObject
                    self.passDict["Tools"] = self.selectedRegionArrId
                    self.passDict["ToolIds"] = self.selectedToolsArrId
                    self.passDict["RegionsServeIds"] = self.selectedRegionArrId
                    self.passDict["Certification"] = self.txtViewCertification.text! as AnyObject
                    self.passDict["DirectRepotees"] = dirRep as AnyObject
                    self.passDict["IndirectRepotees"] = inDirRep as AnyObject
                    self.passDict["ProfileImageId"] = Int() as AnyObject
                    self.passDict["ProfileStatus"] = Int() as AnyObject
                    self.passDict["Status"] = Bool() as AnyObject

                    self.JobseekarManageProfileApiMethod()
                    
                    
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
    
    
    func JobseekarManageProfileApiMethod(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            var token = String()
            var userID =  String()
            var isMentor = Bool()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                isMentor = userInfo.isMentor
            }
            
            let apiname = isMentor ? "mentors" : "candidates"
            
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            print(apiname)
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(apiname)/\(userID)", params: self.passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    let appDel = UIApplication.shared.delegate as! AppDelegate
                    _ = appDel.initHome()
                   
                    
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
    
 }

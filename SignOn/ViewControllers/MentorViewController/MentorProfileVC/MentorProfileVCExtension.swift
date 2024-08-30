//
//  MentorProfileVCExtension.swift
//  SignOn
//
//  Created by Callsoft on 02/06/19.
//  Copyright © 2019 mobulous. All rights reserved.
//
//https://portal.signon.co.in/api/v1/mentors/12903

import Foundation
extension MentorProfileVC{
    func getMentorApiJobs() {
        
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
            
        // macroObj.showLoader(view: self.view)
            alamObject.getRequestURL( "\(APIName.mentor)/\(userID)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    //   self.macroObj.hideLoader()
                    
                    print(responseJASON)
                    if let dataArr = responseJASON.dictionaryObject as NSDictionary?{
                        if dataArr.count > 0{
                            if let phoneno = dataArr.value(forKey: "UserName") as? String{
                                print(phoneno)
                                self.phoneNo = phoneno
                                
                            }
                            if let compnyName = dataArr.value(forKey: "CompanyName") as? String{
                                self.companyName = compnyName
                            }
                                if let name = dataArr.value(forKey: "Name") as? String{
                                    print(name)
                                    self.profileName = name
                                    
                                    let defaults = UserDefaults.standard
                                    defaults.set(self.profileName, forKey: "Name")
                                    
                                    self.lblHeaderNameRef.text = name
                                }
                            if let email = dataArr.value(forKey: "Email") as? String {
                                    print(email)
                                    if email == ""{
                                        
                                    }
                                    else{
                                        self.email = email
                                    }
                            }
                            if let email = dataArr.value(forKey: "ProfessionalSummary") as? String {
                                print(email)
                                if email == ""{
                                    print("no data")
                                }
                                else{
                                    self.lblProfileSummary.text = email
                                }
                            }
                            
                            
                            
                                
                                if let Designation = dataArr.value(forKey: "Designation") as? NSDictionary {
                                    if let dName = Designation.value(forKey: "Name") as? String{
                                        self.degingnatiod = dName
                                        print(dName)
                                    }
                                    let totalExp = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                                    
                                    let totalExperieced =  Int(totalExp)
                                    let Year    =   totalExperieced / 12
                                    let month   =    totalExperieced % 12
                                    self.experienceName.0 = (Year)
                                    self.experienceName.1 = (month)
                                    print(self.experienceName)
                               
                                    if self.indusTriesArray.count > 0{
                                        self.indusTriesArray.removeAll()
                                    }
                                    
                                    if self.indusTriesIDArray.count > 0{
                                        self.indusTriesIDArray.removeAllObjects()
                                    }
                                    
                                    if let indusArray = dataArr.value(forKey: "Industries") as? NSArray {
                                        
                                        for item in indusArray{
                                            if let dataDict = item as? NSDictionary{
                                                if let name = dataDict.value(forKey: "Name") as? String{
                                                    self.indusTriesArray.append(name)
                                                }
                                                
                                                if let name = dataDict.value(forKey: "Id") as? Int{
                                                    self.indusTriesIDArray.add(name)
                                                }
                                            }
                                        }
                                        
                                    }

                            }
                        }
                        
                        

                        let Name = responseJASON["Name"].stringValue as? String ?? ""
                        var ProfileImage = responseJASON["Url"].stringValue as? String ?? ""
                        
                        
                        
                        
                        UserDefaults.standard.set(Name, forKey: "NAME")
                        
                        if ProfileImage == ""{
                            
                        }
                        else{
                            UserDefaults.standard.set(ProfileImage, forKey: "IMAGE")
                            let URL = NSURL(string:(ProfileImage as? String)!)
                            let data = NSData(contentsOf: URL! as URL)
                            self.imgProfile.image =  UIImage(data: data! as Data)
                        }
                        
                        if let designationDict = responseJASON["Designation"].dictionaryObject as? NSDictionary{
                            if let designationName = designationDict.value(forKey: "Name") as? String{
                                self.companyName = designationName
                            }
                        }
                        
                        
                        let CompanyName = responseJASON["CompanyName"].stringValue as? String ?? ""
                        self.companyName = "\(self.companyName), \(CompanyName)\n"
                        let TotalWorkingExperience = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                        let years = TotalWorkingExperience/12
                        let months = TotalWorkingExperience%12
                        
                        let UserName = responseJASON["UserName"].stringValue as? String ?? ""
                        let email = "\(responseJASON["Email"].stringValue as? String ?? "")"
                        self.headerLblObj.attributedText = UpdateUIClass.updateSharedInstance.updateMentorHeaderLabel(Name,"\(self.companyName)\(email)\n\(years) Years \(months) month experience \n \(UserName)")
                        
                        self.lblHeaderNameRef.text = Name
                        
                        print(dataArr)
                         self.tblHeight.constant = self.mentorProfile_TableView.contentSize.height
                        self.mentorProfile_TableView.reloadData()
                     //   self.intialSetup()
                    }
                    
                }else{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                }
                
            },
                                      failure: { (error,responseCode) in
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

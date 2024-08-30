//
//  MyProfileExtension.swift
//  SignOn
//
//  Created by Callsoft on 20/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

//MARK: - Custom methods extension

extension MyProfileVC:UIScrollViewDelegate{
    
func updateHeaderViewMethod()  {
    
    }
    
    func setDataMethod() {
   
        
    }
    
    func initialSetup(){
        tblJobPreferences.register(UINib(nibName: "JobPrefrencesTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "JobPrefrencesTableViewCellAndXib")
        tblCarrierProfile.register(UINib(nibName: "JobPrefrencesTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "JobPrefrencesTableViewCellAndXib")
        tblPersonalDetails.register(UINib(nibName: "JobPrefrencesTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "JobPrefrencesTableViewCellAndXib")
        
        appliedJobsAPI()
    }
    
   
    
    //TODO: Method didScroll
    
    func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        
        var newHeight = heightConstraint.constant + diff
        print(newHeight)
        
        if newHeight < 74 {
            newHeight = 74
            lblHeaderNameRef.isHidden = false
            imgViewHeaderMain.isHidden = false
            imgProfile.isHidden = true
        } else if newHeight >= 300 { // or whatever
            newHeight = 300
            self.lblPhone.isHidden = false
            self.lblEmail.isHidden = false
            lblHeaderNameRef.isHidden = true
            imgViewHeaderMain.isHidden = true
            imgProfile.isHidden = false
        }else if newHeight < 300{
            self.lblPhone.isHidden = true
            self.lblEmail.isHidden = true
        }
            //For show hide image profile
      
        heightConstraint.constant = newHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
}


extension MyProfileVC {
    func appliedJobsAPI() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            //GET https://portal.signon.co.in/api/v1/candidates/12893
            
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
            alamoFireObj.getRequestURL("/candidates/\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    
                    
                    
                    if self.educationArr.count > 0{
                        self.educationArr.removeAll()
                    }
                    
                    if self.carrierProfileArr.count > 0{
                        self.carrierProfileArr.removeAll()
                    }
                    
                    if self.personalDetailsArr.count > 0{
                        self.personalDetailsArr.removeAll()
                    }
                    
                    
                    
                    var rname = String()
                    print(responseJASON)
                    
                    if let Name = responseJASON["Name"].stringValue as? String{
                        rname = Name
                        UserDefaults.standard.set(rname, forKey: "NAME")
                        
                     }
                    
                     let totalExp = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                    
                  
                    
                    let expSalary = responseJASON["AnnualSalary"].doubleValue as? Double ?? 0
                
                    if let profileImage = responseJASON["ProfileImage"].dictionaryObject as? NSDictionary{
                        if let url = profileImage.value(forKey: "Url") as? String{
                            if url == ""{
                                
                            }
                            else{
                                UserDefaults.standard.set(url, forKey: "IMAGE")
                                //                                    let URL = NSURL(string:(url as? String)!)
                                //                                    let data = NSData(contentsOf: URL! as URL)
                                
                                self.imgProfile.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "groupicon"))
                            }
                            
                            
                            
                        }
                    }

                    let email = responseJASON["Email"].stringValue as? String ?? ""
                    
                    let mobile = responseJASON["UserName"].stringValue as? String ?? ""
                    
                    let bio = responseJASON["Bio"].stringValue as? String ?? ""
                  
                    var doubleStr = String(format: "%.2f", expSalary.truncatingRemainder(dividingBy: 1))
                    print(doubleStr)
                    if doubleStr.hasPrefix("0.0") { // true
                        print("Prefix exists")
                        doubleStr = doubleStr.replacingOccurrences(of: "0.0", with: "")
                    }else{
                        doubleStr = doubleStr.replacingOccurrences(of: "0.", with: "")

                    }
                    
                    if totalExp == 0{
                        self.lblUserDetailsObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("\(rname)", "Not disclosed\n\(Int(floor(expSalary/100000))) Lakhs \(((Int(expSalary) ?? 0 ) % 100000)/1000) Thousands")
                    }else{
 
                        self.lblUserDetailsObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("\(rname)", "\(totalExp/12) Years \(totalExp%12) Months Experience\n\(Int(floor(expSalary/100000))) Lakhs \((Int(expSalary)%100000)/1000) Thousands")
                    }
                    
                    var keySkillsString = String()
                    
                    if let keySkills = responseJASON["Skills"].arrayObject as? NSArray{
                        var keySkillsArray = [String]()
                        for keySkillsItem in keySkills{
                            if let keySkillsDict = keySkillsItem as? NSDictionary{
                                if let keySkillsString = keySkillsDict.value(forKey: "Name") as? String{
                                    keySkillsArray.append(keySkillsString)
                                }
                                
                            }
                        }
                        keySkillsString = keySkillsArray.joined(separator: ",")
                    }
                    
                    print(keySkillsString)
                    
                    if keySkillsString == ""{
                       self.lblKeySkills.text = "No skills added"
                    }else{
                       self.lblKeySkills.text = keySkillsString
                    }
                    
                    
                    
                    
                    
                    
                    self.lblEmail.text = email
                    self.lblPhone.text = mobile
                    self.lblBio.text = bio
                 
                    
                    if let educationArr = responseJASON["EducationProfiles"].arrayObject as? NSArray{
                        var heading = String()
                        var content = String()
                        for educationItem in educationArr{
                            if let educationDict = educationItem as? NSDictionary{
                                if let qualiDict = educationDict.value(forKey: "Qualification") as? NSDictionary{
                                    heading = qualiDict.value(forKey: "Name") as? String ?? ""
                                }
                                
                                if let degreeDict = educationDict.value(forKey: "Degree") as? NSDictionary{
                                    content = degreeDict.value(forKey: "Name") as? String ?? ""
                                    print(content)
                                }
                                
                                content.append(contentsOf: ", \(educationDict.value(forKey: "InstitutionName") as? String ?? "")")
                                print(content)
                                
                                content.append(contentsOf: ", \(educationDict.value(forKey: "PassingYear") as? Int ?? 0)")
                                print(content)
                                
                                if let courseDict = educationDict.value(forKey: "Course") as? NSDictionary{
                                    content.append(", \(courseDict.value(forKey: "Name") as? String ?? "")")
                                }
                            }
                            
                            let educationModelItem = EducationProfileDataModel(title: heading, subtitle: content)
                            self.educationArr.append(educationModelItem)
                        }
                        
                        self.heightTblEducation?.constant = self.tblJobPreferences.contentSize.height
                        self.tblJobPreferences.reloadData()
                    }
                    

                    if let employementArr = responseJASON["Employments"].arrayObject as? NSArray{
                        if employementArr.count > 0{
                            
                            var heading1 = NSMutableAttributedString()
                            
                            
                            for item in 0..<employementArr.count{
                                
                                if let employementDict = employementArr[item] as? NSDictionary{
                                    let startMonth = employementDict.value(forKey: "StartMonth") as? Int ?? 0
                                    let endMonth = employementDict.value(forKey: "EndMonth") as? Int ?? 0
                                    let endYear = employementDict.value(forKey: "EndYear") as? Int ?? 0
                                    var endString = String()
                                    if endMonth == 0 || endYear == 0{
                                        endString = "Till Present"
                                    }else{
                                        endString = "\(MacrosForAll.sharedInstanceMacro.returnMonth(month: endMonth)) \(endYear)"
                                    }
                                    
                                    
                                    if item == employementArr.count - 1{
                                         heading1.append((UpdateUIClass.updateSharedInstance.updateEmailFoneTitleLabel1("\(employementDict.value(forKey: "Designation") as? String ?? "")","\(employementDict.value(forKey: "CompanyName") as? String ?? "")\n\(MacrosForAll.sharedInstanceMacro.returnMonth(month: startMonth)) \(employementDict.value(forKey: "StartYear") as? Int ?? 0) - \(endString)\n \(employementDict.value(forKey: "SpecialProjects") as? String ?? "")\n\nADD MORE EMPLOYEMENT")))
                                    }else{
                                        heading1.append((UpdateUIClass.updateSharedInstance.updateEmailFoneTitleLabel1("\(employementDict.value(forKey: "Designation") as? String ?? "")","\(employementDict.value(forKey: "CompanyName") as? String ?? "")\n\(MacrosForAll.sharedInstanceMacro.returnMonth(month: startMonth)) \(employementDict.value(forKey: "StartYear") as? Int ?? 0) - \(endString)\n \(employementDict.value(forKey: "SpecialProjects") as? String ?? "")\n\n")))
                                    }
                                    
                                    
                                    
                                }
                                
                               
                            }
                            self.lblEmployemetObj.attributedText = heading1
                            
//                            if let employementDict = employementArr.object(at: 0) as? NSDictionary{
//                                let startMonth = employementDict.value(forKey: "StartMonth") as? Int ?? 0
//                                let endMonth = employementDict.value(forKey: "EndMonth") as? Int ?? 0
//                                let endYear = employementDict.value(forKey: "EndYear") as? Int ?? 0
//                                var endString = String()
//                                if endMonth == 0 || endYear == 0{
//                                    endString = "Till Present"
//                                }else{
//                                    endString = "\(MacrosForAll.sharedInstanceMacro.returnMonth(month: endMonth)) \(endYear)"
//                                }
//
//                                self.lblEmployemetObj.attributedText = UpdateUIClass.updateSharedInstance.updateEmailFoneTitleLabel1("\(employementDict.value(forKey: "Designation") as? String ?? "")","\(employementDict.value(forKey: "CompanyName") as? String ?? "")\n\(MacrosForAll.sharedInstanceMacro.returnMonth(month: startMonth)) \(employementDict.value(forKey: "StartYear") as? Int ?? 0) - \(endString)\n \(employementDict.value(forKey: "SpecialProjects") as? String ?? "")\n\nADD MORE EMPLOYEMENT")
//
//
//                            }
                        }
                    }
                    
                    
                    
                   print(self.lblEmployemetObj.text!)
                    
                    //CODE BY AMAN
                    
                    if let Roles = responseJASON["Role"].dictionaryObject as? NSDictionary{
                       let keySkillsString = Roles.value(forKey: "Name") as? String ?? "No Role Added"
                        if keySkillsString == ""{
                             self.carrierProfileArr.append(EducationProfileDataModel(title: "Role", subtitle: "No Role Added"))
                        }
                        else{
                             self.carrierProfileArr.append(EducationProfileDataModel(title: "Role", subtitle: keySkillsString))
                            }
                        
                    }else{
                        self.carrierProfileArr.append(EducationProfileDataModel(title: "Role", subtitle: "No Role Added"))
                    }
            
                    
                    if let FunctionalArray = responseJASON["FunctionalArea"].dictionaryObject as? NSDictionary{
                        let keySkillsString = FunctionalArray.value(forKey: "Name") as? String ?? "No Functional Area Added"
                        if keySkillsString == ""{
                            self.carrierProfileArr.append(EducationProfileDataModel(title: "Functional Area", subtitle: "No Functional Area Added"))
                        }
                        else{
                            self.carrierProfileArr.append(EducationProfileDataModel(title: "Functional Area", subtitle: keySkillsString))
                        }
                        
                    }else{
                         self.carrierProfileArr.append(EducationProfileDataModel(title: "Functional Area", subtitle: "No Functional Area Added"))
                    }
                    
                    
                    
                    
                    if let industries = responseJASON["Industry"].dictionaryObject as? NSDictionary{
                        var Name = industries.value(forKey: "Name") as? String ?? "No Industry Added"
                        if Name == ""{
                            Name = "No Industry Added"
                        }
                        else{
                            self.carrierProfileArr.append(EducationProfileDataModel(title: "Industry", subtitle: Name))
                        }
                        
                    }
                    
                    var jobTypeString = "No Job Type Added"
                    if let jobType = responseJASON["JobTypes"].intValue as?  Int{
                        if jobType == 0{
                            jobTypeString = "Permanent"
                        }else if jobType == 1{
                            jobTypeString = "Temporary"
                        }else{
                            jobTypeString = "Permanent or Temporary"
                        }
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Desired Job Type", subtitle: jobTypeString))
                    
                    
                    var emplTypeString = "No Employment Type Added"
                    if let jobType = responseJASON["EmploymentTypes"].intValue as?  Int{
                        if jobType == 0{
                            emplTypeString = "FullTime"
                        }else if jobType == 1{
                            emplTypeString = "PartTime"
                        }else{
                            emplTypeString = "FullTime or PartTime"
                        }
                    }

                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Desired Employment", subtitle: emplTypeString))

                    var locStringArray = [String]()
                    if let locArray = responseJASON["PreferredLocations"].arrayObject as? NSArray{
                        
                        for keywordsItem in locArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    locStringArray.append(keyWordString)
                                }
                            }
                        }
                    }
                    
                    var locString = String()
                    
                    if locStringArray.count > 0{
                    
                     locString = locStringArray.joined(separator: " ")
                        
                    }else{
                        locString = "No Desired Location Added"
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Desired Location", subtitle: locString))
                    
                    
                    var toolStringArray = [String]()
                    if let toolsArray = responseJASON["Tools"].arrayObject as? NSArray{
                        
                        for keywordsItem in toolsArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    toolStringArray.append(keyWordString)
                                }
                            }
                        }
                    }
                    else{
                        
                    }
                    
                    var toosString = String()
                    if toolStringArray.count > 0{
                        toosString = toolStringArray.joined(separator: " ")
                        
                    }else{
                        toosString = "No Tools Added"
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Tools Worked On", subtitle: toosString))
                    
                    
                    var regiStringArray = [String]()
                    if let toolsArray = responseJASON["RegionsServes"].arrayObject as? NSArray{
                        
                        for keywordsItem in toolsArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    regiStringArray.append(keyWordString)
                                }
                            }
                        }
                    }
                    
                    
                    var regiString = String()
                    if regiStringArray.count > 0{
                        regiString = regiStringArray.joined(separator: " ")
                        
                    }else{
                        regiString = "No Region Added"
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Regions Served", subtitle: regiString))
                    
                    
                    let certi = responseJASON["Certification"].stringValue as?  String ?? "No Certificates Added"
                    
                    if certi != ""{
                        self.carrierProfileArr.append(EducationProfileDataModel(title: "Special Certificates", subtitle: certi))
                    }else{
                        self.carrierProfileArr.append(EducationProfileDataModel(title: "Special Certificates", subtitle: "No Certificates Added"))
                    }
                    
                    
                    
                    
                    let workPermit = responseJASON["HasWorkPermit"].intValue as?  Int ?? 1
                    
                    var workString = String()
                    if workPermit != 1{
                        workString = "No"
                    }else{
                        workString = "Yes"
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Work Permit Outside India", subtitle: workString))
                    
                    
                    let valPass = responseJASON["HasValidPassport"].intValue as?  Int ?? 1
                    
                    var passString = String()
                    if valPass != 1{
                        passString = "No"
                    }else{
                        passString = "Yes"
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Valid Passport", subtitle: passString))
                    
                    
                    let valVisa = responseJASON["IsValidVisa"].intValue as?  Int ?? 1
                    
                    var visaString = String()
                    if valVisa != 1{
                        visaString = "No"
                    }else{
                        visaString = "Yes"
                    }
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "Valid Visa", subtitle: visaString))
                    
                    let directRepo = responseJASON["DirectRepotees"].intValue as?  Int ?? 0
                    
                    let IndirectRepo = responseJASON["IndirectRepotees"].intValue as?  Int ?? 0
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "No of Direct Reportees", subtitle: "\(directRepo)"))
                    
                    self.carrierProfileArr.append(EducationProfileDataModel(title: "No of Indirect Reportees", subtitle: "\(IndirectRepo)"))
                    
                    
                    let NoticePeriod = responseJASON["NoticePeriod"].stringValue as? String ?? "N/A"
                    
                    if NoticePeriod != ""{
                        self.carrierProfileArr.append(EducationProfileDataModel(title: "Notice Period", subtitle: "\(NoticePeriod)"))
                    }else{
                       self.carrierProfileArr.append(EducationProfileDataModel(title: "Notice Period", subtitle: "N/A"))
                    }
                    
                    
                    self.heightCarrierProfile?.constant = self.tblCarrierProfile.contentSize.height
                    self.tblCarrierProfile.reloadData()
                    
                    
                
                    if let Resume = responseJASON["Resume"].dictionaryObject as? NSDictionary{
                        
                        if let name = Resume.value(forKey: "Name") as? String{
                             self.lblResume.text = name
                        }else{
                            self.lblResume.text = "No Resume Added"
                        }
                        
                    }else{
                    }
                   
                    
                    let dob = responseJASON["Dob"].stringValue as? String ?? "2019-05-21T11:38:52"
                    
                    let newString = dob.replacingOccurrences(of: "T", with: " ", options: .literal, range: nil)
                    if newString != ""{
                        if let myDateString = newString as? String {
                            
                            print(myDateString)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let myDate = dateFormatter.date(from: myDateString)!
                            
                            dateFormatter.dateFormat = "dd/MM/YYYY"
                            let somedateString = dateFormatter.string(from: myDate)
                            
                            self.personalDetailsArr.append(EducationProfileDataModel(title: "Date Of Birth", subtitle: "\(somedateString)"))
                        }
                    }
                   

                    
                   let gen = responseJASON["Gender"].intValue as?  Int ?? 0
                    
                    var genString = String()
                    if gen == 0{
                        genString = "Male"
                    }else{
                        genString = "Female"
                    }
                    self.personalDetailsArr.append(EducationProfileDataModel(title: "Gender", subtitle: "\(genString)"))
                    
                    
                    let merSt = responseJASON["MaritalStatus"].intValue as?  Int ?? 0
                    
                    var MerString = String()
                    if merSt == 0{
                        MerString = "Single"
                    }else{
                        MerString = "Married"
                    }
                    self.personalDetailsArr.append(EducationProfileDataModel(title: "Marital Status", subtitle: "\(MerString)"))
                    
                    if let addressDict = responseJASON["Address"].dictionaryObject as? NSDictionary{
                        let addressString = "\(addressDict.value(forKey: "Line1") as? String ?? "") \(addressDict.value(forKey: "Line2") as? String ?? "") \(addressDict.value(forKey: "Landmark") as? String ?? "")  \(addressDict.value(forKey: "City") as? String ?? "") \(addressDict.value(forKey: "State") as? String ?? "") \(addressDict.value(forKey: "Country") as? String ?? "") \(addressDict.value(forKey: "Pincode") as? String ?? "")"
                        self.personalDetailsArr.append(EducationProfileDataModel(title: "Address", subtitle: "\(addressString)"))
                    }
                    
                    let IsPhysicallyChallenged = responseJASON["IsPhysicallyChallenged"].intValue as?  Int ?? 1
                    
                    var IsPhysicallyChallengedString = String()
                    if IsPhysicallyChallenged != 1{
                        IsPhysicallyChallengedString = "No"
                    }else{
                        IsPhysicallyChallengedString = "Yes"
                    }
                    
                    self.personalDetailsArr.append(EducationProfileDataModel(title: "Physically Challenged", subtitle: IsPhysicallyChallengedString))
                    
                    self.heightTblEducation?.constant = self.tblJobPreferences.contentSize.height
                    self.heightPersonal?.constant = self.tblPersonalDetails.contentSize.height
                    self.heightCarrierProfile?.constant = self.tblCarrierProfile.contentSize.height
                    self.tblPersonalDetails.reloadData()
                    self.tblCarrierProfile.reloadData()
                    self.tblJobPreferences.reloadData()
                    
                    self.macroObj.hideLoader()
                    
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
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    func getDateFromString(dateStr: String) -> (date: Date?,conversion: Bool)
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let dateComponentArray = dateStr.components(separatedBy: "/")
        
        if dateComponentArray.count == 3 {
            var components = DateComponents()
            components.year = Int(dateComponentArray[2])
            components.month = Int(dateComponentArray[1])
            components.day = Int(dateComponentArray[0])
            components.timeZone = TimeZone(abbreviation: "GMT+0:00")
            guard let date = calendar.date(from: components) else {
                return (nil , false)
            }
            
            return (date,true)
        } else {
            return (nil,false)
        }
        
    }
    
}

//MARK: - TableView dataSource and delegates extension
extension MyProfileVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblJobPreferences{
        return educationArr.count
        }else if tableView == self.tblCarrierProfile{
            return carrierProfileArr.count
        }else{
            return personalDetailsArr.count
        }
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblJobPreferences{
        let cell = tblJobPreferences.dequeueReusableCell(withIdentifier: "JobPrefrencesTableViewCellAndXib", for: indexPath) as! JobPrefrencesTableViewCellAndXib
        cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateJobPreferencesLabel(educationArr[indexPath.row].title, educationArr[indexPath.row].subtitle)
        return cell
        }else if tableView == self.tblCarrierProfile{
            let cell = tblJobPreferences.dequeueReusableCell(withIdentifier: "JobPrefrencesTableViewCellAndXib", for: indexPath) as! JobPrefrencesTableViewCellAndXib
            cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateJobPreferencesLabel(carrierProfileArr[indexPath.row].title, carrierProfileArr[indexPath.row].subtitle)
            return cell
        }else{
            let cell = tblPersonalDetails.dequeueReusableCell(withIdentifier: "JobPrefrencesTableViewCellAndXib", for: indexPath) as! JobPrefrencesTableViewCellAndXib
            cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateJobPreferencesLabel(personalDetailsArr[indexPath.row].title, personalDetailsArr[indexPath.row].subtitle)
            return cell
        }
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblJobPreferences{
        self.heightTblEducation?.constant = tblJobPreferences.contentSize.height
        }else if tableView == self.tblCarrierProfile{
        self.heightCarrierProfile?.constant = tblCarrierProfile.contentSize.height
        }else{
        self.heightPersonal?.constant = tblPersonalDetails.contentSize.height
        }
    }
    
}

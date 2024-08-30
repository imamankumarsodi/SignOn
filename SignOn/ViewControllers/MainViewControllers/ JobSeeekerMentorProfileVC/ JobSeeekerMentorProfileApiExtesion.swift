
//
//   JobSeeekerMentorProfileApiExtesion.swift
//  
//
//  Created by Callsoft on 13/05/19.
//

import Foundation
extension JobSeeekerMentorProfileVC:UIImagePickerControllerDelegate{
    
    //Mark: Validation of TextFieldMetod
    
    func validationSetup()->Void {
        var message = ""
        if !validation.validateBlankField(txtFullName.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterFullName.rawValue
        }  else if !validation.validateBlankField(txtEmail.text!){
            message = MacrosForAll.VALIDMESSAGE.EmailAddressNotBeBlank.rawValue
        }
        else if !validation.validateBlankField(txtDob.text!){
            message = MacrosForAll.VALIDMESSAGE.DateOfBirth.rawValue
        }
        else if !validation.validateBlankField(txtLine1.text!){
            message = MacrosForAll.VALIDMESSAGE.Line1.rawValue
        }
        else if !validation.validateBlankField(txtCity.text!){
            message = MacrosForAll.VALIDMESSAGE.City.rawValue
        }
        else if !validation.validateBlankField(txtState.text!){
            message = MacrosForAll.VALIDMESSAGE.State.rawValue
        }
        else if !validation.validateBlankField(txtCountry.text!){
            message = MacrosForAll.VALIDMESSAGE.Country.rawValue
        }
        else if !validation.validateBlankField(txtPinCode.text!){
            message = MacrosForAll.VALIDMESSAGE.Pincode.rawValue
        }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            
            
            
            JobseekarManageProfileApiMethod()
        }
    }
    
    ///////----------------------------------------------------------------------->>>>>>>>>>>>>
    
    //Mark: Data SearchMethodApi
    
    
    func dataForSearchTap(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            let passDict = ["fields":["*"],"filter":"DataType=1","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJson)
                    if self.industryExpertiseArr.count > 0{
                        self.industryExpertiseArr.removeAll()
                    }
                    
                    if self.industryExpertiseIdArr.count > 0{
                        self.industryExpertiseIdArr.removeAll()
                    }
                    
                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
                        for item in dataArr{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.industryExpertiseArr.append(Name)
                                self.industryExpertiseIdArr.append(String(Id))
                                
                            }
                        }
                    }
                    
                    
                    self.jobSeakerManagePersonalProfileApi()
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
    
    //Mark: AppliedJobsCountCountNumberMethod Call
    
    func jobSeakerManagePersonalProfileApi() {
        
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
            alamObject.getRequestURL( "\(APIName.firstGetAllHomeData)/\(userID)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    print(responseJASON)
                    
                    let Name = responseJASON["Name"].stringValue as? String ?? ""
                    let Email = responseJASON["Email"].stringValue as? String ?? ""
                    let UserName = responseJASON["UserName"].stringValue as String ?? ""
                    userProfileName = Name
                    self.txtFullName.text! = Name
                    self.txtEmail.text!  = Email
                    self.txtPhoneNumber.text! = UserName
                    
                    
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
        }else{
            
            //LODER HIDE
            self.macroObj.hideLoader()
            
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
        }
    }
    
    
    ////////////////----------------------------------------------->>>>>>>>>>>>>>>>>>
    
    
    //Mark: ImageApiCall Method
    
    func ImageApiCall(passDictData:[String:AnyObject]?)  {
        var token = String()
        var userID =  String()
        if let userInfo = realm.objects(LoginDataModal.self).first{
            token = userInfo.token
            userID = userInfo.Id
        }
        let header = [
            "Content-Type": "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        
        let passDict = ["filename":self.filename] as? [String:AnyObject]
        
        print("PASSDICT", passDict)
        macroObj.showLoader(view: self.view)
        let imgData  =  UserDefaults.standard.value(forKey: "IMG_DATA") as! NSData
        alamObject.postRequestURLWithFile(imageData: imgData, fileName: self.filename, imageparam: "image", urlString: "\(APIName.sendImage)/\(userID)/files", parameters: passDict, headers: header, success: { (resJSON) in
            self.macroObj.hideLoader()
            print(resJSON)
            UserDefaults.standard.removeObject(forKey: "IMG_DATA")
            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManagePFLEducationVC") as! ManagePFLEducationVC
            home.passDict = passDictData!
            self.navigationController?.pushViewController(home, animated: true)
            
        }) { (eror) in
            print(eror)
            self.macroObj.hideLoader()
        }
    }
    
    
    func resumeApiCall(passDictData:[String:AnyObject]?)  {
        var token = String()
        var userID =  String()
        if let userInfo = realm.objects(LoginDataModal.self).first{
            token = userInfo.token
            userID = userInfo.Id
        }
        let header = [
            "Content-Type": "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        
        let passDict = ["filename":self.resumeName] as? [String:AnyObject]
        
        print("PASSDICT", passDict)
        macroObj.showLoader(view: self.view)
        let imgData  =  UserDefaults.standard.value(forKey: "RES_DATA") as! NSData
        alamObject.postRequestURLWithFile(imageData: imgData, fileName: self.resumeName, imageparam: "resume", urlString: "\(APIName.sendImage)/\(userID)/files", parameters: passDict, headers: header, success: { (resJSON) in
            self.macroObj.hideLoader()
            print(resJSON)
            UserDefaults.standard.removeObject(forKey: "RES_DATA")
            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManagePFLEducationVC") as! ManagePFLEducationVC
            home.passDict = passDictData!
            self.navigationController?.pushViewController(home, animated: true)
            
        }) { (eror) in
            self.macroObj.hideLoader()
            print(eror)
        }
    }

    
    func ImageResumeApiCall(passDictData:[String:AnyObject]?)  {
        var token = String()
        var userID =  String()
        if let userInfo = realm.objects(LoginDataModal.self).first{
            token = userInfo.token
            userID = userInfo.Id
        }
        let header = [
            "Content-Type": "application/json",
            "Authorization" : "Bearer \(token)"
        ]
        
        let passDict = ["filename":self.filename] as? [String:AnyObject]
        
        print("PASSDICT", passDict)
        macroObj.showLoader(view: self.view)
        
        let imgData  =  UserDefaults.standard.value(forKey: "IMG_DATA") as! NSData
        
        alamObject.postRequestURLWithFile(imageData: imgData, fileName: self.filename, imageparam: "image", urlString: "\(APIName.sendImage)/\(userID)/files", parameters: passDict, headers: header, success: { (resJSON) in
            print(resJSON)
            self.macroObj.hideLoader()
            UserDefaults.standard.removeObject(forKey: "IMG_DATA")
            self.resumeApiCall(passDictData:passDictData!)
            
        }) { (eror) in
            print(eror)
            self.macroObj.hideLoader()
        }
    }
    
    
    //////////////////-------------------------------------------------->>>>>>>>>>>>>>>>>>>>
    
    //Mark: ImagePickerMethod Here
    
    
    func camera(){


        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)

            cameraValue = 1

        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }


    func photoLibrary() {
        cameraValue = 0
        //        imagePicker.sourceType = .photoLibrary
        //        present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }


    func showImagePicker(){

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){

            actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in

                self.camera()

            }))

            actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in

                self.photoLibrary()

            }))

        }else {

            actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in

                self.photoLibrary()
            }))
        }

        actionSheet.addAction(UIAlertAction(title:"Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad{

            let popup = UIPopoverController(contentViewController: actionSheet)

            popup.present(from: CGRect(), in: self.view!, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)

        }else{

            self.present(actionSheet, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]) {

        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if cameraValue == 1{
            var selectedImage: UIImage!
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = image
                if (picker.sourceType == UIImagePickerController.SourceType.camera) {
                    imageData = selectedImage.jpegData(compressionQuality: 0.5)!  as NSData
                    UserDefaults.standard.set(imageData, forKey: "IMG_DATA")
                    let imgName = UUID().uuidString
                    let documentDirectory = NSTemporaryDirectory()
                    let localPath = documentDirectory.appending(imgName)
                    imageData.write(toFile: localPath, atomically: true)
                    let photoURL = URL.init(fileURLWithPath: localPath).lastPathComponent
                    let theFileName = URL(fileURLWithPath: #file).lastPathComponent
                    filename = photoURL
                    print(photoURL)
                    profileImgPath.text = "Profile Image\n\(photoURL)"
                    cameraValue = 0
                }
            }
        }else{
            
            if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageData = chosenImage.jpegData(compressionQuality: 0.5)!  as NSData
                UserDefaults.standard.set(imageData, forKey: "IMG_DATA")
                let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
                print(imageURL)
                let path = imageURL.path!
                filename = path
                profileImgPath.text = "Profile Image\n\(path)"
                print("path of image is",path)
            } else{
                print("Something went wrong")
            }

        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)

    }

    //Mark: SaveActionApiCall
    
    /////////////------------------------------------------------------>>>>>>>>>>>>>>>>>>
    
    //MArk: MentorMangaeProfileApiCall
    
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
     
            let addressDict = ["City":self.txtCity.text!,
                               "Country":self.txtCountry.text!,
                               "Landmark":txtLandMark.text!,
                               "Line1":txtLine1.text!,
                               "Line2":txtLine2.text!,
                               "Pincode":txtPinCode.text!,
                               "State":txtState.text!]
            var mstatus = Int()
            if txtMarital.text == "Male"{
                mstatus = 0
            }else{
                mstatus = 1
            }
            self.totlalWorkExp = (self.yearId)*12 + self.monthId
            
            print(self.totlalWorkExp)
            
        
            
            
            
            let passDict = ["Address":addressDict,
//                            "Bio":"",
                            "CandidateIndustryId":self.indusryId,
//                            "DirectRepotees":0,
                            "Dob":txtDob.text!,
//                            "EducationProfiles":[],
//                            "EmploymentTypes":0,
//                            "Employments":[],
                            "Gender":self.genderStatus,
//                            "HasValidPassport":false,
//                            "HasWorkPermit":false,
//                            "IndirectRepotees":0,
//                            "IsPhysicallyChallenged":false,
//                            "IsValidVisa":false,
//                            "JobTypes":0,
//                            "Keywords":[],
                            "MaritalStatus":mstatus,
                            "Mobile":txtPhoneNumber.text!,
//                            "PreferedFunctionalAreaIds":[],
//                            "PreferedIndustryIds":[],
//                            "PreferedKeywordIds":[],
//                            "PreferedLocationIds":[],
//                            "PreferedRoleIds":[],
//                            "PreferredFunctionalAreas":[],
//                            "PreferredIndustries":[],
//                            "PreferredLocations":[],
//                            "PreferredRoles":[],
//                            "ProfileCompleteFactor":0.0,
//                            "ProfileViewCount":0,
//                            "RankingPercentileScore":0.0,
//                            "RegionsServeIds":[],
//                            "RegionsServes":[],
//                            "SkillIds":[],
//                            "Skills":[],
//                            "ToolIds":[],
//                            "Tools":[],
                            "Email":txtEmail.text!,
                            "IsPhoneVerified":true,
                            "Name":txtFullName.text!,
                            "Phone":txtPhoneNumber.text!,
                            "ProfileImageId":Int(),
                            "UserName":txtPhoneNumber.text!,
                            "TotalWorkingExperience":self.totlalWorkExp,
                            "ProfileStatus":Int(),
                            "Id":userID,
                            "Status":Bool(),
                            "FacebookUrl":FacebookUrl,
                            "LinkedinUrl":LinkedinUrl,
                            "GoogleUrl":GoogleUrl] as? [String:AnyObject]
            
            
            
            print("PASSDICT", passDict)
            let header = [
                // "x-api-key": "qfsmWWQsUH7BRD5llP2H270zX1fXTBmG6eU5fWQP",
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
            ]
            
            print(apiname)
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(apiname)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    if (UserDefaults.standard.value(forKey: "IMG_DATA") != nil) && (UserDefaults.standard.value(forKey: "RES_DATA") != nil){
                        self.ImageResumeApiCall(passDictData: passDict!)
                    }else if (UserDefaults.standard.value(forKey: "IMG_DATA") != nil){
                        self.ImageApiCall(passDictData: passDict!)
                    }else if (UserDefaults.standard.value(forKey: "RES_DATA") != nil){
                        self.resumeApiCall(passDictData: passDict!)
                    }else{
                        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManagePFLEducationVC") as! ManagePFLEducationVC
                        home.passDict = passDict!
                        self.navigationController?.pushViewController(home, animated: true)
                    }

                    
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






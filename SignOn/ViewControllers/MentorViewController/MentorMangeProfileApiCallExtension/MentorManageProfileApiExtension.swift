//
//  MentorManageProfileApiExtension.swift
//  SignOn
//
//  Created by Callsoft on 10/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

extension MentorManageProfileVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
 
    // TODO: Validations for all input fields
    
    func validationSetup()->Void{
        var message = ""
        if !validation.validateBlankField(txtFullName.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterFullName.rawValue
        }  else if !validation.validateBlankField(txtEmail.text!){
            message = MacrosForAll.VALIDMESSAGE.EmailAddressNotBeBlank.rawValue
            
        }else if !validation.validateEmail(txtEmail.text!){
            message = MacrosForAll.VALIDMESSAGE.EnterValidEmail.rawValue
        }
//        }else if !validation.validateBlankField(txtPhoneNumber.text!){
//            message = MacrosForAll.VALIDMESSAGE.EnterMobileNumber.rawValue
//        }
        else if !validation.validateBlankField(txt_Desingnation.text){
            message = MacrosForAll.VALIDMESSAGE.DesingnationField.rawValue
        }else if !validation.validateBlankField(txtYears.text){
            message = MacrosForAll.VALIDMESSAGE.Year.rawValue
        }else if !validation.validateBlankField(txtMonth.text){
            message = MacrosForAll.VALIDMESSAGE.Month.rawValue
        }
        //else if !validation.validateBlankField(txtSelectIndustry.text){
           // message = MacrosForAll.VALIDMESSAGE.Month.rawValue
        //}
       else if !validation.validateBlankField(txtProfesionalView.text){
            message = MacrosForAll.VALIDMESSAGE.ProfessionalSummary.rawValue
        }
        if message != "" {
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: message, style: AlertStyle.error)
        }else{
            saveManageProfile()
           //  mentorMAnageProfileApiMethod()
        }
    }
    
    
    
   //////////////////----------------------------------------------->>>>>>>>>>>>>>>>>>

    
    
    //Mark: ImageApiCall Method
    
    func ImageApiCall()  {
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
        macroObj.showLoader(view: self.view)
        let imgData  =  UserDefaults.standard.value(forKey: "IMG_DATA") as! NSData
        alamObject.postRequestURLWithFile(imageData: imageData, fileName: "image", imageparam: "", urlString: "\(APIName.sendImage)/\(userID)/files", parameters: [:] as! [String:AnyObject], headers: header, success: { (resJSON) in
            print(resJSON)
            self.macroObj.hideLoader()
            UserDefaults.standard.removeObject(forKey: "IMG_DATA")
            let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
            self.navigationController?.pushViewController(home, animated: true)
        }) { (eror) in
            self.macroObj.hideLoader()
            print(eror)
        }
     }
    
    
    
    
    
    
  ////////////----------------------------------------------->>>>>>>>>>>>>>>>>>
    
    
    func MentorManagePersonalProfileApi() {
        
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
           // https://beta-signon.azurewebsites.net/api/v1/mentors/1870
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("\(APIName.mentor)/\(userID)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    let Name = responseJASON["Name"].stringValue as? String ?? ""
                    let Email = responseJASON["Email"].stringValue as? String ?? ""
                    let UserName = responseJASON["UserName"].stringValue as String ?? ""
                    
                    self.txtFullName.text! = Name
                    self.txtEmail.text!  = Email
                    self.txtPhoneNumber.text! = UserName
                    self.DeginationSearchApiTap()
                   
                    
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
    
    
    
 /////////////----------------------------------------------->>>>>>>>>>>>>>>>>>
    
    
  
    func saveManageProfile(){
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var token = String()
            var userID =  String()
            var isMentor = Bool()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                isMentor = userInfo.isMentor
            }
            let totalWorkExp = self.yearVariable + self.monthVariable
            print(totalWorkExp)
            let passDict = ["CompanyName":txtCompanyName.text!,
                            "DesignationId":self.desingnatioId,
                            "Email":txtEmail.text!,
                            "Industries":[],
                            "IndustryId":0,
                            "IndustryIds":InduStrArrId,
                            "Name":txtFullName.text!,
                            "ProfessionalSummary":txtProfesionalView.text!,
                            "ProfileImageId":0,
                            "ProfileStatus":0,
                            "Status":false,
                            "TotalWorkingExperience":totalWorkExp,
                            "UserName":txtPhoneNumber.text!,
                            "CreatedAt":"",
                            "Id":userID,
                            "UpdatedAt":""] as [String: AnyObject]
            
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "Authorization" : "Bearer \(token)"
                
            ]
            
            print(passDict)
            print(header)
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.mentor)/\(userID)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    if (UserDefaults.standard.value(forKey: "IMG_DATA") != nil){
                        self.ImageApiCall()
                    }else{
                        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankyouVC") as! ThankyouVC
                        self.navigationController?.pushViewController(home, animated: true)
                    }
                    
                    
                   
                    
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }
                
                
            }) { (error,responseCode) in
                print(error.localizedDescription)
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            }
            
            
        }else{
            //LODER HIDE
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
            
        }
    }
    
     func camera(){
        
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
           cameravalue = 1
            
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func photoLibrary() {
          cameravalue = 0
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        
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
        
      
        if cameravalue == 1{
            var selectedImage: UIImage!
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                selectedImage = image
            } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = image
            }
            // self.provideImageData.image = selectedImage
            
            if (picker.sourceType == UIImagePickerController.SourceType.camera) {
                
                let imgName = UUID().uuidString
                let documentDirectory = NSTemporaryDirectory()
                let localPath = documentDirectory.appending(imgName)
                
                imageData = selectedImage.jpegData(compressionQuality: 0.5)!  as NSData
                print(imageData)
                UserDefaults.standard.set(imageData, forKey: "IMG_DATA")
                imageData.write(toFile: localPath, atomically: true)
                let photoURL = URL.init(fileURLWithPath: localPath).lastPathComponent
                print(photoURL)
                profileImgLbl.text = "Profile Image\n\(photoURL)"
                //ImageApiCall()
                cameravalue = 0
            }
            
        }
        else{
            let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
            let path = imageURL.path!
            profileImgLbl.text = "Profile Image\n\(path)"
            print("path of image is",path)
            
            let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageData = chosenImage.jpegData(compressionQuality: 0.5)  as NSData!
              //  print(imageData)
                //ImageApiCall()
                
            } else{
                print("Something went wrong")
            }
            
        }
        
        
        
        //print("image data array is",arrImageData)
        //Dismiss the UIImagePicker after selection
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    ///////////-------------------------------------------------->>>>>>>>>>>>>>>>>>>>>>>
    
    
    //Mark: DeginationSearchApi
    
    func DeginationSearchApiTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var passDict = Dictionary<String, AnyObject>()
            passDict = ["fields":["*"],"filter":"DataType=16","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as [String : AnyObject]
            print("PASSDICT", passDict)
            
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            //            "https://api.searchtap.io/v1/collections/prod_staticData/query"
             macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    self.DegingNationArr.removeAll()
                    self.DegingNationIdArr.removeAllObjects()                     //  print(responseJson)
                    
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
                                
                                self.DegingNationArr.append(Name)
                                self.DegingNationIdArr.add(String(Id))
                                
                            }
                        }
                         self.dropDown.reloadAllComponents()
                        print("THE NAME ARRAY IS", self.DegingNationArr)
                        print("THE ID ARRAY IS", self.DegingNationIdArr)
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
    
}

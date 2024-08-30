//
//  DrawerController.swift
//  Qualitition
//
//  Created by Callsoft on 11/09/18.
//  Copyright © 2018 Callsoft. All rights reserved.
//

import UIKit
import RealmSwift
import MobileCoreServices

class DrawerController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK:- Variables
    //MARK:-
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   
    
    var name_Array = ["Home", "Profile", "Recommended Jobs", "Current Openings", "Applied Jobs", "News Feeds", "SignOn Feed", "Job Preference", "Message Listing", "Notifications", "Interview", "Mentors", "Refer a friend", "About SignOn", "Change Password", "Logout"]
    
    var imgNamesArray = [UIImage(named: "home"), UIImage(named: "user_new_icon_man"), UIImage(named: "applied_job_icon"), UIImage(named: "user_icon_new_"), UIImage(named: "professional_icon"), UIImage(named: "rss-feed"), UIImage(named: "rss-feed"), UIImage(named: "handshake"), UIImage(named: "_open_mail"), UIImage(named: "bell_icon"), UIImage(named: "interview_icons"), UIImage(named: "user_icon"), UIImage(named: "employee"), UIImage(named: "settings_icon"), UIImage(named: "key"), UIImage(named: "exit_icon")]
    
    
    
    
    var mentorName_Array = ["Home", "Profile","News Feed", "SignOn Feed", "Message Listing", "Notifications", "Refer a friend","About SignOn","Change Password","Logout"]
    
    var mentorImgNamesArray = [UIImage(named: "home"), UIImage(named: "user_new_icon_man"),UIImage(named: "rss-feed"),UIImage(named: "rss-feed"), UIImage(named: "_open_mail"), UIImage(named: "bell_icon"),UIImage(named: "employee"),UIImage(named: "settings_icon"),UIImage(named: "key"), UIImage(named: "exit_icon")]
    
    var storyBoardType = switchStoryBoard()
    
    
    //MARK:- View Life Cycle
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
         initialSetup()
        //jobSeakerManagePersonalProfileApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        initialSetup()
         
}
 
    //TODO: Tableview selectors
}

//Mark: AppliedJobsCountCountNumberMethod Call

extension DrawerController{
    
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
        
     //   macroObj.showLoader(view: self.view)
        
        
        alamObject.getRequestURL("\(APIName.firstGetAllHomeData)/\(userID)", headers: header , success: { (responseJASON,responseCode) in
            
            if responseCode == 200{
               // self.macroObj.hideLoader()
                
                //   print(responseJASON)
                
                
                if let userInfo = self.realm.objects(LoginDataModal.self).first{
                    let Name = userInfo.Name
                    self.userNameLbl.text! = Name
                }
                
                
                let img        = responseJASON["Url"].stringValue as? String ?? ""
                let UserName    = responseJASON["UserName"].stringValue as String ?? ""
                
                self.imgView.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "groupicon"))
                self.tableView.reloadData()
                
            }else{
               // self.macroObj.hideLoader()
                print(responseJASON)
                self.tableView.reloadData()
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
       // self.macroObj.hideLoader()
        
        _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
    }
}
}
//MARK: - Extension tableView Delegates
extension DrawerController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = Int()
        
        if let userInfo = realm.objects(LoginDataModal.self).first{
            if userInfo.isMentor == true{
                count =  mentorName_Array.count
                
            }
            else{
                count = name_Array.count
                }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib(nibName: "sideMenuXib", bundle: nil), forCellReuseIdentifier: "sideMenuXib")
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuXib", for: indexPath) as! sideMenuXib
        if let userInfo = realm.objects(LoginDataModal.self).first{
            if userInfo.isMentor == true{
                cell.lbl_Names.text = mentorName_Array[indexPath.row]
                cell.img_Item.image = mentorImgNamesArray[indexPath.row]
                if indexPath.row == 9{
                    cell.btnCount.isHidden = true
                }else{
                    //cell.btnCount.isHidden = true
                }
            }
            else{
                cell.lbl_Names.text = name_Array[indexPath.row]
                cell.img_Item.image = imgNamesArray[indexPath.row]
                if indexPath.row == 9{
                    cell.btnCount.isHidden = false
                }else{
                    cell.btnCount.isHidden = true
                }
               
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        leftSideBarMethod(index: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
    
    func showActivityController() {
        //        let items: [Any] = ["ForoPina is a place to gain and share knowledge. It's a platform to ask questions and connect with people who contribute unique insights and quality answers\n\n\n", referal_code]
        
        let items: [Any] = ["Refer Freind"]
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        ac.completionWithItemsHandler = { (activity, success, items, error) in
            print(success ? "SUCCESS!" : "FAILURE")
            
            if success == true {
                
                if activity == UIActivity.ActivityType.postToFacebook {
                }
                else if activity == UIActivity.ActivityType.postToTwitter {
                }
                else if activity == UIActivity.ActivityType.mail {
                }
                else if activity == UIActivity.ActivityType.message {
                }
                else if activity == UIActivity.ActivityType.init(rawValue: "com.google.Gmail.ShareExtension") {
                }
                else if activity == UIActivity.ActivityType.init("net.whatsapp.WhatsApp.ShareExtension") {
                }
                else {
                }
                
            }
            else {
                print("Not Success")
            }
            
        }
        present(ac, animated: true)
    }
    
    
    func leftSideBarMethod(index: Int){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if let userInfo = realm.objects(LoginDataModal.self).first{
            if userInfo.isMentor == false{
            switch index {
            case 0:
                 //               _ = appDel.initment()
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 1:
                let myProfile = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
                appDel.drawerController.mainViewController = myProfile
                appDel.drawerController.setDrawerState(.closed, animated: true)
                // let myProfile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileJobSeakerVC") as! ProfileJobSeakerVC
                //appDel.drawerController.mainViewController = myProfile
                break
            case 2:
                let recommendedJobs = self.storyboard?.instantiateViewController(withIdentifier: "RecommendedJobsVC") as! RecommendedJobsVC
                appDel.drawerController.mainViewController = recommendedJobs
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 3:
                let currentOpening = self.storyboard?.instantiateViewController(withIdentifier: "CurrentOpeningVC") as! CurrentOpeningVC
                appDel.drawerController.mainViewController = currentOpening
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 4:
                let applyJobs = self.storyboard?.instantiateViewController(withIdentifier: "AppliedJobsVC") as! AppliedJobsVC
                appDel.drawerController.mainViewController = applyJobs
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 5:
                let newsFeed = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedVC") as! NewsFeedVC
                appDel.drawerController.mainViewController = newsFeed
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 6:
                let signOnFeed = self.storyboard?.instantiateViewController(withIdentifier: "SignOnFeed") as! SignOnFeed
                appDel.drawerController.mainViewController = signOnFeed
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 7:
                let jobPrefrence = self.storyboard?.instantiateViewController(withIdentifier: "JobPreferenceVC") as! JobPreferenceVC
                appDel.drawerController.mainViewController = jobPrefrence
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 8:
                let messageListing = self.storyboard?.instantiateViewController(withIdentifier: "MentorMessageViewController") as! MentorMessageViewController
                appDel.drawerController.mainViewController = messageListing
                appDel.drawerController.setDrawerState(.closed, animated: true)
                
                break
            case 9:
                let notificationList = self.storyboard?.instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
                appDel.drawerController.mainViewController = notificationList
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 10:
                let interviewListing = self.storyboard?.instantiateViewController(withIdentifier: "InterviewsListingVC") as! InterviewsListingVC
                appDel.drawerController.mainViewController = interviewListing
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 11:
                let mentorVC = self.storyboard?.instantiateViewController(withIdentifier: "MentorsVC") as! MentorsVC
                appDel.drawerController.mainViewController = mentorVC
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 12:
                showActivityController()
                print("Open Share Controller")
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 13:
                let aboutUs = self.storyboard?.instantiateViewController(withIdentifier: "AboutusVC") as! AboutusVC
                appDel.drawerController.mainViewController = aboutUs
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            case 14:
                let changePass = UIStoryboard(name: "AuthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                
                appDel.drawerController.mainViewController = changePass
                appDel.drawerController.setDrawerState(.closed, animated: true)
                break
            default:
                
                _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WantToLogout.rawValue, style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "OK", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Cancel Button  Pressed", terminator: "")
                        appDel.drawerController.setDrawerState(.closed, animated: true)
                    }
                    else
                    {
                        if let userInfo = self.realm.objects(LoginDataModal.self).first{
                             userProfileName = ""
                            appDel.drawerController.setDrawerState(.closed, animated: true)
                            UserDefaults.standard.removeObject(forKey: "NAME")
                            UserDefaults.standard.removeObject(forKey: "IMAGE")
                            UserDefaults.standard.synchronize()
                            self.deleteUser(userInfo:userInfo)
                        }
                    }
                }
            }
        //  appDel.drawerController.setDrawerState(.closed, animated: true)
        }else{
            switch index {
            case 0:
               // appDelegate.initHome()
                break
            case 1:
                
                let mentorProfileVC = storyBoardType.MentorStoryBoard.instantiateViewController(withIdentifier: "MentorProfileVC") as! MentorProfileVC
                appDel.drawerController.mainViewController = mentorProfileVC
                
                
            case 2:
                let newsFeed = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedVC") as! NewsFeedVC
                appDel.drawerController.mainViewController = newsFeed
                
                break
            case 3:
                let signonfeed = self.storyboard?.instantiateViewController(withIdentifier: "SignOnFeed") as! SignOnFeed
                appDel.drawerController.mainViewController = signonfeed
                break
            case 4:
                let messageListing = self.storyboard?.instantiateViewController(withIdentifier: "MentorMessageViewController") as! MentorMessageViewController
                appDel.drawerController.mainViewController = messageListing
                break
            case 5:
                let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
                appDel.drawerController.mainViewController = notificationVC
                break
            case 6:
                showActivityController()
                break
            case 7:
                let aboutUs = self.storyboard?.instantiateViewController(withIdentifier: "AboutusVC") as! AboutusVC
                appDel.drawerController.mainViewController = aboutUs
                
                break
            case 8:
                let changePass = UIStoryboard(name: "AuthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                appDel.drawerController.mainViewController = changePass
                
                break
            case 9:
                _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WantToLogout.rawValue, style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "OK", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Cancel Button  Pressed", terminator: "")
                        appDel.drawerController.setDrawerState(.closed, animated: true)
                    }
                    else
                    {
            //            self.LogOutService()
                        UserDefaults.standard.removeObject(forKey: "NAME")
                        UserDefaults.standard.removeObject(forKey: "IMAGE")
                        UserDefaults.standard.synchronize()
                        userProfileName = ""
                        appDel.drawerController.setDrawerState(.closed, animated: true)
                        if let userInfo = self.realm.objects(LoginDataModal.self).first{
                            self.deleteUser(userInfo:userInfo)
                        }
                      
                        
//                        if let userInfo = self.realm.objects(LoginDataModal.self).first{
//                            self.deleteUser(userInfo:userInfo)
//                        }
                    }
                }
                break
            default: break
                
            }
            
            appDel.drawerController.setDrawerState(.closed, animated: true)
        }
    }
    }
}
//MARK:- Custom Functions
//MARK:-
extension DrawerController {
    func LogOutService() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            let passDict = [:] as! [String: AnyObject]
            
            
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
            alamObject.postRequestURL(APIName.login, params: passDict, headers: header, success: { (responseJson,resposeCode) in
                
                print(responseJson)
               
                if let userInfo = self.realm.objects(LoginDataModal.self).first{
                    self.deleteUser(userInfo:userInfo)
                }
                self.macroObj.hideLoader()
                
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


//MARK: - Extension User Defined methods
extension DrawerController{
    func initialSetup(){
        if let userInfo = self.realm.objects(LoginDataModal.self).first{
            let Name = userInfo.Name
            self.userNameLbl.text! = Name
        }
        
        let ProfileImage = UserDefaults.standard.value(forKey: "IMAGE") as? String ?? ""
        if ProfileImage != ""{
//        let URL = NSURL(string:ProfileImage)
//        let data = NSData(contentsOf: URL! as URL)
        imgView.sd_setImage(with: URL(string: ProfileImage), placeholderImage: UIImage(named: "groupicon"))
        }
        else{
           
               // self.imgView
        }
        tableView.tableFooterView = UIView() //remove the line seperator below the field
    }
    
    func deleteUser(userInfo:LoginDataModal){
        do{
            try realm.write {
                realm.delete(userInfo)
                UIApplication.shared.applicationIconBadgeNumber = 0
                let appDel = UIApplication.shared.delegate as! AppDelegate
                _ = appDel.initLoginAtLogOut()
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
//    func deleteUser(userInfo:LoginDataModal){
//        do{
//            try realm.write {
//
//                realm.delete(userInfo)
//                let appDel = UIApplication.shared.delegate as! AppDelegate
//                _ = appDel.initLoginAtLogOut()
//            }
//        }catch{
//            print("Error in saving data :- \(error.localizedDescription)")
//        }
//
//
//        if let userInfo = self.realm.objects(EducationModalExtension.self).first{
//            do{
//                try realm.write {
//                    realm.delete(userInfo)
//                    let appDel = UIApplication.shared.delegate as! AppDelegate
//                    _ = appDel.initLoginAtLogOut()
//                }
//            }catch{
//                print("Error in saving data :- \(error.localizedDescription)")
//            }
//        }
//
//
//    }
}

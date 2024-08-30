//
//  HomeVCExtension.swift
//  SignOn
//
//  Created by Callsoft on 15/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
import SDWebImage
import PrettyTimestamp

//MARK: - TableView dataSource and delegates extension

extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    
    
    
    //Mark: HomeListApi
    
    
    func HomeListApi()  {
        if InternetConnection.internetshared.isConnectedToNetwork() {
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
                alamObject.getRequestURL( "\(APIName.homeNewsFeedList)", headers: header , success: { (responseJASON,responseCode) in
                    
                    
                    if responseCode == 200{
                        self.macroObj.hideLoader()
                        if self.homeNewsFeedListModel.count > 0{
                            self.homeNewsFeedListModel.removeAll()
                        }
                        print(responseJASON)
                        if let dataArr = responseJASON.arrayObject as? NSArray{
                            
                            for item in dataArr{
                                
                                var IdR_Post = Int()
                                var NameR = String()
                                var UserNameR = String()
                                var EmailR = String()
                                var FcmIdsR = String()
                                var UrlR = String()
                                var LikeCountR = Int()
                                var CommentCountR = Int()
                                var messageR = String()
                                var DateR = String()
                                var imgPostR = String()
                                
                                var feedCommentR = String()
                                var feedCommentImgUrlR = String()
                                var feedCommentNameR = String()
                                var feedCommentDateR = String()
                                
                                var isSpamR = Bool()
                                var isLikeR = Bool()
                                var userReactionIdR = Int()
                                var userIDR = Int()
                                
                               if let itemDict = item as? NSDictionary{
                                
                                if let id = itemDict.value(forKey: "Id") as? Int{
                                    IdR_Post = id
                                    print(IdR_Post)
                                }
                                
                                if let CreatedAt = itemDict.value(forKey: "CreatedAt") as? String{
                                    DateR = CreatedAt
                                    print(DateR)
                                }
                                
                                if let message = itemDict.value(forKey: "Message") as? String{
                                    messageR = message
                                    print(message)
                                }
                                
                                if let UserReaction = itemDict.value(forKey: "UserReaction") as? NSDictionary{
                                    print(UserReaction)
                                    
                                    if let isLike = UserReaction.value(forKey: "IsLike") as? Bool{
                                        
                                        isLikeR = isLike
                                    }
                                    
                                    if let isSpam = UserReaction.value(forKey: "IsSpam") as? Bool{
                                        isSpamR = isSpam
                                    }
                                    
                                    if let Id = UserReaction.value(forKey: "Id") as? Int{
                                        userReactionIdR = Id
                                    }
                                    
                                    if let UserId = UserReaction.value(forKey: "UserId") as? Int{
                                        userIDR = UserId
                                    }
                                    
                                }
                                
                                if let cmntCount = itemDict.value(forKey: "CommentCount" ) as? Int{
                            
                                    CommentCountR = cmntCount
                                }
                                
                                if let likeCount = itemDict.value(forKey: "LikeCount" ) as? Int{
                                    LikeCountR = likeCount
                                }
                                
                                if let userDict = itemDict.value(forKey: "User") as? NSDictionary{
                                    if let Name = userDict.value(forKey: "Name") as? String{
                                        
                                        NameR = Name
                                        
                                    }
                                    
                                    if let UserName = userDict.value(forKey: "UserName") as? String{
                                        UserNameR = UserName
                                    }
                                    
                                    if let Email = userDict.value(forKey: "Email") as? String{
                                        EmailR = Email
                                    }
                                   
                                    if let FcmIds = userDict.value(forKey: "FcmIds") as? String{
                                        FcmIdsR = FcmIds
                                    }
                                    
                                    if let ProfileImageDict = userDict.value(forKey: "ProfileImage") as? NSDictionary{
                                        if let Url = ProfileImageDict.value(forKey: "Url") as? String{
                                            UrlR = Url
                                        }
                                    }
                                    
                                }
                                
                                if let attachmentArray = itemDict.value(forKey: "Attachments") as? NSArray{
                                    print(attachmentArray)
                                    if attachmentArray.count > 0{
                                        if let dataDict = attachmentArray.object(at: 0) as? NSDictionary{
                                           if let imgPost = dataDict.value(forKey: "Url") as? String{
                                            imgPostR = imgPost
                                            }
                                        }
                                    }
                                }
                                
                                if let feedCommentArray = itemDict.value(forKey: "FeedComments") as? NSArray{
                                    if feedCommentArray.count > 0{
                                        if let feedCommentDict = feedCommentArray.object(at: 0) as? NSDictionary{
                                           
                                           if let Comment = feedCommentDict.value(forKey: "Comment") as? String{
                                              feedCommentR = Comment
                                            }
                                            
                                            if let Name = feedCommentDict.value(forKey: "Name") as? String{
                                                feedCommentNameR = Name
                                            }
                                            
                                            if let CreatedAt = feedCommentDict.value(forKey: "CreatedAt") as? String{
                                                feedCommentDateR = CreatedAt
                                            }
                                            
                                            if let ProfileImageUrl = feedCommentDict.value(forKey: "ProfileImageUrl") as? String {
                                                feedCommentImgUrlR = ProfileImageUrl
                                            
                                            }
                                            
                                           
                                        }
                                    }
                                }
                                
                                
                            }
                                
                                let homeNewsFeedModelItem = HomeNewsFeedList(id: IdR_Post, name: NameR, userName: UserNameR, email: EmailR, fcmids: FcmIdsR, url: UrlR, likecount: LikeCountR, commentcount: CommentCountR, date: DateR, message: messageR, imgPost: imgPostR, feedComment: feedCommentR, feedCommentImgUrl: feedCommentImgUrlR, feedCommentName: feedCommentNameR, feedCommentDate: feedCommentDateR, isSpam: isSpamR, isLike: isLikeR, userReactionId: userReactionIdR, userID: userIDR)
                                self.homeNewsFeedListModel.append(homeNewsFeedModelItem)
                            }
                            self.tblNewsFeed.reloadData()
                            
                        }
                        
                        self.homeMethodApiCall()
                    }else{
                        
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
    }
    
    //TODO: Home header api call
    func homeMethodApiCall (){
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
            
            //macroObj.showLoader(view: self.view)
            alamObject.getRequestURL( "\(APIName.firstGetAllHomeData)/\(userID)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    
                    if let Name = responseJASON["Name"].stringValue as? String{
                        
                        UserDefaults.standard.set(Name, forKey: "NAME")
                        
                    }
                    
                    if let responseDict = responseJASON.dictionaryObject as? NSDictionary{
                        if let educationArr = responseDict.value(forKey: "EducationProfiles") as? NSArray{
                            print(educationArr)
                            
                            if educationArr.count > 0{
                                if let dataDict = educationArr.object(at: 0) as? NSDictionary{
                                    if let InstitutionName = dataDict.value(forKey: "InstitutionName") as? String{
                                        self.instituteName = InstitutionName
                                    }
                                    if let degree = dataDict.value(forKey: "Degree") {
                                        if let name = (degree as AnyObject).value(forKey: "Name"){
                                            self.degreeName = name as! String
                                            print(degree)
                                        }
                                    }
                                }
                            }
                            
                        }
                        //  AnnualSalary
                        
                        if let profileImage = responseDict.value(forKey: "ProfileImage")as?NSDictionary{
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
                        
                        let annualSalary = responseJASON["AnnualSalary"].intValue as? Int ?? 0
                        if annualSalary != 0{
                            print(annualSalary)
                        }
                        let totalExp = responseJASON["TotalWorkingExperience"].intValue as? Int ?? 0
                        
                        let totalExperieced =  Int(totalExp)
                        let Year    =   totalExperieced / 12
                        let month   =    totalExperieced % 12
                        self.experienceName.0 = (Year)
                        self.experienceName.1 = (month)
                        print(self.experienceName)
                        
                        
                        let profileComplete = responseDict.value(forKey: "ProfileCompleteFactor") as? Int ?? 0
                        
                        if profileComplete == 0{
                            self.lblProfileCompletenessObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nPROFILE\nCOMPLETENESS", "0 %")
                        }
                        else{
                            self.profilrComlpeteFactor = Int(profileComplete)
                            self.profileComlpeteFactorIncrementLabel(to: self.profilrComlpeteFactor)
                        }
                        
                        
                        let SignonScore = responseDict.value(forKey: "RankingPercentileScore") as? Int ?? 0
                        
                        if SignonScore == 0{
                            self.lblSignOnScoreObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nSIGNON\nSCORE", "\("0")")
                        }
                        else{
                            self.signOnScore = Int(SignonScore)
                            self.signOnScoreIncrementLabel(to: self.signOnScore)
                        }
                        
                        
                        let profileViewResult = responseDict.value(forKey: "ProfileViewCount") as? Int ?? 0
                        
                        if profileViewResult  == 0{
                            self.lblProfileViewObj.attributedText! = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nPROFILE\nVIEWS", "\("0") ")
                        }else{
                            self.profileViewCount = Int(profileViewResult)
                            self.profileViewCountIncrementLabel(to: self.profileViewCount)
                        }
                        
                        
                        let languageScore = responseDict.value(forKey: "VersantScore") as? Int ?? 0
                        if languageScore == 0{
                            self.lblLanguageScoreObj.attributedText! = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nLANGUAGE\nSCORE", "\("0") / 10")
                        }
                        else{
                            self.langScore =  languageScore
                            self.langaugeScoretIncrementLabel(to: self.langScore)
                        }
                        
                        self.initialSetup()
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
    
    
    //////////////////////////////////------------------------>>>>
    
    //Mark: RecomendedJobCountNumberMethod Call
    
    func
        recommendedJobCountMethod() {
        
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
            alamObject.getRequestURL( "\(APIName.recomendedCount)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    let JobCount = responseJASON["JobCount"].stringValue as? String ?? "0"
                    self.recommendedJobsCount = String(JobCount)
                    self.btnRecomented.setTitle("\(self.recommendedJobsCount)", for: .normal)
                    self.AppliedJobCountMethod()
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
    
    
    
    //Mark: AppliedJobsCountCountNumberMethod Call
    
    func AppliedJobCountMethod() {
        
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
            alamObject.getRequestURL( "\(APIName.AppliedJobsCount)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    let JobCount = responseJASON["JobCount"].stringValue as? String ?? "0"
                    self.appliedJobsCount = String(JobCount)
                    self.appliedJobs_Btn.setTitle("\(self.appliedJobsCount)", for: .normal)
                    self.dataForSearchTap()
                    
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
    
    
    func dataForSearchTap(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["fields":["*"],
                            "filter":"IsCertificationJob=0 AND Status=1",
                            "offset":0,
                            "pageSize":200,
                            "query":"",
                            "searchFields":["*"],
                            "sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b20817a7a558ec0adeb7777801bf7973a0be3fa908686b2f72274b46c74ed9e9e9946f041de883c033ad207dd046bcf40af62700c0caf45493bccd3474beab4cf5bcba4c4e13f12b44c9d9485c8a1b66040a1f532c5248b8382d4e9e7baa7edae899a8b09db9069c10809772c94f94860a13d433f57bfa6305a0b0b7364a7a75"
            ]
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/jobs-prod/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    if self.currentOpeningArr.count > 0{
                        self.currentOpeningArr.removeAll()
                    }
                    if let dataArray = responseJson["results"].arrayObject as? NSArray{
                        self.currentOpeningCount = String(dataArray.count)
                        self.currentOpeningBtn.setTitle(self.currentOpeningCount, for: .normal)
                        if dataArray.count > 0{
                            if let dataDict = dataArray.object(at: 0) as? NSDictionary{
                                let Title = dataDict.value(forKey: "Title") as? String  ??  ""
                                let CompanyName = dataDict.value(forKey: "CompanyName") as? String ?? ""
                                self.currentOpeningArr.append(Title)
                                self.currentOpeningArr.append(CompanyName)
                                print(self.currentOpeningArr)
                            }
                        }
                        
                    }
                    self.tblCurrentOpnenings.reloadData()
                    self.getAppliedJobs()
                    // print("data yaha parse karna hai")
                    
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
    
    
    //
    func getAppliedJobs() {
        
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
            alamObject.getRequestURL( "\(APIName.AppliedDesbordJobs)/\(userID)/apply", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    
                    print(responseJASON)
                    if let dataArr = responseJASON.arrayObject as? NSArray{
                        if dataArr.count > 0{
                            if let dataDict = dataArr.object(at: 0) as? NSDictionary{
                                if let jobId = dataDict.value(forKey: "JobId") as? Int {
                                    print("No JobId")
                                    self.FindAppliedJobForSearchTap(jobId:jobId)
                                }
                                
                                
                            }
                        }
                        else{
                            self.HomeListApi()
                        }
                        
                        print(dataArr)
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
    
    func FindAppliedJobForSearchTap(jobId:Int){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["query":"Account","searchFields":["*"],"fields":["Title","CompanyName"],"pageSize":100,"offset":0,"filter":"JobId=\(jobId)"] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b20817a7a558ec0adeb7777801bf7973a0be3fa908686b2f72274b46c74ed9e9e9946f041de883c033ad207dd046bcf40af62700c0caf45493bccd3474beab4cf5bcba4c4e13f12b44c9d9485c8a1b66040a1f532c5248b8382d4e9e7baa7edae899a8b09db9069c10809772c94f94860a13d433f57bfa6305a0b0b7364a7a75"
            ]
            
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/jobs-prod/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    if self.findAplliedJobArr.count > 0{
                        self.findAplliedJobArr.removeAll()
                    }
                    if let dataArray = responseJson["results"].arrayObject as? NSArray{
                        if dataArray.count > 0{
                            if let dataDict = dataArray.object(at: 0) as? NSDictionary{
                                let Title = dataDict.value(forKey: "Title") as? String ?? ""
                                let CompanyName = dataDict.value(forKey: "CompanyName") as? String ??  ""
                                self.findAplliedJobArr.append(Title)
                                self.findAplliedJobArr.append(CompanyName)
                                print(self.findAplliedJobArr)
                                self.tblAppliedJobs.reloadData()
                                
                                self.HomeListApi()
                                
                            }
                        }
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
    
    
    
    func likeWebService(id:Int,isLike:Bool,isSpam:Bool,cell:ImageNewsFeedTableViewCell,index:Int,tapped:String){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            
            var token = String()
            var userID =  String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
            }
            
            
            let passDict = ["UserId":userID,
                            "Id":id,
                            "isLike":isLike,
                            "isSpam":isSpam] as [String:Any]
            
            
            print(passDict)
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                // "Authorization" : "Bearer \(token)"
            ]
            
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURL1("\(APIName.feed)/\(id)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                // self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    //   self.macroObj.hideLoader()
                    
                    print(responseJson)
                    
                    
                    print(isLike)
                    print(isSpam)
                    
                    self.homeNewsFeedListModel[index].isLike = isLike
                    self.homeNewsFeedListModel[index].isSpam = isSpam
                    
                    if self.homeNewsFeedListModel[index].isLike == true{
                        cell.btnLikeRef.setTitleColor(#colorLiteral(red: 0.1424064338, green: 0.4729501009, blue: 0.7668607831, alpha: 1), for: .normal)
                        cell.btnLikeRef.setImage(#imageLiteral(resourceName: "likeiconnew"), for: .normal)
                    }else{
                        cell.btnLikeRef.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
                        cell.btnLikeRef.setImage(#imageLiteral(resourceName: "like_now"), for: .normal)
                    }
                    
                    if self.homeNewsFeedListModel[index].isSpam == true{
                        cell.btnReportRef.setTitleColor(#colorLiteral(red: 0.8975477815, green: 0.1476422846, blue: 0.1496182978, alpha: 1), for: .normal)
                        cell.btnReportRef.setImage(#imageLiteral(resourceName: "danger_red"), for: .normal)
                    }else{
                        cell.btnReportRef.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
                        cell.btnReportRef.setImage(#imageLiteral(resourceName: "danger_gray"), for: .normal)
                    }
                    
                    if tapped == "likePlus"{
                        self.homeNewsFeedListModel[index].LikeCount += 1
                    }else if tapped == "likeMinus"{
                        if self.homeNewsFeedListModel[index].LikeCount > 0{
                            self.homeNewsFeedListModel[index].LikeCount -= 1
                        }else{
                            print("Do nothing")
                        }
                    }else{
                        print("Do nothing")
                    }
                    cell.lblLikeComments.text = "\(self.homeNewsFeedListModel[index].LikeCount) Likes \(self.homeNewsFeedListModel[index].CommentCount) Comment"
                    
                }else{
                    // self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }
                
                
            }, failure: { (error,responseCode) in
                print(error.localizedDescription)
                // self.macroObj.hideLoader()
                
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            })
        }
        else {
            //LODER HIDE
            // self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
            
        }
    }
    
    
    //---------------------------------TableView Method ----------------------------------->>>>>>>>>>>>>>>>>
    
    //TODO: Number of items in section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblCurrentOpnenings{
            return currentOpeningArr.count
        }else if tableView == tblRecomendedJobs{
            return 2
        }else if tableView == tblAppliedJobs{
            return findAplliedJobArr.count
        }
            
        else if tableView == tblNewsFeed {
            print("Count is",homeNewsFeedListModel.count)
            return homeNewsFeedListModel.count
        }
        else{
            return 2
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblRecomendedJobs{
            
            tblRecomendedJobs.register(UINib(nibName: "HomeTableViewCell1", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell1")
            let cell = tblRecomendedJobs.dequeueReusableCell(withIdentifier: "HomeTableViewCell1", for: indexPath) as! HomeTableViewCell1
            if indexPath.row == 0{
                cell.viewTop.isHidden = true
                cell.viewBottom.isHidden = false
            }else if indexPath.row == 1{ //matlab last
                cell.viewTop.isHidden = false
                cell.viewBottom.isHidden = true
            }else{
                cell.viewTop.isHidden = false
                cell.viewBottom.isHidden = false
            }
            return cell
            
        }else if tableView == tblCurrentOpnenings{
            
            tblCurrentOpnenings.register(UINib(nibName: "HomeTableViewCell1", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell1")
            let cell = tblCurrentOpnenings.dequeueReusableCell(withIdentifier: "HomeTableViewCell1", for: indexPath) as! HomeTableViewCell1
            if indexPath.row == 0{
                cell.viewTop.isHidden = true
                cell.viewBottom.isHidden = false
            }else if indexPath.row == 1{ //matlab last
                cell.viewTop.isHidden = false
                cell.viewBottom.isHidden = true
            }else{
                cell.viewTop.isHidden = false
                cell.viewBottom.isHidden = false
            }
            if currentOpeningArr.count > 0 {
                cell.nameLbl.text = currentOpeningArr[indexPath.row]
            }
            
            return cell
            
        }else if tableView == tblAppliedJobs{
            
            tblAppliedJobs.register(UINib(nibName: "HomeTableViewCell1", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell1")
            let cell = tblAppliedJobs.dequeueReusableCell(withIdentifier: "HomeTableViewCell1", for: indexPath) as! HomeTableViewCell1
            if indexPath.row == 0{
                cell.viewTop.isHidden = true
                cell.viewBottom.isHidden = false
            }else if indexPath.row == 1{ //matlab last
                cell.viewTop.isHidden = false
                cell.viewBottom.isHidden = true
            }else{
                cell.viewTop.isHidden = false
                cell.viewBottom.isHidden = false
            }
            if findAplliedJobArr.count > 0{
                cell.nameLbl.text = self.findAplliedJobArr[indexPath.row]
                
            }
            return cell
        }else{
            
            //
            tblNewsFeed.register(UINib(nibName: "ImageNewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageNewsFeedTableViewCell")
            let cell = tblNewsFeed.dequeueReusableCell(withIdentifier: "ImageNewsFeedTableViewCell", for: indexPath) as! ImageNewsFeedTableViewCell
            cell.nameLbl.text! = homeNewsFeedListModel[indexPath.row].Name
            print(cell.nameLbl.text!)
            
            
            cell.userNameLbl.attributedText = UpdateUIClass.updateSharedInstance.forNewsFeeedLblMethod("\(homeNewsFeedListModel[indexPath.row].message)")
            
            cell.lblLikeComments.text = "\(homeNewsFeedListModel[indexPath.row].LikeCount) Likes \(homeNewsFeedListModel[indexPath.row].CommentCount) Comment"
            
            let URLString = String(homeNewsFeedListModel[indexPath.row].Url)
            if  URLString == ""{
            }
            else{
                //                let URL = NSURL(string:URLString)
                //                let data = NSData(contentsOf: URL! as URL)
                cell.imgView.sd_setImage(with: URL(string: URLString), placeholderImage: UIImage(named: "groupicon"))
            }
            //Mark: Date And Time Stamp
            
           
            if String(homeNewsFeedListModel[indexPath.row].Date) == ""{
                
            }
            else{
                
                if let date:NSDate = UpdateUIClass.updateSharedInstance.convertStringToDate(date: homeNewsFeedListModel[indexPath.row].Date) as? NSDate{
                   // date.addingTimeInterval(180)
                    let timeStamp = date.prettyTimestampSinceNow()
                    cell.timeLbl.text = timeStamp
                }

                
            }
            
            
            
            
            
            
            // print(endtime)
            
            if homeNewsFeedListModel[indexPath.row].imgPost != ""{
                cell.imgPost.sd_setImage(with: URL(string: homeNewsFeedListModel[indexPath.row].imgPost), placeholderImage: UIImage(named: "groupicon"))
                cell.imgPost.contentMode = .scaleAspectFit
            }else{
                cell.imgPost.frame.size.height = 0
            }
            
            if homeNewsFeedListModel[indexPath.row].feedCommentDate != ""{
                cell.lblComment.isHidden = false
                cell.imgCommentProfile.isHidden = false
                cell.timeLbl.isHidden = false
                cell.lblComment.attributedText = UpdateUIClass.updateSharedInstance.forNewsFeeedLblMethodComments(homeNewsFeedListModel[indexPath.row].feedCommentName,homeNewsFeedListModel[indexPath.row].feedComment)
                print(cell.lblComment.attributedText)
                cell.imgCommentProfile.sd_setImage(with: URL(string: homeNewsFeedListModel[indexPath.row].feedCommentImgUrl), placeholderImage: UIImage(named: "groupicon"))
                
                
                
                if let date:NSDate = UpdateUIClass.updateSharedInstance.convertStringToDate(date: homeNewsFeedListModel[indexPath.row].feedCommentDate) as? NSDate{
                    
                   // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
                    
                    let timeStamp = date.prettyTimestampSinceNow()
                    cell.lblCommentTime.text = timeStamp
                }
                

            }
            else{
                cell.commentPersonImageHeight.constant = 0
                cell.lblCommentHeight.constant = 0
                cell.timeClockHeight.constant = 0
                cell.heightLblTime.constant = 0
                cell.lblComment.isHidden = true
                cell.imgCommentProfile.isHidden = true
                cell.timeLbl.isHidden = true
            }
            
            
            
            if homeNewsFeedListModel[indexPath.row].isLike == true{
                cell.btnLikeRef.setTitleColor(#colorLiteral(red: 0.1424064338, green: 0.4729501009, blue: 0.7668607831, alpha: 1), for: .normal)
                cell.btnLikeRef.setImage(#imageLiteral(resourceName: "likeiconnew"), for: .normal)
            }else{
                cell.btnLikeRef.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
                cell.btnLikeRef.setImage(#imageLiteral(resourceName: "like_now"), for: .normal)
            }
            
            if homeNewsFeedListModel[indexPath.row].isSpam == true{
                cell.btnReportRef.setTitleColor(#colorLiteral(red: 0.8975477815, green: 0.1476422846, blue: 0.1496182978, alpha: 1), for: .normal)
                cell.btnReportRef.setImage(#imageLiteral(resourceName: "danger_red"), for: .normal)
            }else{
                cell.btnReportRef.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
                cell.btnReportRef.setImage(#imageLiteral(resourceName: "danger_gray"), for: .normal)
            }
            
            cell.btnLikeRef.tag = indexPath.row
            cell.btnReportRef.tag = indexPath.row
            cell.btnCommentRef.tag = indexPath.row
            
            cell.btnLikeRef.addTarget(self, action: #selector(btnLikeTapped), for: .touchUpInside)
            cell.btnReportRef.addTarget(self, action: #selector(btnReportTapped), for: .touchUpInside)
            cell.btnCommentRef.addTarget(self, action: #selector(btnCommentTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tblRecomendedJobs{
            let recommendVC = self.storyboard?.instantiateViewController(withIdentifier: "RecommendedJobsVC") as! RecommendedJobsVC
            self.navigationController?.pushViewController(recommendVC, animated: true)
            
        }else if tableView == tblCurrentOpnenings{
            let currentVC = self.storyboard?.instantiateViewController(withIdentifier: "CurrentOpeningVC") as! CurrentOpeningVC
            self.navigationController?.pushViewController(currentVC, animated: true)
            
        }else if tableView == tblAppliedJobs{
            
            let applyVC = self.storyboard?.instantiateViewController(withIdentifier: "AppliedJobsVC") as! AppliedJobsVC
            self.navigationController?.pushViewController(applyVC, animated: true)
        }
        else{
            let applyVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedVC") as! NewsFeedVC
            self.navigationController?.pushViewController(applyVC, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView ==  tblNewsFeed{
            //   return UITableView.automaticDimension
            
            if homeNewsFeedListModel[indexPath.row].imgPost != ""{
                return 600
            }else{
                return UITableView.automaticDimension
            }
            
        }else if tableView == self.tblAppliedJobs{
            if self.findAplliedJobArr.count > 0{
                return 30
            }else{
                return 0
            }
        }else{
            if self.currentOpeningArr.count > 0{
                return 30
            }else{
                return 0
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView == tblCurrentOpnenings{
            if self.currentOpeningArr.count > 0{
                heightCurrentOpnenings.constant = tblCurrentOpnenings.contentSize.height
            }else{
                heightCurrentOpnenings.constant = 60
            }
            
        }else if tableView == tblRecomendedJobs{
            heightTblRecomendedJobs.constant = tblRecomendedJobs.contentSize.height
            
        }else if tableView == tblAppliedJobs{
            if self.findAplliedJobArr.count > 0{
                heightTblAppliedJobs.constant = tblAppliedJobs.contentSize.height
            }else{
                heightTblAppliedJobs.constant = 60
            }
        }else{
            heightNewsFeed.constant = tblNewsFeed.contentSize.height
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
    
    
    
    //TODO: Footer view
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if tableView == self.tblRecomendedJobs{
            if count > 0{
                return UIView(frame: CGRect.zero)
            }else{
                
                let footer:HomeEmptyFooterView = Bundle.main.loadNibNamed("HomeEmptyFooterView", owner: self, options: nil)!.last! as! HomeEmptyFooterView
                footer.lblTitle.text = "Please update your job preference for recommneded jobs."
                return footer
            }
        }else if tableView == self.tblCurrentOpnenings{
            if self.currentOpeningArr.count > 0{
                return UIView(frame: CGRect.zero)
            }else{
                let footer:HomeEmptyFooterView = Bundle.main.loadNibNamed("HomeEmptyFooterView", owner: self, options: nil)!.last! as! HomeEmptyFooterView
                footer.lblTitle.text = "There are current openings available for this section."
                return footer
            }
        }else if tableView == self.tblAppliedJobs{
            if self.findAplliedJobArr.count > 0{
                return UIView(frame: CGRect.zero)
            }else{
                let footer:HomeEmptyFooterView = Bundle.main.loadNibNamed("HomeEmptyFooterView", owner: self, options: nil)!.last! as! HomeEmptyFooterView
                footer.lblTitle.text = "There are no jobs available for this section currently."
                return footer
            }
        }
            
        else{
            if self.homeNewsFeedListModel.count > 0{
                return UIView(frame: CGRect.zero)
            }else{
                
                return UIView(frame: CGRect.zero)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == self.tblRecomendedJobs{
            if count > 0{
                return 0
            }else{
                return 60
            }
            
        }else if tableView == self.tblCurrentOpnenings{
            if self.currentOpeningArr.count > 0{
                return 0
            }else{
                return 60
            }
        }else if tableView == self.tblAppliedJobs{
            if self.findAplliedJobArr.count > 0{
                return 0
            }else{
                return 60
            }
        }
            
        else{
            if count > 0{
                return 0
            }else{
                return 60
            }
        }
        
    }
    
    func getTimeComponentString(olderDate older: Date,newerDate newer: Date) -> (String?)  {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        let componentsLeftTime = Calendar.current.dateComponents([.minute , .hour , .day,.month, .weekOfMonth,.year], from: older, to: newer)
        
        let year = componentsLeftTime.year ?? 0
        if  year > 0 {
            formatter.allowedUnits = [.year]
            return formatter.string(from: older, to: newer)
        }
        
        
        let month = componentsLeftTime.month ?? 0
        if  month > 0 {
            formatter.allowedUnits = [.month]
            return formatter.string(from: older, to: newer)
        }
        
        let weekOfMonth = componentsLeftTime.weekOfMonth ?? 0
        if  weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
            return formatter.string(from: older, to: newer)
        }
        
        let day = componentsLeftTime.day ?? 0
        if  day > 0 {
            formatter.allowedUnits = [.day]
            return formatter.string(from: older, to: newer)
        }
        
        let hour = componentsLeftTime.hour ?? 0
        if  hour > 0 {
            formatter.allowedUnits = [.hour]
            return formatter.string(from: older, to: newer)
        }
        
        let minute = componentsLeftTime.minute ?? 0
        if  minute > 0 {
            formatter.allowedUnits = [.minute]
            return formatter.string(from: older, to: newer) ?? ""
        }
        
        return nil
    }
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    func updateDate()   {
        //  let inputString = self.dateDate
        var strArray = self.dateDate.components(separatedBy:"T")
        print(strArray)
        let date = strArray[0]
        let time = strArray[1]
        // let myTimeStamp = date + " \(time)"
        //strDate = myTimeStamp
        
        
        let str: String = time
        let addTime: Int = 30  //minutes
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var dateInput: Date? = formatter.date(from: str)
        dateInput = dateInput?.addingTimeInterval(TimeInterval(addTime*60))
        //let endtime = formatter.string(from: dateInput!)
        
        // let dateString = "2014-07-15" // change to your date format
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let myDate = dateFormatter.date(from: date)
        print(myDate)
        
        
        let endDate = Date().addingTimeInterval(12345678)
        let olderDates = date as? NSDate
        let string =  getTimeComponentString(olderDate: myDate!, newerDate: endDate)
        
        // print(nowDate)
        print(endDate)
        print(string)
        
        
        let temStrDate =  timeAgoSinceDate(date: myDate! as NSDate, numericDates: true)
        self.getDate = temStrDate
        
        print("djhsdjdshjj",temStrDate)
    }
}


extension  Float {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}




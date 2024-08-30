//
//  SignOnFeed.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import  RealmSwift
class SignOnFeed: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblNewsFeed: UITableView!
    
    //MARK: - VARIABLES
    let realm = try! Realm()
    
    //MARK: - VARIABLES
    var homeNewsFeedListModel = [HomeNewsFeedList]()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    var dateDate = String()
    var getDate = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    //MARK: - Actions, Gestures
    //TODO: Actions
    @IBAction func btnBackTapped(_ sender: UIButton) {
        if let userInfo = realm.objects(LoginDataModal.self).first{
            
            if userInfo.isMentor == true{
                let appDel = UIApplication.shared.delegate as! AppDelegate
                _ = appDel.homeMentor()
                
            }else{
                let appDel = UIApplication.shared.delegate as! AppDelegate
                _ = appDel.initHome()
            }
        }
    }
    
    
    
    @objc func btnLikeTapped(sender:UIButton){
        if homeNewsFeedListModel[sender.tag].isLike{
            let indexpath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                print("no cell")
                return
            }
            likeWebService(id: homeNewsFeedListModel[sender.tag].Id, isLike: false, isSpam: homeNewsFeedListModel[sender.tag].isSpam, cell: cell, index: sender.tag, tapped: "likeMinus")
            
        }else{
            let indexpath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                print("no cell")
                return
            }
            likeWebService(id: homeNewsFeedListModel[sender.tag].Id, isLike: true, isSpam: homeNewsFeedListModel[sender.tag].isSpam, cell: cell, index: sender.tag, tapped: "likePlus")
        }
    }
    
    @objc func btnCommentTapped(sender:UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommentListingVC") as! CommentListingVC
        vc.feedID = homeNewsFeedListModel[sender.tag].Id
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func btnReportTapped(sender:UIButton){
        if homeNewsFeedListModel[sender.tag].isSpam{
            let indexpath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                print("no cell")
                return
            }
            likeWebService(id: homeNewsFeedListModel[sender.tag].Id, isLike: homeNewsFeedListModel[sender.tag].isLike, isSpam: false, cell: cell, index: sender.tag, tapped: "Report")
            
        }else{
            
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.reportFeed.rawValue, style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "OK", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")
                    
                }
                else
                {
                    
                    let indexpath = IndexPath(row: sender.tag, section: 0)
                    guard let cell = self.tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                        print("no cell")
                        return
                    }
                    self.likeWebService(id: self.homeNewsFeedListModel[sender.tag].Id, isLike: self.homeNewsFeedListModel[sender.tag].isSpam, isSpam: true, cell: cell, index: sender.tag, tapped:"Report")
                    
                }
            }
            
            
            
            
        }
    }
    
    
}


//MARK: - Custom methods extension
extension SignOnFeed{
    //TODO: Method initialSetup
    func initialSetup(){
        tblNewsFeed.tableFooterView = UIView()
        tblNewsFeed.reloadData()
        getSignOnFeedData()
    }
}


//MARK: - TableView dataSource and delegates extension
extension SignOnFeed:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeNewsFeedListModel.count
    }
    
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //
        tblNewsFeed.register(UINib(nibName: "ImageNewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageNewsFeedTableViewCell")
        let cell = tblNewsFeed.dequeueReusableCell(withIdentifier: "ImageNewsFeedTableViewCell", for: indexPath) as! ImageNewsFeedTableViewCell
        cell.nameLbl.text! = homeNewsFeedListModel[indexPath.row].Name
        
        
        
        cell.userNameLbl.attributedText = UpdateUIClass.updateSharedInstance.forNewsFeeedLblMethod("\(homeNewsFeedListModel[indexPath.row].message)")
        
        cell.lblLikeComments.text = "\(homeNewsFeedListModel[indexPath.row].LikeCount) Likes \(homeNewsFeedListModel[indexPath.row].CommentCount) Comment"
        
        let URLString = String(homeNewsFeedListModel[indexPath.row].Url)
        if  URLString == ""{
        }
        else{
            //            let URL = NSURL(string:URLString)
            //            let data = NSData(contentsOf: URL! as URL)
            cell.imgView.sd_setImage(with: URL(string: URLString), placeholderImage: UIImage(named: "groupicon"))
        }
        //Mark: Date And Time Stamp
        
        self.dateDate = String(homeNewsFeedListModel[indexPath.row].Date)
        
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
            cell.lblCommentTime.isHidden = false
            cell.lblComment.attributedText = UpdateUIClass.updateSharedInstance.forNewsFeeedLblMethodComments(homeNewsFeedListModel[indexPath.row].feedCommentName,homeNewsFeedListModel[indexPath.row].feedComment)
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
            cell.lblCommentTime.isHidden = true        }
        
        
        
        
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
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        // return UITableView.automaticDimension
        
        if homeNewsFeedListModel[indexPath.row].imgPost != ""{
            return 600
        }else{
            return UITableView.automaticDimension
        }
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension SignOnFeed{
    
    
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
                            "isSpam":isSpam] as [String:AnyObject]
            
            
            print(passDict)
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                // "Authorization" : "Bearer \(token)"
            ]
            
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.feed)/\(id)", params: passDict, headers: header, success: { (responseJson,responseCode) in
                // self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    //   self.macroObj.hideLoader()
                    
                    print(responseJson)
                    
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
    
    
    
    func getSignOnFeedData()  {
        //https://portal.signon.co.in/api/v1/feeds?page=1&pageSize=10&isSignOn=true
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var token = String()
            
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            // https://beta-signon.azurewebsites.net/api/v1/mentors/1870
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("/feeds?page=\(1)&pageSize=\(10)&isSignOn=\(true)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    if let dataArr = responseJASON.arrayObject as? NSArray{
                        self.homeNewsFeedListModel.removeAll()
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
                                    print(DateR)
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
                    
                    //    print(responseJASON)
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
}



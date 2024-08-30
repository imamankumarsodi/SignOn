//
//  NotificationListVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SDWebImage
class NotificationListVC: UIViewController {
    
    //MARK: - OUTLETS
      var dateDate = String()
      var alamObject = AlamofireWrapper()
      let macroObj = MacrosForAll.sharedInstanceMacro
      let realm = try! Realm()
      var notificationListModel = [NotifiationList]()
    var getDate = String()

    @IBOutlet weak var tblNotification: UITableView!
    
    //MARK: - VARIABLES
    
 
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
}

//MARK: - Custom methods extension

extension NotificationListVC{
    //TODO: Method initialSetup
    func initialSetup(){
        getSignOnFeedData()
        tblNotification.tableFooterView = UIView()
        tblNotification.reloadData()
    }
}


//MARK: - TableView dataSource and delegates extension


extension NotificationListVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationListModel.count
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblNotification.register(UINib(nibName: "NotificationTableViewCellandXib", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCellandXib")
        let cell = tblNotification.dequeueReusableCell(withIdentifier: "NotificationTableViewCellandXib", for: indexPath) as! NotificationTableViewCellandXib
        cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateMentorHomeCellLabel(self.notificationListModel[indexPath.row].title,self.notificationListModel[indexPath.row].body)
        cell.imgView.sd_setImage(with: URL(string: notificationListModel[indexPath.row].profileImage), placeholderImage: UIImage(named: "groupicon"))
        
        
 
        self.dateDate = String(notificationListModel[indexPath.row].timestamp)
        if self.dateDate == ""{
            
        }
        else{
            updateDate()
            cell.dateLbl.text = self.getDate
        }
        
        
        
        
        return cell
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
}
extension NotificationListVC{
    func getSignOnFeedData()  {
        //https://portal.signon.co.in/api/v1/feeds?page=1&pageSize=10&isSignOn=true
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var token = String()
             var userId = String()
            
            
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userId  = userInfo.Id
            }
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
                "Authorization" : "Bearer \(token)"
            ]
            
          //  https://portal.signon.co.in/api/v1/users/12903/notifications?page=1&pageSize=20
            
             macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("users/\(userId)/notifications?page=\(1)&pageSize=\(20)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    
                    if let dataArr = responseJASON.arrayObject as? NSArray{
                        self.notificationListModel.removeAll()
                        for item in dataArr{
                            var r_profleImg = String()
                            var r_timestamp = String()
                            var r_postid = String()
                            var r_body = String()
                            var r_title = String()
                            
                            
                            if let itemDict = item as? NSDictionary{
                                
                                if let title = itemDict.value(forKey: "title") as? String{
                                    r_title = title
                                }
                                if let body = itemDict.value(forKey: "body") as? String{
                                    r_body = body
                                }
                                if let title = itemDict.value(forKey: "title") as? String{
                                    r_title = title
                                }
                                if let CreatedAt = itemDict.value(forKey: "CreatedAt") as? String{
                                    r_timestamp = CreatedAt
                                }
                                if let postId = itemDict.value(forKey: "Id") as? Int{
                                    r_postid = String(postId)
                                }
                                if let userDict = itemDict.value(forKey: "User") as? NSDictionary{
                                    if let profileImageDict = userDict.value(forKey: "ProfileImage") as? NSDictionary{
                                        if let url = profileImageDict.value(forKey: "Url") as? String{
                                            r_profleImg = url
                                        }
                                    }
                                }
                                let notificationItem = NotifiationList(profileImage: r_profleImg, postid: r_postid, body: r_body, title: r_title, timestamp: r_timestamp)
                                self.notificationListModel.append(notificationItem)
                                
                            }
                        }
                        self.tblNotification.reloadData()
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

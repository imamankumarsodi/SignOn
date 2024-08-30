//
//  MentorMessageViewController.swift
//  SignOn
//
//  Created by Callsoft on 02/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MentorMessageViewController: UIViewController {

    //MARK: -->
    let realm = try! Realm()
 
    var dateDate = String()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    var notificationListModel = [NotifiationList]()
    var quesAnswerListModel = [MentorHomeMessageListingModel]()
    
    var getDate = String()
    
    @IBOutlet weak var msgTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageListData() 
     }
    
    @IBAction func menueBtn_Action(_ sender: Any)
    {
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
    extension MentorMessageViewController:UITableViewDelegate,UITableViewDataSource{
        //TODO: Number of items in section
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return quesAnswerListModel.count
          
        }
        
        //TODO: Cell for item at indexPath
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
                msgTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
                let cell = msgTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.name_Lbl.text = quesAnswerListModel[indexPath.row].Name
            cell.imgProfileView.sd_setImage(with: URL(string: self.quesAnswerListModel[indexPath.row].Url), placeholderImage: UIImage(named: "groupicon"))
            cell.lblMsg.text!  = self.quesAnswerListModel[indexPath.row].Message
            
            self.dateDate = String(quesAnswerListModel[indexPath.row].timeStamp)
            if self.dateDate == ""{
                
            }
            else{
                updateDate()
                cell.lblTimeStamp.text = self.getDate
            }
            
            
                return cell
         }
        
        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return UITableView.automaticDimension
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
 extension MentorMessageViewController {
    
    func MessageListData()  {
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
            
//            /feeds?page=1&pageSize=10&isSignOn=true
            
            macroObj.showLoader(view: self.view)
           // /chats?page=\(1)&otherUserId=\(userID)&pageSize=40
            alamObject.getRequestURL("/chats?page=\(1)&otherUserId=\(userId)&pageSize=\(40)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    
                    if self.quesAnswerListModel.count > 0{
                        self.quesAnswerListModel.removeAll()
                    }
                    
                    var name = String()
                    var message = String()
                    var url = String()
                    var profUrl = String()
                    var r_id = String()
                    var r_timeStamp = String()
                    
                    if let resArray = responseJASON.arrayObject as? NSArray {
                        for item in resArray{
                            if let itemDict = item as? NSDictionary{
                                if  let id = itemDict.value(forKey: "Id") as? Int{
                                    r_id = String(id)
                                }
                              
                                if let chatMessageArray = itemDict.value(forKey: "ChatMessages") as? NSArray{
                                    if chatMessageArray.count > 0{
                                        if let MessageDict = chatMessageArray.object(at: 0) as? NSDictionary{
                                           
                                            if let Message = MessageDict.value(forKey: "Message") as? String{
                                                print(Message)
                                                message = Message
                                            }
                                            if  let timeSatmp = MessageDict.value(forKey: "CreatedAt") as? String{
                                                r_timeStamp = String(timeSatmp)
                                            }
                                           
                                            if let User = MessageDict.value(forKey: "User") as? NSDictionary{
                                                
                                                if let Name = User.value(forKey: "Name") as? String{
                                                    print(Name)
                                                    name = Name
                                                }
                                               
                                                
                                            }
                                        }
                                    }
                                }
                                
                                if let UserPrimaryAttachment = itemDict.value(forKey: "UserPrimaryAttachment") as? NSDictionary{
                                    
                                    print(UserPrimaryAttachment)
                                    if let Url = UserPrimaryAttachment.value(forKey: "Url") as? String{
                                        print(Url)
                                        url = Url
                                    }
                                }
                            }
                            
                            let itemDic = MentorHomeMessageListingModel(Name: name, Message: message, Url: url, profileUrl: profUrl, timeStamp: r_timeStamp, id: r_id)
                            self.quesAnswerListModel.append(itemDic)
                        }
                        self.msgTableView.reloadData()
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



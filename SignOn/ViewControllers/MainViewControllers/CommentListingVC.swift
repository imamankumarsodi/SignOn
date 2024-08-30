//
//  CommentListingVC.swift
//  SignOn
//
//  Created by Deepti Sharma on 24/07/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

protocol reloadHomeCandidateApi{
    func reloadCandidate()
}

protocol reloadHomeMentorApi{
    func reloadMentor()
}

protocol reloadSingOnFeedApi{
    func reloadSignOnFeed()
}
protocol reloadNewsFeedApi{
    func reloadNewsFeed()
}



class CommentListingVC: UIViewController {
    
    @IBOutlet weak var btnSendRef: UIButton!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var tblComment: UITableView!
    var feedID = Int()
    let realm = try! Realm()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    
    var CommentDataModelArray = [CommentDataModel]()
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return refreshControl
    }
    
    var homeCObj:reloadHomeCandidateApi?
    var homeMObj:reloadHomeMentorApi?
    var signOnFeedObj:reloadSingOnFeedApi?
    var newsFeedObj:reloadNewsFeedApi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intiialSetup()
        
       
        // Do any additional setup after loading the view.
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        btnValidation()
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
      commentListApiData()
        refreshControl.endRefreshing()
    }
   
    
    func intiialSetup(){
        tblComment.tableFooterView = UIView()
        self.tblComment.addSubview(self.refreshControl)
        commentListApiData()
    }
    
    func btnValidation(){
    
        txtComment.text! = txtComment.text!.trimmingCharacters(in: .whitespaces)
        if txtComment.text == "" || txtComment.text == " "{
            print("do nothing")
        }else{
            postCommentService()
        }
        
        
      
        
    }
    
    func getFormattedDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let now = Date()
        let dateString = formatter.string(from:now)
        return dateString
    }
    
}



//MARK: - TableView dataSource and delegates extension
extension CommentListingVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CommentDataModelArray.count
    }
    
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //
        tblComment.register(UINib(nibName: "CommentTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "CommentTableViewCellAndXib")
        let cell = tblComment.dequeueReusableCell(withIdentifier: "CommentTableViewCellAndXib", for: indexPath) as! CommentTableViewCellAndXib
        
        cell.configureWith(info: CommentDataModelArray[indexPath.row])
       
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
    
}





extension CommentListingVC {
    func commentListApiData()  {
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
            
            //     https://portal.signon.co.in/api/v1/feeds/28/comments?page=1&pageSize=1000
            
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("feeds/\(feedID)/comments?page=1&pageSize=1000", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    if self.CommentDataModelArray.count > 0{
                        self.CommentDataModelArray.removeAll()
                    }
                    
                    self.macroObj.hideLoader()
                   print(responseJASON)
                    if let resArray = responseJASON.arrayObject as? NSArray{
                        
                        var imageR = String()
                        var userNameR = String()
                        var dateR = String()
                        var commentR = String()
                        var idR = String()
                        
                        for item in resArray{
                            if let itemDict = item as? NSDictionary{
                                if let ProfileImageUrl = itemDict.value(forKey: "ProfileImageUrl") as? String{
                                    imageR = ProfileImageUrl
                                }
                                
                                if let Name = itemDict.value(forKey: "Name") as? String{
                                    userNameR = Name
                                }
                                
                                
                                if let Comment = itemDict.value(forKey: "Comment") as? String{
                                    commentR = Comment
                                }
                                
                                
                                if let CreatedAt = itemDict.value(forKey: "CreatedAt") as? String{
                                    dateR = CreatedAt
                                }
                                
                                if let Id = itemDict.value(forKey: "Id") as? Int{
                                    idR = String(Id)
                                }
                                
                                let modelItem = CommentDataModel(image: imageR, userName: userNameR, date: dateR, comment: commentR, id: idR)
                                
                                self.CommentDataModelArray.append(modelItem)
                            }
                        }
                        
                        self.tblComment.reloadData()
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
    
    
    func postCommentService(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            var token = String()
            var userID =  String()
            var name = String()
            if let userInfo = realm.objects(LoginDataModal.self).first{
                token = userInfo.token
                userID = userInfo.Id
                name = userInfo.Name
            }
            
            
            let passDict = ["Comment":txtComment.text!,
                            "FeedId":feedID,
                            "Name":name,
                            "UserId":userID,
                            "CreatedAt":getFormattedDate()] as [String:AnyObject]
            
            let txt = txtComment.text!
            
            self.txtComment.text = ""
            self.txtComment.isUserInteractionEnabled = false
            self.btnSendRef.isUserInteractionEnabled = false
            print(passDict)
            
            let header = [
                "Content-Type": "application/json; charset=UTF-8",
              "Authorization" : "Bearer \(token)"
            ]
            //eeds/28/comments
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURL("\(APIName.feed)/\(feedID)/comments", params: passDict, headers: header, success: { (responseJson,responseCode) in
                // self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    
                    if let userInfo = self.realm.objects(LoginDataModal.self).first{
                        
                        print(userInfo.Name)
                        
                        self.CommentDataModelArray.append(CommentDataModel(image: String(), userName: userInfo.Name, date: self.getFormattedDate(), comment: txt, id: String()))
                    }
                    
                    self.txtComment.isUserInteractionEnabled = true
                    self.btnSendRef.isUserInteractionEnabled = true
                    
                    
                    self.tblComment.reloadData()
                }else{
                    self.txtComment.isUserInteractionEnabled = true
                    self.btnSendRef.isUserInteractionEnabled = true
                    // self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }
                
                
            }, failure: { (error,responseCode) in
                print(error.localizedDescription)
                self.txtComment.isUserInteractionEnabled = true
                self.btnSendRef.isUserInteractionEnabled = true
                // self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            })
        }
        else {
            //LODER HIDE
            // self.macroObj.hideLoader()
            self.txtComment.isUserInteractionEnabled = true
            self.btnSendRef.isUserInteractionEnabled = true
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
            
        }
    }
    
}

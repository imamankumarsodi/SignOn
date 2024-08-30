//
//  InterviewsListingVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class InterviewsListingVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblInterView: UITableView!
    
    //MARK: - VARIABLES
    let realm = try! Realm()
     var dateDate = String()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    var mentorListModel = [MentorModelList]()
    
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

extension InterviewsListingVC{
    //TODO: Method initialSetup
    func initialSetup(){
        InterViewData()
        tblInterView.tableFooterView = UIView()
        tblInterView.reloadData()
    }
}



//MARK: - TableView dataSource and delegates extension
extension InterviewsListingVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentorListModel.count
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblInterView.register(UINib(nibName: "InterviewTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "InterviewTableViewCellAndXib")
        let cell = tblInterView.dequeueReusableCell(withIdentifier: "InterviewTableViewCellAndXib", for: indexPath) as! InterviewTableViewCellAndXib
        return cell
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let interviewDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "InterviewDetailsVC")as! InterviewDetailsVC
        self.navigationController?.pushViewController(interviewDetailVC, animated: true)
    
    }
    //https://portal.signon.co.in/api/v1/interview?certificationJob=false&page=1&pageSize=10
}

extension InterviewsListingVC {
    func InterViewData()  {
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
            
 
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("/interview?certificationJob=\(false)&page=\(1)&pageSize=\(10)", headers: header , success: { (responseJASON,responseCode) in
                
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    
                    if let dataArr = responseJASON.arrayObject as? NSArray{
                        self.mentorListModel.removeAll()
                        for item in dataArr{
                            var r_profleImg = String()
                            var r_postid = String()
                            var r_email = String()
                            var r_name = String()
                            var r_msg = String()

                            if let itemDict = item as? NSDictionary{

                                if let name = itemDict.value(forKey: "Name") as? String{
                                    r_name = name
                                }
                                if let email = itemDict.value(forKey: "Email") as? String{
                                    r_email = email
                                }
                                if let msg = itemDict.value(forKey: "ProfessionalSummary") as? String{
                                    r_msg = msg
                                }

                                if let postId = itemDict.value(forKey: "Id") as? Int{
                                    r_postid = String(postId)
                                }
                                if let userDict = itemDict.value(forKey: "ProfileImage") as? NSDictionary{
                                    if let url = userDict.value(forKey: "Url") as? String{
                                        r_profleImg = url
                                    }
                                }
                                let mentorList = MentorModelList(Name: r_name, Message: r_msg, Url: r_profleImg, email: r_email, id: r_postid)
                                self.mentorListModel.append(mentorList)

                            }
                        }
                        self.tblInterView.reloadData()
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

//
//  MentorsVC.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//IndustryExpertiseViewController

import UIKit
import RealmSwift
class MentorsVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblMentors: UITableView!
    
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
extension MentorsVC{
    //TODO: Method initialSetup
    func initialSetup(){
        MetorApiData()
        tblMentors.tableFooterView = UIView()
        tblMentors.reloadData()
    }
}

//https://portal.signon.co.in/api/v1/mentors?page=1&pageSize=10

//MARK: - TableView dataSource and delegates extension
extension MentorsVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentorListModel.count
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblMentors.register(UINib(nibName: "MentorsTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "MentorsTableViewCellAndXib")
        let cell = tblMentors.dequeueReusableCell(withIdentifier: "MentorsTableViewCellAndXib", for: indexPath) as! MentorsTableViewCellAndXib
        
        cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateMentorCellLabel(mentorListModel[indexPath.row].Name, mentorListModel[indexPath.row].email, mentorListModel[indexPath.row].Message)
        
         cell.imgView.sd_setImage(with: URL(string: self.mentorListModel[indexPath.row].Url), placeholderImage: UIImage(named: "groupicon"))
        
 
        
        cell.btn_AskQuestion.addTarget(self, action: #selector(goToMessage), for: .touchUpInside)
        return cell
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func buttonClicked(sender:UIButton)
    {
        print("hello")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let industryVC = self.storyboard?.instantiateViewController(withIdentifier: "IndustrialProfileViewController") as! IndustrialProfileViewController
        self.navigationController?.pushViewController(industryVC, animated: true)
    }
    
    @objc func goToMessage(_ sender: UIButton) {
        
        let message = self.storyboard?.instantiateViewController(withIdentifier: "MentorChatVC") as! MentorChatVC
        self.navigationController?.pushViewController(message, animated: true)
    }
}

extension MentorsVC {
    func MetorApiData()  {
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
            
      //     https://portal.signon.co.in/api/v1/mentors?page=1&pageSize=10
            
            macroObj.showLoader(view: self.view)
            alamObject.getRequestURL("/mentors?page=\(1)&pageSize=\(10)", headers: header , success: { (responseJASON,responseCode) in
                
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
                        self.tblMentors.reloadData()
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

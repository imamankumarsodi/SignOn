//
//  AppliedJobsVC.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class AppliedJobsVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblApliedJobs: UITableView!
    @IBOutlet weak var lblApplied: UILabel!
    @IBOutlet weak var lblAccepted: UILabel!
    @IBOutlet weak var lblInProgress: UILabel!
    
    @IBOutlet weak var currentDetail_Btn: UIButton!
    @IBOutlet weak var aboutRecruter_Btn: UIButton!
    //MARK: - VARIABLES
    let realm = try! Realm()
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var AppliedJobsDataModelArr = [AppliedJobsDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    
    
    
    @IBAction func aboutReccruter_Action(_ sender: UIButton) {
        
        aboutRecruter_Btn.backgroundColor = UIColor(red: 0/255, green: 121/255, blue: 192/255, alpha: 1)
        currentDetail_Btn.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        aboutRecruter_Btn.setTitleColor(UIColor.white, for: .normal)
        currentDetail_Btn.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    @IBAction func currentDetail_Action(_ sender: UIButton) {
        currentDetail_Btn.backgroundColor = UIColor(red: 0/255, green: 121/255, blue: 192/255, alpha: 1)
        aboutRecruter_Btn.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        aboutRecruter_Btn.setTitleColor(UIColor.darkGray, for: .normal)
        currentDetail_Btn.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    
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
extension AppliedJobsVC{
    //TODO: Method initialSetup
    func initialSetup(){
        lblApplied.attributedText = UpdateUIClass.updateSharedInstance.updateAppliedFotterLabel("APPLIED", "1")
        lblAccepted.attributedText = UpdateUIClass.updateSharedInstance.updateAppliedFotterLabel("ACCEPTED", "0")
        lblInProgress.attributedText = UpdateUIClass.updateSharedInstance.updateAppliedFotterLabel("IN-PROGRESS", "0")
        tblApliedJobs.tableFooterView = UIView()
        appliedJobsAPI()
        
    }
}

//MARK: - TableView dataSource and delegates extension
extension AppliedJobsVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppliedJobsDataModelArr.count
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblApliedJobs.register(UINib(nibName: "AppliedJobsTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "AppliedJobsTableViewCellAndXib")
        let cell = tblApliedJobs.dequeueReusableCell(withIdentifier: "AppliedJobsTableViewCellAndXib", for: indexPath) as! AppliedJobsTableViewCellAndXib
        cell.lblName.text = AppliedJobsDataModelArr[indexPath.row].title
        cell.lblCompanyName.text = AppliedJobsDataModelArr[indexPath.row].companyName
        cell.lblStatus.text = "\(AppliedJobsDataModelArr[indexPath.row].status)"
        return cell
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobDescriptionInJobSeekerVC") as! JobDescriptionInJobSeekerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppliedJobsVC {
    func appliedJobsAPI() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            //https://portal.signon.co.in/api/v1/jobs?recommended=false&applied=true&page=1&pageSize=300
            
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
            alamoFireObj.getRequestURL("/jobs?recommended=\(false)&applied=\(true)&page=\(1)&pageSize=\(300)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    if self.AppliedJobsDataModelArr.count > 0{
                        self.AppliedJobsDataModelArr.removeAll()
                    }
                    print(responseJASON)
                    var title = String()
                    var id = String()
                    var compName = String()
                    var status = Int()
                    if let responseArr = responseJASON.arrayObject as? NSArray{
                        for item in responseArr{
                            if let itemDict = item as? NSDictionary{
                                if let Title = itemDict.value(forKey: "Title") as? String{
                                    print(Title)
                                    title = Title
                                }
                                if let Id = itemDict.value(forKey: "Id") as? Int{
                                    print(Id)
                                    id = String(Id)
                                }
                                if let CompanyName = itemDict.value(forKey: "CompanyName") as? String{
                                    print(CompanyName)
                                    compName = CompanyName
                                }
                                if let Status = itemDict.value(forKey: "Status") as? Int{
                                    print(Status)
                                    status = Status
                                }
                            }
                            let AppliedJobsDataModelItem = AppliedJobsDataModel(id: id, title: title, companyName: compName, status: status)
                            self.AppliedJobsDataModelArr.append(AppliedJobsDataModelItem)
                            self.tblApliedJobs.reloadData()
                        }
                    }
                }else{
                    self.macroObj.hideLoader()
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

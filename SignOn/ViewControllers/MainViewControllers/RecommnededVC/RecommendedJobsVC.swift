//
//  RecommendedJobsVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class RecommendedJobsVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblRecommendedJobs: UITableView!
    
    //MARK: - VARIABLES
    let realm = try! Realm()
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // variable to save the last position visited, default to zero
    
    private var lastContentOffset: CGFloat = 0
    
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
extension RecommendedJobsVC{
    //TODO: Method initialSetup
    func initialSetup(){
        recomendedJobsAPI()
        tblRecommendedJobs.tableFooterView = UIView()
        tblRecommendedJobs.reloadData()
    }
}



//MARK: - TableView dataSource and delegates extension
extension RecommendedJobsVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblRecommendedJobs.register(UINib(nibName: "CurrentOpeningsTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "CurrentOpeningsTableViewCellAndXib")
        let cell = tblRecommendedJobs.dequeueReusableCell(withIdentifier: "CurrentOpeningsTableViewCellAndXib", for: indexPath) as! CurrentOpeningsTableViewCellAndXib
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
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // move up
            print("move up")
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y) {
            // move down
            print("move down")
        }
        
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

extension RecommendedJobsVC {
    func recomendedJobsAPI() {
        
        //GET https://portal.signon.co.in/api/v1/jobs?recommended=true&applied=false&page=1&pageSize=10
        
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
            alamoFireObj.getRequestURL("jobs?recommended=\(true)&applied=\(false)&page=\(1)&pageSize=\(10)", headers: header, success: { (responseJASON,responseCode)  in
                
                if responseCode == 200{
                    print(responseJASON)
                    self.macroObj.hideLoader()
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

//
//  JobPreferenceVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class JobPreferenceVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblJobPreferences: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    //MARK: - VARIABLES
    let realm = try! Realm()
    
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    
    let arrayTitle = ["Keywords","Location","Minimum Salary","Industry Expertise","Functional Area","Role"]
    //  let arraySubtitle = ["No Keywords added","No Locations added","Not Disclosed","No Industries added","No Functional area added","No Roles added"]
    
    var arraySubtitle = [String]()
    
    var keyWordStringArray = [String]()
    var locStringArray = [String]()
    var salStringArray = [String]()
    var indusArray = [String]()
    var areaArray = [String]()
    var rolesArray = [String]()
    var salaryString = "Not Disclosed"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableHeight?.constant = tblJobPreferences.contentSize.height
    }
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    
    @IBAction func editButtonAction(_ sender: Any) {
        let edtit_VC = self.storyboard?.instantiateViewController(withIdentifier: "EditPrefrencesVC") as! EditPrefrencesVC
        self.navigationController?.pushViewController(edtit_VC, animated: true)
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
extension JobPreferenceVC{
    //TODO: Method initialSetup
    func initialSetup(){
        tblJobPreferences.tableFooterView = UIView()
        appliedJobsAPI()
        //        tblJobPreferences.reloadData()
    }
}


//MARK: - TableView dataSource and delegates extension
extension JobPreferenceVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySubtitle.count
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblJobPreferences.register(UINib(nibName: "JobPrefrencesTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "JobPrefrencesTableViewCellAndXib")
        let cell = tblJobPreferences.dequeueReusableCell(withIdentifier: "JobPrefrencesTableViewCellAndXib", for: indexPath) as! JobPrefrencesTableViewCellAndXib
        cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateJobPreferencesLabel(arrayTitle[indexPath.row], arraySubtitle[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableHeight?.constant = tblJobPreferences.contentSize.height
    }
}


extension JobPreferenceVC {
    func appliedJobsAPI() {
        if InternetConnection.internetshared.isConnectedToNetwork() {
            //GET https://portal.signon.co.in/api/v1/candidates/12893
            
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
            alamoFireObj.getRequestURL("/candidates/\(userID)", headers: header, success: { (responseJASON,responseCode) in
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJASON)
                    if let keywordsArray = responseJASON["Keywords"].arrayObject as? NSArray{
                        for keywordsItem in keywordsArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    self.keyWordStringArray.append(keyWordString)
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                    if let locArray = responseJASON["PreferredLocations"].arrayObject as? NSArray{
                        for keywordsItem in locArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    self.locStringArray.append(keyWordString)
                                }
                                
                            }
                        }
                    }
                    
                    
                    if let salArray = responseJASON["ExpectedSalary"].arrayObject as? NSArray{
                        for keywordsItem in salArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    self.salStringArray.append(keyWordString)
                                }
                                
                            }
                        }
                    }
                    
                    if let preferedIndusArray = responseJASON["PreferredIndustries"].arrayObject as? NSArray{
                        for keywordsItem in preferedIndusArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    self.areaArray.append(keyWordString)
                                }
                                
                            }
                        }
                    }
                    
                    
                    if let preferedFunctionAreaArray = responseJASON["PreferredFunctionalAreas"].arrayObject as? NSArray{
                        for keywordsItem in preferedFunctionAreaArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    self.indusArray.append(keyWordString)
                                }
                                
                            }
                        }
                    }
                    
                    
                    if let preferedRolesArray = responseJASON["PreferredRoles"].arrayObject as? NSArray{
                        for keywordsItem in preferedRolesArray{
                            if let keywordsDict = keywordsItem as? NSDictionary{
                                if let keyWordString = keywordsDict.value(forKey: "Name") as? String{
                                    self.rolesArray.append(keyWordString)
                                }
                                
                            }
                        }
                    }
                    
                    if self.keyWordStringArray.count > 0{
                        let keywordsJoin = self.keyWordStringArray.joined(separator: ",")
                        self.arraySubtitle.append(keywordsJoin)
                    }else{
                        self.arraySubtitle.append("No Keywords added")
                    }
                    
                    if self.locStringArray.count > 0{
                        let keywordsJoin = self.locStringArray.joined(separator: ",")
                        self.arraySubtitle.append(keywordsJoin)
                    }else{
                        self.arraySubtitle.append("No Locations added")
                    }
                    
                    
                    if self.salStringArray.count > 0{
                        let keywordsJoin = self.salStringArray.joined(separator: ",")
                        self.arraySubtitle.append(keywordsJoin)
                    }else{
                        self.arraySubtitle.append("Not Disclosed")
                    }
                    
                    
                    if self.areaArray.count > 0{
                        let keywordsJoin = self.areaArray.joined(separator: ",")
                        self.arraySubtitle.append(keywordsJoin)
                    }else{
                        self.arraySubtitle.append("No Industries added")
                    }
                    
                    
                    if self.indusArray.count > 0{
                        let keywordsJoin = self.indusArray.joined(separator: ",")
                        self.arraySubtitle.append(keywordsJoin)
                    }else{
                        self.arraySubtitle.append("No Functional area added")
                    }
                    
                    if self.rolesArray.count > 0{
                        let keywordsJoin = self.rolesArray.joined(separator: ",")
                        self.arraySubtitle.append(keywordsJoin)
                    }else{
                        self.arraySubtitle.append("No Roles added")
                    }
                    
                    self.tblJobPreferences.reloadData()
                    
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

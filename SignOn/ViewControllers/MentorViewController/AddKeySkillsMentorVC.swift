//
//  AddKeySkillsMentorVC.swift
//  SignOn
//
//  Created by Deepti Sharma on 16/10/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

protocol backDataToEditProfileMentor {
    func backDataToMentor(id:String,name:String)
}


class AddKeySkillsMentorVC: UIViewController {
    
    
    @IBOutlet weak var msgTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnSearchRef: UIButton!
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    var speNameArray = [String]()
    var speIdArray = [String]()
    
    var filterNameArray = [String]()
    var filterIdArray = [String]()
    var searchActive = Bool()
    var btnSearchStatus = Bool()
    var backObj:backDataToEditProfileMentor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        msgTableView.backgroundColor = UIColor.white
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .clear
        searchBar.isTranslucent = true
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor.clear
            textfield.placeHolderColor = .white
            textfield.placeholder = "Type Skills"
        }
        
        msgTableView.register(UINib(nibName: "JobPrefrencesTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "JobPrefrencesTableViewCellAndXib")
        
        getDropDownForSearchTapSpecialization()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnCrossTapped(_ sender: Any) {
        
        if btnSearchStatus{
          btnSearchRef.setImage(#imageLiteral(resourceName: "closeNew"), for: .normal)
            searchBar.isHidden = false
            
        }else{
          btnSearchRef.setImage(#imageLiteral(resourceName: "searchNew"), for: .normal)
            searchBar.isHidden = true
        }
        btnSearchStatus = !btnSearchStatus
        searchActive = false
        searchBar.text = ""
        msgTableView.reloadData()
    }
    
}

extension AddKeySkillsMentorVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return filterNameArray.count
        }else{
          return speNameArray.count
        }
        
        
    }
    
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = msgTableView.dequeueReusableCell(withIdentifier: "JobPrefrencesTableViewCellAndXib", for: indexPath) as! JobPrefrencesTableViewCellAndXib
        
       cell.lblDetails.font = UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 18.0)
        if searchActive{
            cell.lblDetails.text = filterNameArray[indexPath.row]
        }else{
           cell.lblDetails.text = speNameArray[indexPath.row]
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive{
            backObj?.backDataToMentor(id: filterIdArray[indexPath.row], name: filterNameArray[indexPath.row])
        }else{
            backObj?.backDataToMentor(id: speIdArray[indexPath.row], name: speNameArray[indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
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
    
    
    
    func getDropDownForSearchTapSpecialization(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["fields":["*"],"filter":"DataType=1","offset":0,"pageSize":200,"query":"","searchFields":["*"],"sort":["-Timestamp"]] as! [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            
            macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/prod_staticData/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    print(responseJson)
                    
                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
                        for item in dataArr{
                            if let itmeDict  = item as? NSDictionary{
                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
                                    print("NO Name")
                                    return
                                }
                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
                                    print("NO Id")
                                    return
                                }
                                self.speNameArray.append(Name)
                                self.speIdArray.append(String(Id))
                                
                            }
                        }
                    }
                    print(self.speNameArray)
                    print(self.speIdArray)
                    self.msgTableView.reloadData()
                  //  self.getDropDownForSearchTapCourseType()
                    
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
    
}


// MARK: - Search extensions

extension AddKeySkillsMentorVC:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            searchActive = false
        }else{
            searchActive = true
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            searchActive = false
        }else{
            searchActive = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            searchActive = false
        }else{
            searchActive = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if filterIdArray.count > 0{
            filterIdArray.removeAll()
        }
        
        if filterNameArray.count > 0{
            filterNameArray.removeAll()
        }

        
        if searchBar.text!.isEmpty {
            searchActive = false
        }
        else {
            searchActive = true
            if speNameArray.count >= 1 {
                for index in 0...speNameArray.count - 1 {
                    
                    guard let restName = speNameArray[index] as? String else{
                        print("No restName")
                        return
                    }
                    
                    if (restName.lowercased().range(of: searchText.lowercased()) != nil) {
                        filterNameArray.append(restName)
                        filterIdArray.append(speIdArray[index])
                    }
                    
                }
            }
        }
        msgTableView.reloadData()
    }
}

//
//  SearchTabViewController.swift
//  SignOn
//
//  Created by Callsoft on 28/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

protocol searchData {
    func searchData(selecetdNameArray: NSMutableArray, selecetdIdArray: NSMutableArray, isComingFromIndex: Int)
}

class SearchTabViewController:  UIViewController {
    
    @IBOutlet weak var chkBoxTbl: UITableView!
    @IBOutlet weak var dumyview: UIView!
    @IBOutlet weak var search: UISearchBar!
    
    
    //******* SearchBar
    var searchActive = false
    var filtered : NSMutableArray = NSMutableArray()
    
    
    
    var selectedRows = NSMutableArray()
    var selectedName = NSMutableArray()
    
    
    var myselected :[IndexPath] = []
    let intervalCellIdentifier = "intervalCellIdentifier"
    
    var resutResponseArray = NSArray()
    var industryExpertiseArr = [String]()   // Not In Use Till Search and Selection
    var industryExpertiseIdArr = [String]()  // Not In Use Till Search and Selection
    
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    
    var passDict = [String:AnyObject]()
    var APIURL = String()
    
    var searchDataDelegate: searchData?
    
    var isComingFromIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        // Reload the table
        search.delegate = self
        
        chkBoxTbl.reloadData()
        chkBoxTbl.allowsSelection = false
        
        dataForSearchTap()   //API CALL
        
        // Do any additional setup after loading the view, typically from a nib.
        
        chkBoxTbl.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        search.text = ""
        searchActive = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveActionBtn(_ sender: Any) {
        print("Selected IDS are", selectedRows)
        print("Selected Name are", selectedName)
        
        searchDataDelegate?.searchData(selecetdNameArray: selectedName, selecetdIdArray: selectedRows, isComingFromIndex: isComingFromIndex)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchTabViewController: UISearchBarDelegate {
    
    //MARK:- Search Bar Delegate Functions
    //MARK:-
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
            self.search.endEditing(true)
        }
        
    
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = false
        }
        
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            
            if searchBar.text == "" {
                searchActive = false
            }
                
            else {
                searchActive = true
            }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            print("THE ENTER TEXT", searchText)
            filtered.removeAllObjects()
            
            if searchBar.text!.isEmpty {
                searchActive = false
 
            }
                
            else {
                
                searchActive = true
                
                if resutResponseArray.count >= 1 {
                    
                    for index in 0...resutResponseArray.count-1 {
                        
                        let dicResponse = resutResponseArray.object(at: index) as? NSDictionary ?? [:]
                        let documentName = dicResponse.object(forKey: "Name") as? String ?? ""
                        
                        if (documentName.lowercased().range(of: searchText.lowercased()) != nil){
                            
                            filtered.add(dicResponse)
                        }
                    }
                }
            }
            
            chkBoxTbl.reloadData()

        }
        
        
    
    
}

//MARK: - UITableViewDataSource

extension SearchTabViewController : UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searchActive == true {
            return filtered.count
        }
            
        else {
            return self.resutResponseArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: intervalCellIdentifier) as!CheckBxTableViewCell
        
        if searchActive == true {
            
            let dataDict = filtered.object(at: indexPath.row) as? NSDictionary ?? [:]
            let name = dataDict.value(forKey: "Name") as? String ?? ""
            let Id = dataDict.value(forKey: "Id") as? Int ?? 0
            
            cell.chk_BoxBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
            cell.chk_BoxBtn.tag = indexPath.row
            
            if selectedRows.contains(Id)
            {
                cell.chk_BoxBtn.setImage(UIImage(named: "download"), for: .normal)
                cell.chk_BoxBtn.layer.borderColor = UIColor.blue.cgColor
                cell.chk_BoxBtn.layer.borderWidth = 2
            }
                
            else
            {
                cell.chk_BoxBtn.layer.borderColor = UIColor.blue.cgColor
                cell.chk_BoxBtn.layer.borderWidth = 2
                cell.chk_BoxBtn.setImage(UIImage(named: ""), for: .normal)
            }

            
            cell.name_Label.text! = name
        }
        else {
            
            let dataDict = resutResponseArray.object(at: indexPath.row) as? NSDictionary ?? [:]
            let name = dataDict.value(forKey: "Name") as? String ?? ""
            let Id = dataDict.value(forKey: "Id") as? Int ?? 0

            cell.chk_BoxBtn.addTarget(self, action:#selector(checkBoxSelection(_:)), for: .touchUpInside)
            cell.chk_BoxBtn.tag = indexPath.row
            
            if selectedRows.contains(Id)
            {
                cell.chk_BoxBtn.setImage(UIImage(named: "download"), for: .normal)
                cell.chk_BoxBtn.layer.borderColor = UIColor.blue.cgColor
                cell.chk_BoxBtn.layer.borderWidth = 2
            }
                
            else
            {
                cell.chk_BoxBtn.layer.borderColor = UIColor.blue.cgColor
                cell.chk_BoxBtn.layer.borderWidth = 2
                cell.chk_BoxBtn.setImage(UIImage(named: ""), for: .normal)
            }

            cell.name_Label.text! = name
            
        }
        

        return cell
    }
    
    
    @objc func checkBoxSelection(_ sender:UIButton)
    {

        if searchActive == true {
            
            let dataDict = filtered.object(at: sender.tag) as? NSDictionary ?? [:]
            let Id = dataDict.value(forKey: "Id") as? Int ?? 0
            let name = dataDict.value(forKey: "Name") as? String ?? ""
            
            
            if selectedRows.contains(Id){
                selectedRows.remove(Id)
                selectedName.remove(name)
                
            }else{
                selectedRows.add(Id)
                selectedName.add(name)
            }
        }
        else {
            
            let dataDict = resutResponseArray.object(at: sender.tag) as? NSDictionary ?? [:]
            let Id = dataDict.value(forKey: "Id") as? Int ?? 0
            let name = dataDict.value(forKey: "Name") as? String ?? ""
            
            if selectedRows.contains(Id){
                selectedRows.remove(Id)
                selectedName.remove(name)
                
            }else{
                selectedRows.add(Id)
                selectedName.add(name)
            }
        }
    
        self.chkBoxTbl.reloadData()
        
    }
    
    
}

//MARK: - UITableViewDelegate

extension SearchTabViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //myselected = industryExpertiseIdArr[indexPath.row]
     }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension  SearchTabViewController {
    
    func dataForSearchTap() {
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            let passDict = self.passDict
            
            
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b01e3b7b3ab94fc2203f3888611c585737b40aec82e5959804bf1508a94bf688f3758f513a1ad3de5562083b6c55d9ff38a07951d19d9eafb198582947fbadc8cdad62d3f92c72cbf98d7530f50d90c1327ef4f172f36a1c1e655099fec81015529c621b82cb2a8073867df3f11ae8de1023b71a8a3e1b300ce2861629f01301"
            ]
            
//            "https://api.searchtap.io/v1/collections/prod_staticData/query"
            // macroObj.showLoader(view: self.view)
            alamObject.postRequestURLSearchTap(self.APIURL, params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                
                
                if responseCode == 200{
                    self.industryExpertiseArr.removeAll()
                    self.industryExpertiseIdArr.removeAll()
                  //  print(responseJson)
                    
                    self.resutResponseArray = responseJson["results"].arrayObject as? NSArray ?? []
                    
//                    if let dataArr = responseJson["results"].arrayObject as? NSArray{
//                        for item in dataArr{
//                            if let itmeDict  = item as? NSDictionary{
//                                guard let Name = itmeDict.value(forKey: "Name") as? String else{
//                                    print("NO Name")
//                                    return
//                                }
//                                guard let Id = itmeDict.value(forKey: "Id") as? Int else{
//                                    print("NO Id")
//                                    return
//                                }
//
//                                self.industryExpertiseArr.append(Name)
//                                self.industryExpertiseIdArr.append(String(Id))
//
//                            }
//                        }
//
//                        print("THE NAME ARRAY IS", self.industryExpertiseArr)
//                        print("THE ID ARRAY IS", self.industryExpertiseIdArr)
//                        self.chkBoxTbl.reloadData()
//                    }
                    self.chkBoxTbl.reloadData()
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

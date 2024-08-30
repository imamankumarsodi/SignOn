//
//  MessageListingVC.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
class MessageListingVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblMessageListing: UITableView!
    
    //MARK: - VARIABLES
    let realm = try! Realm()

    
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
extension MessageListingVC{
    //TODO: Method initialSetup
    func initialSetup(){
        tblMessageListing.tableFooterView = UIView()
        tblMessageListing.reloadData()
    }
}


//MARK: - TableView dataSource and delegates extension
extension MessageListingVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblMessageListing.register(UINib(nibName: "CurrentOpeningsTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "CurrentOpeningsTableViewCellAndXib")
        let cell = tblMessageListing.dequeueReusableCell(withIdentifier: "CurrentOpeningsTableViewCellAndXib", for: indexPath) as! CurrentOpeningsTableViewCellAndXib
        return cell
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

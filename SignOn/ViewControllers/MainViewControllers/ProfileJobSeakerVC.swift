//
//  ProfileJobSeakerVC.swift
//  SignOn
//
//  Created by Aman on 07/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class ProfileJobSeakerVC: UIViewController {

    
    //MARK: - OUTLETS
    @IBOutlet weak var HeaderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserDetailsObj: UILabel!
    @IBOutlet weak var tblHeader: UITableView!
    @IBOutlet weak var headerLblObj: UILabel!
    @IBOutlet weak var headerTableHeight: NSLayoutConstraint!
    //MARK: - VARIABLES
    var previousOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        headerTableHeight.constant = tblHeader.contentSize.height
    }
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    @IBAction func btnBackTapped(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        _ = appDel.initHome()
    }
    
    @IBAction func btnEducationTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func btnEmployeementTapped(_ sender: UIButton) {
    }
    
}

//MARK: - Custom methods extension
extension ProfileJobSeakerVC{
    //TODO: Method initialSetup
    func initialSetup(){
        lblUserDetailsObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("MCA", "IMS Ghaziabad\n1 Years 2 Months Experience")
        scrollView.delegate = self
    }
    
    //TODO: Method didScroll
    func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        
        var newHeight = HeaderViewHeight.constant + diff
        print(newHeight)
        
        if newHeight < 75 {
            imgProfile.isHidden = true
            headerLblObj.isHidden = false
            newHeight = 75
        } else if newHeight > 240 { // or whatever
            newHeight = 240
        }
            //For show hide image profile
        else if newHeight > 75{
            headerLblObj.isHidden = true
            imgProfile.isHidden = false
        }
        HeaderViewHeight.constant = newHeight
    }
}


//MARK: - Extension scrollView Delegate
extension ProfileJobSeakerVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
}


//MARK: - TableView dataSource and delegates extension
extension ProfileJobSeakerVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblHeader.register(UINib(nibName: "BlackHeaderTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "BlackHeaderTableViewCellAndXib")
        let cell = tblHeader.dequeueReusableCell(withIdentifier: "BlackHeaderTableViewCellAndXib", for: indexPath) as! BlackHeaderTableViewCellAndXib
        if indexPath.row == 0{
            cell.lblDetails.text = ""
            cell.viewTop.isHidden = true
            cell.viewBottom.isHidden = false
        }else if indexPath.row == 1{ //matlab last
            cell.lblDetails.text = "8445577995"
            cell.viewTop.isHidden = false
            cell.viewBottom.isHidden = true
            
        }else{
            cell.viewTop.isHidden = false
            cell.viewBottom.isHidden = false
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       headerTableHeight.constant = tblHeader.contentSize.height
    }
    
    
    
}

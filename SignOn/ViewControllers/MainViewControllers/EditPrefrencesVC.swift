//
//  EditPrefrencesVC.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class EditPrefrencesVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblEditPrefrences: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    //MARK: - VARIABLES
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableHeight?.constant = tblEditPrefrences.contentSize.height
    }
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Custom methods extension
extension EditPrefrencesVC{
    //TODO: Method initialSetup
    func initialSetup(){
        tblEditPrefrences.tableFooterView = UIView()
        tblEditPrefrences.reloadData()
    }
    
    func updateTableViewCell(index:Int,cell:EditPreferenceTableViewCellandXib)->UITableViewCell{
        if index == 0{
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = true
            cell.dropDownBtn.isHidden = true
            
            cell.imgView.image = #imageLiteral(resourceName: "_user_man_profile")
             cell.lblTitle.text = "Keywords"
            cell.txtFieldDetails.text = "Software Engineering"
        }else if index == 1{
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = true
            cell.dropDownBtn.isHidden = true
            
            cell.imgView.image = #imageLiteral(resourceName: "_map_location")
            cell.lblTitle.text = "Location"
            cell.txtFieldDetails.text = "Select Location"
        }else if index == 2{
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.isHidden = false
            
            cell.imgView.image = #imageLiteral(resourceName: "minimum_salary")
            cell.lblTitle.text = "Minimum Salary"
            cell.txtFieldDetails.text = "6 Lacs"
        }else if index == 3{
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.isHidden = true
            
            cell.imgView.image = #imageLiteral(resourceName: "university")
            cell.lblTitle.text = "Industry"
            cell.txtFieldDetails.text = "IT/Computers - Software"
        }else if index == 4{
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.isHidden = true
            
            cell.imgView.image = #imageLiteral(resourceName: "target_icon")
            cell.lblTitle.text = "Functional Areas"
            cell.txtFieldDetails.text = "IT"
        }else{
            cell.lblTitle.isHidden = false
            cell.viewSeparator.isHidden = false
            cell.dropDownBtn.isHidden = true
            
            cell.imgView.image = #imageLiteral(resourceName: "_office_bag")
            cell.lblTitle.text = "Roles"
            cell.txtFieldDetails.text = "Interns"
        }
        return cell
    }

}


//MARK: - TableView dataSource and delegates extension
extension EditPrefrencesVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tblEditPrefrences.register(UINib(nibName: "EditPreferenceTableViewCellandXib", bundle: nil), forCellReuseIdentifier: "EditPreferenceTableViewCellandXib")
        let cell = tblEditPrefrences.dequeueReusableCell(withIdentifier: "EditPreferenceTableViewCellandXib", for: indexPath) as! EditPreferenceTableViewCellandXib
        return updateTableViewCell(index: indexPath.row,cell: cell)
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableHeight?.constant = tblEditPrefrences.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

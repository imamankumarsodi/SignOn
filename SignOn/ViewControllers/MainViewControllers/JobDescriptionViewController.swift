//
//  JobDescriptionViewController.swift
//  SignOn
//
//  Created by Callsoft on 03/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class JobDescriptionViewController: UIViewController {
    @IBOutlet weak var jobdescrptionTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
                self.navigationController?.popViewController(animated: true)
    }
}

extension JobDescriptionViewController:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return 2
        }
    }
    
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            jobdescrptionTblView.register(UINib(nibName: "JobDescrptionTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDescrptionTableViewCell")
            let cell = jobdescrptionTblView.dequeueReusableCell(withIdentifier: "JobDescrptionTableViewCell", for: indexPath) as! JobDescrptionTableViewCell
                   // cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateJobPreferencesLabel(arrayTitle[indexPath.row], arraySubtitle[indexPath.row])
             return cell
         }
            
        else{
            jobdescrptionTblView.register(UINib(nibName: "EditJobDescrptionTableViewCell", bundle: nil), forCellReuseIdentifier: "EditJobDescrptionTableViewCell")
            let cell = jobdescrptionTblView.dequeueReusableCell(withIdentifier: "EditJobDescrptionTableViewCell", for: indexPath) as! EditJobDescrptionTableViewCell
            return cell
        }
        
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0{
            return UITableView.automaticDimension
            
        }
        else{
            return UITableView.automaticDimension
        }
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

//extension JobDescriptionViewController:UITableViewDelegate,UITableViewDataSource{
//    //TODO: Number of items in section
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    //TODO: Cell for item at indexPath
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        jobdescrptionTblView.register(UINib(nibName: "JobDescrptionTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDescrptionTableViewCell")
//        let cell = jobdescrptionTblView.dequeueReusableCell(withIdentifier: "JobDescrptionTableViewCell", for: indexPath) as! JobDescrptionTableViewCell
//       // cell.lblDetails.attributedText = UpdateUIClass.updateSharedInstance.updateJobPreferencesLabel(arrayTitle[indexPath.row], arraySubtitle[indexPath.row])
//        return cell
//    }
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}


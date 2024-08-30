//
//  IndustrialProfileViewController.swift
//  SignOn
//
//  Created by Callsoft on 27/03/19.
//  Copyright © 2019 Callsoft. All rights reserved.
//

import UIKit

class IndustrialProfileViewController: UIViewController{
    

    @IBOutlet weak var profileTableView: UITableView!
 
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFiles()
          initialSetup()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    private func registerNibFiles(){
        let nib = UINib(nibName: "MentorProfileTableViewCellAndXib", bundle: nil)
        profileTableView.register(nib, forCellReuseIdentifier: "MentorProfileTableViewCellAndXib")
    }
    
    @IBAction func messaBtnAction(_ sender: Any) {
    
        let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "MentorChatVC") as! MentorChatVC
        self.navigationController?.pushViewController(otpVC, animated: true)
        
    
    }
    
}
extension IndustrialProfileViewController{
    //TODO: Method initialSetup
    func initialSetup(){
        nameLbl.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("Amblika", "ishita@hotmail.com")
 }
}

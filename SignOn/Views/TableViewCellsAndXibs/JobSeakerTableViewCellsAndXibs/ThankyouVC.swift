//
//  ThankyouVC.swift
//  SignOn
//
//  Created by Callsoft on 17/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class ThankyouVC: UIViewController {

 //MARK: - AllOutlet
    
    @IBOutlet weak var thankYouLbl: UILabel!
    let appDel = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
       
    }
    @IBAction func logOutBtnAction(_ sender: UIButton)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        _ = appDel.initLoginAtLogOut()
  
    }
    
}

extension ThankyouVC{
    func initialSetup(){
        thankYouLbl.attributedText = UpdateUIClass.updateSharedInstance.updateThankYouTitleLabel("Thank You!","Your Submission is Received.\nWe will contact you shortly")
 
    }
    
}

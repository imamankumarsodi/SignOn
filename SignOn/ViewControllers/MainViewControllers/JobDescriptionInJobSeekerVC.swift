//
//  JobDescriptionInJobSeekerVC.swift
//  SignOn
//
//  Created by Apple on 08/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class JobDescriptionInJobSeekerVC: UIViewController {

    @IBOutlet weak var signonImg: UIImageView!
    @IBOutlet weak var aboutbntOutlet: UIButton!
    @IBOutlet weak var contactBntOutlet: UIButton!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var emailimg: UIImageView!
    @IBOutlet weak var phoneNumberImg: UIImageView!
    
    var bool1 = true
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if bool1 == true {
            contactView.isHidden = true
            
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contactBntOutlet.titleLabel?.textColor = UIColor.darkGray
    }
   
    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func navigateToSigonAdminAction(_ sender: Any) {
        
    }
    @IBAction func ContactBntAction(_ sender: Any) {
         bool1 = false
          changeColor(bnt1: contactBntOutlet, bnt2: aboutbntOutlet, view1: aboutView, view2: contactView)
        emailimg.isHidden = false
        phoneNumberImg.isHidden = false
        signonImg.isHidden = true
        
    }
    @IBAction func AboutBntAction(_ sender: Any) {
        
        bool1 = true
          changeColor(bnt1: aboutbntOutlet, bnt2: contactBntOutlet, view1: contactView, view2: aboutView)
        emailimg.isHidden = true
        phoneNumberImg.isHidden = true
        signonImg.isHidden = false

    }
}

extension JobDescriptionInJobSeekerVC {
    
    func changeColor(bnt1:UIButton , bnt2:UIButton , view1:UIView , view2:UIView)  {
        
        emailimg.isHidden = true
        phoneNumberImg.isHidden = true
        
        bnt1.backgroundColor = UIColor.init(displayP3Red: 26/255, green: 121/255, blue: 176/255, alpha: 1)
        bnt1.titleLabel?.textColor = UIColor.white
        
        bnt2.backgroundColor = UIColor.init(displayP3Red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        bnt2.titleLabel?.textColor = UIColor.darkGray
      
        view1.isHidden = true
        view2.isHidden = false
    }
    
}

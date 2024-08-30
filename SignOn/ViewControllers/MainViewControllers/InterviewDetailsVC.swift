//
//  InterviewDetailsVC.swift
//  SignOn
//
//  Created by Callsoft on 13/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
class InterviewDetailsVC: UIViewController {

    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnAction(_ sender: UIButton) {
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

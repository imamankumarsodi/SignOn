//
//  ChangePasswordVC.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class ChangePasswordVC: UIViewController {
    //MARK: - OUTLETS
    let realm = try! Realm()

    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var newConfirmPassword: UITextField!
    @IBOutlet weak var lblHeaderObj: UILabel!
    var isComingFrom = String()
    
    //MARK: - VARIABLES
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    var tokenF = String()
    var userIDF = String()
    var isMentorF = Bool()
    var mobileF = String()
    
    
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    @IBAction func btn_setPassword(_ sender: Any) {
        validationSetup()
        
    }
    
    @IBAction func btn_BackTapped(_ sender: Any) {
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
//MARK: - Extention user defined methods
extension ChangePasswordVC{
    //TODO: Initial Setup
    func initialSetup(){
       
    }
}

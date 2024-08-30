//
//  MyProfileVC.swift
//  SignOn
//
//  Created by abc on 30/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MyProfileVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var heightTblEducation: NSLayoutConstraint!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblUserDetailsObj: UILabel!
    @IBOutlet weak var lblHeaderNameRef: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblKeySkills: UILabel!
    @IBOutlet weak var lblEmployemetObj: UILabel!
    @IBOutlet weak var tblJobPreferences: UITableView!
    @IBOutlet weak var imgViewHeaderMain: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tblCarrierProfile: UITableView!
    @IBOutlet weak var heightCarrierProfile: NSLayoutConstraint!
    @IBOutlet weak var lblResume: UILabel!
    @IBOutlet weak var tblPersonalDetails: UITableView!
    @IBOutlet weak var heightPersonal: NSLayoutConstraint!
    
    
    //Mark: - All LabelOutlet

    //MARK: - VARIABLES
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    var previousOffset: CGFloat = 0
    let realm = try! Realm()
    var educationArr =  [EducationProfileDataModel]()
    var carrierProfileArr =  [EducationProfileDataModel]()
    var personalDetailsArr =  [EducationProfileDataModel]()
     var rolesArray = [String]()
     var arraySubtitle = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
      //   initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        initialSetup()
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
    
    @IBAction func edit_Profile(_ sender: UIButton) {
        
        let basicDetails = self.storyboard?.instantiateViewController(withIdentifier: "BasicDetailsVC") as! BasicDetailsVC
        basicDetails.bio = self.lblBio.text!
        self.navigationController?.pushViewController(basicDetails, animated: true)
    }
    
    
    //FOR DUMMY SCREEN ------------------------------------------------------>>>>>>>>>>>>>>>>>>>>>
    
    
    @IBAction func btn_ProfileSummry(_ sender: Any) {
        let profileSumm = self.storyboard?.instantiateViewController(withIdentifier: "ProfessionalSummaryVC") as! ProfessionalSummaryVC
        self.navigationController?.pushViewController(profileSumm, animated: true)
    }
    
    
    @IBAction func btn_keySkill(_ sender: Any) {
        let keySkillVC = self.storyboard?.instantiateViewController(withIdentifier: "KeySkills") as! KeySkills
        self.navigationController?.pushViewController(keySkillVC, animated: true)
    }
    
    
    
    @IBAction func btn_Employment(_ sender: Any) {
        let employeementVC = self.storyboard?.instantiateViewController(withIdentifier: "EmploymentsVC") as! EmploymentsVC
        self.navigationController?.pushViewController(employeementVC, animated: true)
    }
    
    
    @IBAction func btn_CareerProfile(_ sender: Any) {
        let careerVC = self.storyboard?.instantiateViewController(withIdentifier: "CarrierProfileVC") as! CarrierProfileVC
        self.navigationController?.pushViewController(careerVC, animated: true)
    }
    
    
    @IBAction func btn_AttchedCv(_ sender: Any) {
        let resumeVC = self.storyboard?.instantiateViewController(withIdentifier: "ResumeAttacedViewController") as! ResumeAttacedViewController
        self.navigationController?.pushViewController(resumeVC, animated: true)
    }
    
    
    @IBAction func btn_PersonalDetails(_ sender: Any) {
        let personalVC = self.storyboard?.instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsVC
        self.navigationController?.pushViewController(personalVC, animated: true)
    }
    
    @IBAction func btnEducationTapped(_ sender: UIButton) {
        let education_VC = self.storyboard?.instantiateViewController(withIdentifier: "EducationVC") as! EducationVC
        self.navigationController?.pushViewController(education_VC, animated: true)
    }
    
    
    @IBAction func btnEmployeementTapped(_ sender: UIButton) {
        let employeementVC = self.storyboard?.instantiateViewController(withIdentifier: "EmploymentsVC") as! EmploymentsVC
        self.navigationController?.pushViewController(employeementVC, animated: true)
    }
    
}




//
//  MentorProfileVC.swift
//  SignOn
//
//  Created by Callsoft on 04/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//
import UIKit
import RealmSwift


class MentorProfileVC: UIViewController {
    //MARK:--> AllIBoutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var headerLblObj: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mentorProfile_TableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblHeaderNameRef: UILabel!
    
    @IBOutlet weak var lblProfileSummary: UILabel!
    //MARK: - VARIABLES
    let realm = try! Realm()
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    var previousOffset: CGFloat = 0
    var experienceName = (0, 0)
    var instituteName = String()
    var degreeName = String()
    var profileName = String()
    var email = String()
    var phoneNo = String()
    var degingnatiod = String()
    var companyName = String()
    var indusTriesArray = [String]()
    var indusTriesIDArray = NSMutableArray()
    

 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          getMentorApiJobs()
          //intialSetup()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getMentorApiJobs()
        tblHeight.constant = mentorProfile_TableView.contentSize.height
    }
    
    @IBAction func editBtn_Action(_ sender: UIButton) {
         let edeiVC = self.storyboard?.instantiateViewController(withIdentifier: "MentorBasicProfileVC") as! MentorBasicProfileVC
        self.navigationController?.pushViewController(edeiVC, animated: true)
        
    }
    
    @IBAction func editProfile_Action(_ sender: UIButton) {
                let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfessionalSummaryVC") as! ProfessionalSummaryVC
                self.navigationController?.pushViewController(home, animated: true)
        
    }
    
    
    @IBAction func menueBtnAction(_ sender: Any) {
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
    
    @IBAction func industryExpertiseAction(_ sender: Any) {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IndustryExpertiseViewController") as! IndustryExpertiseViewController
        home.industriesIDArr = self.indusTriesIDArray
        home.industriesNameArr = self.indusTriesArray
        self.navigationController?.pushViewController(home, animated: true)
      // IndustryExpertiseViewController
    }
    
    

}
//MARK: - Extension UserdefineMethod
extension MentorProfileVC{
    func intialSetup() {
        scrollView.delegate = self
        
        if experienceName.1 == 0{
            self.headerLblObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("\(self.degreeName)", "\(self.instituteName)\n Fresher")
        }
        else{
            headerLblObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("\(profileName)","\n\(degingnatiod)\(degreeName) \(", " + companyName)\n\(email)\n\(instituteName)\n\(experienceName.0) Years \( experienceName.1) Months Experience\n\(phoneNo)")
        //headerLblObj.attributedText = UpdateUIClass.updateSharedInstance.updateMentorHeaderLabel("Jack Shukla", "iOS Developer\njack@gmail.com\n5 Years 0 month experience\n9988776655")
        
    }
      
}
    
    //TODO: Method didScroll
    func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        
        var newHeight = heightConstraint.constant + diff
        print(newHeight)
        
        if newHeight < 75 {
            imgProfile.isHidden = true
            lblHeaderNameRef.isHidden = false
            newHeight = 75
        } else if newHeight > 280 { // or whatever
            newHeight = 280
        }
            //For show hide image profile
        else if newHeight > 75{
            lblHeaderNameRef.isHidden = true
            imgProfile.isHidden = false
        }
        heightConstraint.constant = newHeight
    }
    
}
//MARK: - TableView dataSource and delegates extension
extension MentorProfileVC:UITableViewDelegate,UITableViewDataSource{
    //TODO: Number of items in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return indusTriesArray.count
    }
    //TODO: Cell for item at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        mentorProfile_TableView.register(UINib(nibName: "MentorProfileTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "MentorProfileTableViewCellAndXib")
        let cell = mentorProfile_TableView.dequeueReusableCell(withIdentifier: "MentorProfileTableViewCellAndXib", for: indexPath) as! MentorProfileTableViewCellAndXib
        cell.name_Lbl.text = indusTriesArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tblHeight.constant = mentorProfile_TableView.contentSize.height
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
}

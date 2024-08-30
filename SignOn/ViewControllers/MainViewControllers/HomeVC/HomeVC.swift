//
//  HomeVC.swift
//  SignOn
//
//  Created by abc on 29/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import KYDrawerController
import Realm
import RealmSwift
import SDWebImage


class HomeVC: UIViewController,UIScrollViewDelegate{
    
    
    
    //Mark: All ModelVariable
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let realm = try! Realm()
    var homeNewsFeedListModel = [HomeNewsFeedList]()
    let count = 0
    var recommendedJobsCount = String()
    var appliedJobsCount = String()
    var dateDate = String()
    var getDate = String()
    
    
    
    
    //MARK: - OUTLETS

    @IBOutlet weak var appliedJobs_Btn: UIButton!
    
    @IBOutlet weak var currentOpeningBtn: UIButton!
    
    @IBOutlet weak var btnRecomented: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblProfileCompletenessObj: UILabel!
    @IBOutlet weak var lblProfileViewObj: UILabel!
    @IBOutlet weak var lblLanguageScoreObj: UILabel!
    @IBOutlet weak var lblSignOnScoreObj: UILabel!
    @IBOutlet weak var lblUserDetailsObj: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tblRecomendedJobs: UITableView!
    @IBOutlet weak var heightTblRecomendedJobs: NSLayoutConstraint!
    @IBOutlet weak var tblCurrentOpnenings: UITableView!
    @IBOutlet weak var heightCurrentOpnenings: NSLayoutConstraint!
    @IBOutlet weak var tblAppliedJobs: UITableView!
    @IBOutlet weak var heightTblAppliedJobs: NSLayoutConstraint!
    @IBOutlet weak var tblNewsFeed: UITableView!
    @IBOutlet weak var heightNewsFeed: NSLayoutConstraint!
    
    @IBOutlet weak var viewMain: UIView!
    
    //Mark: AllFunctionaqlity Variable
    
    var profilrComlpeteFactor = Int()
    var signOnScore = Int()
    var profileViewCount = Int()
    var langScore = Int()
    var previousOffset: CGFloat = 0
    var instituteName = String()
    var degreeName = String()
    var experienceName = (0, 0)
 
    var currentOpeningArr = [String]()
    var findAplliedJobArr = [String]()
    var currentOpeningCount = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Update UI here
         updateUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(true)
        heightTblRecomendedJobs.constant = tblRecomendedJobs.contentSize.height
        heightCurrentOpnenings.constant = tblCurrentOpnenings.contentSize.height
        heightTblAppliedJobs.constant = tblAppliedJobs.contentSize.height
        heightNewsFeed.constant = tblNewsFeed.contentSize.height
//
 
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
  
    }
    
    //MARK: - Actions, Gestures
    //TODO: Actions
    @IBAction func btn_OpenDrawer(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.drawerController.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func headrProfileBtnAction(_ sender: Any) {
        
        let myProfile = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC

        self.navigationController?.pushViewController(myProfile, animated: true)
        
    }
    
    @IBAction func btn_Mentors(_ sender: Any) {
        
        let mentorVC = self.storyboard?.instantiateViewController(withIdentifier: "MentorsVC") as! MentorsVC
        self.navigationController?.pushViewController(mentorVC, animated: true)
    }
    
    @IBAction func btn_ViewNewsFeed(_ sender: Any) {
        
        let newsFeed = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedVC") as! NewsFeedVC
        self.navigationController?.pushViewController(newsFeed, animated: true)
    }
    
    @IBAction func btnRecomendedCurrentAppliedTappe(_ sender: UIButton) {
        recomendedCureentApplied(sender.tag)
    }
    
    
    @objc func btnLikeTapped(sender:UIButton){
        if homeNewsFeedListModel[sender.tag].isLike{
            let indexpath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                print("no cell")
                return
            }
            likeWebService(id: homeNewsFeedListModel[sender.tag].Id, isLike: false, isSpam: homeNewsFeedListModel[sender.tag].isSpam, cell: cell, index: sender.tag, tapped: "likeMinus")
            
        }else{
            let indexpath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                print("no cell")
                return
            }
            likeWebService(id: homeNewsFeedListModel[sender.tag].Id, isLike: true, isSpam: homeNewsFeedListModel[sender.tag].isSpam, cell: cell, index: sender.tag, tapped: "likePlus")
        }
    }
    
    @objc func btnCommentTapped(sender:UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommentListingVC") as! CommentListingVC
        vc.feedID = homeNewsFeedListModel[sender.tag].Id
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func btnReportTapped(sender:UIButton){
        if homeNewsFeedListModel[sender.tag].isSpam{
            let indexpath = IndexPath(row: sender.tag, section: 0)
            guard let cell = tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                print("no cell")
                return
            }
            likeWebService(id: homeNewsFeedListModel[sender.tag].Id, isLike: homeNewsFeedListModel[sender.tag].isLike, isSpam: false, cell: cell, index: sender.tag, tapped: "Report")
            
        }else{
            
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.reportFeed.rawValue, style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "OK", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")

                }
                else
                {
                    
                    let indexpath = IndexPath(row: sender.tag, section: 0)
                    guard let cell = self.tblNewsFeed.cellForRow(at: indexpath) as? ImageNewsFeedTableViewCell else{
                        print("no cell")
                        return
                    }
                    self.likeWebService(id: self.homeNewsFeedListModel[sender.tag].Id, isLike: self.homeNewsFeedListModel[sender.tag].isLike, isSpam: true, cell: cell, index: sender.tag, tapped:"Report")
                    
                }
            }
            
            
            
           
        }
    }
    
    //Mark: All perentageMethod
    
    func profileComlpeteFactorIncrementLabel(to endValue: Int) {
        let duration: Double = 2.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                 ///   self.lblProfileCompletenessObj.text = "\(i)"
                    self.lblProfileCompletenessObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nPROFILE\nCOMPLETENESS", "\(i) %")
                }
            }
        }
    }
    
    func signOnScoreIncrementLabel(to endValue: Int) {
        let duration: Double = 2.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    ///   self.lblProfileCompletenessObj.text = "\(i)"
                    self.lblSignOnScoreObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nSIGNON\nSCORE", "\(i) ")
                    
                }
            }
        }
    }
    
    
    func profileViewCountIncrementLabel(to endValue: Int){
        let duration: Double = 2.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    ///   self.lblProfileCompletenessObj.text = "\(i)"
                    
                     self.lblProfileViewObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nPROFILE\nVIEWS", "\(i) ")
                }
            }
        }
        
    }
    
    func langaugeScoretIncrementLabel(to endValue: Int){
        let duration: Double = 2.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    ///   self.lblProfileCompletenessObj.text = "\(i)"
                    
                    self.lblLanguageScoreObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeLabel("\nLANGUAGE\nSCORE", "\(i)/10")
                }
            }
        }
    }
}


//MARK: - Custom methods extension

extension HomeVC{
    
    //TODO: Method initialSetup
    
    func initialSetup(){
        if experienceName.1 == 0{
            self.lblUserDetailsObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("\(self.degreeName)", "\(self.instituteName)\n Not Disclosd")
        }
        else{
             lblUserDetailsObj.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderHomeTitleLabel("\(degreeName)", "\(instituteName)\n \(experienceName.0) Years  \(experienceName.1)  Months Experience")
        }
   
        scrollView.delegate = self
        tblCurrentOpnenings.tableFooterView = UIView()
        tblCurrentOpnenings.reloadData()
        tblRecomendedJobs.tableFooterView = UIView()
        tblRecomendedJobs.reloadData()
        tblAppliedJobs.tableFooterView = UIView()
        tblAppliedJobs.reloadData()
        tblNewsFeed.reloadData()
    }
    
    
    //TODO: Method didScroll
    
    func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        
        var newHeight = heightConstraint.constant + diff
        print(newHeight)
        
        if newHeight < 20 {
            newHeight = 20
        } else if newHeight > 220 { // or whatever
            newHeight = 220
        }
            //For show hide image profile
        else if newHeight < 74{
            imgProfile.isHidden = true
        }else if newHeight > 74{
            imgProfile.isHidden = false
        }
        heightConstraint.constant = newHeight
    }
    func recomendedCureentApplied(_ tag: Int){
        
        if tag == 1 || tag == 4{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecommendedJobsVC") as! RecommendedJobsVC
            self.navigationController?.pushViewController(vc, animated: true)

        }else if tag == 2 || tag == 5{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentOpeningVC") as! CurrentOpeningVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if tag == 3 || tag == 6{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppliedJobsVC") as! AppliedJobsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            print("Do nothing....")
        }
    }
    
    
    //TODO: Update UI
    func updateUI(){
        self.tblRecomendedJobs.borderColor = UIColor.white
        self.recommendedJobCountMethod()
    }
  
}


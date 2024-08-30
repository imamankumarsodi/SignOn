//
//  CurrentOpeningVC.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import Koloda
import pop
import AVFoundation
import MediaPlayer
class CurrentOpeningVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var btnFilterRef: UIButton!
    @IBOutlet weak var kolodaView: KolodaView!
    //MARK: - OUTLETS FOR EFFECT
    @IBOutlet weak var btnSearchJobsRef: UIButton!
    @IBOutlet weak var filterStack: UIStackView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var viewLot: UIView!
    
    @IBOutlet weak var viewMain: UIView!
    private let numberOfCards: Int = 5
    private let frameAnimationSpringBounciness: CGFloat = 9
    private let frameAnimationSpringSpeed: CGFloat = 16
    private let kolodaCountOfVisibleCards = 2
    private let kolodaAlphaValueSemiTransparent: CGFloat = 1.0
    
    
    @IBOutlet weak var jobView: UIView!
    
    @IBOutlet weak var blur: UIVisualEffectView!
    
    
    //MARK: - VARIABLES
    
    var filterButtonStatus = false
    let realm = try! Realm()
    var alamoFireObj = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var CurrentOpeningsDataModelArr = [CurrentOpeningsDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        initialSetup()
        
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func btnFilterTapped(_ sender: UIButton) {
        if  filterButtonStatus == false{
            self.animateFilterView()

//            self.filterView.fadeOutImmidiatlyWithoutshowingEffect()
//            self.filterStack.fadeOutImmidiatlyWithoutshowingEffect()
//            self.btnSearchJobsRef.fadeOutImmidiatlyWithoutshowingEffect()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.btnFilterRef.setTitle("  CLEAR FILTERS", for: .normal)
//                self.filterViewHight.constant = 245
//
//
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.filterView.fadeIn()
//                self.filterStack.fadeIn()
//                self.btnSearchJobsRef.fadeIn()
//            }

        }else{

//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.filterView.fadeOut()
//                self.filterStack.fadeOut()
//                self.btnSearchJobsRef.fadeOut()
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                self.btnFilterRef.setTitle("  FILTER", for: .normal)
//                self.filterViewHight.constant = 0
//            }
            self.hideFieldsOfFilterView()
        }

        filterButtonStatus = !filterButtonStatus
        
    }
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
        print("Swipe left")
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
        print("Swipe right")
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }

    
}

//MARK: - Custom methods extension
extension CurrentOpeningVC{
    //TODO: Method initialSetup
    func initialSetup(){
//        self.filterView.fadeOutImmidiatlyWithoutshowingEffect()
//        self.filterStack.fadeOutImmidiatlyWithoutshowingEffect()
//        self.btnSearchJobsRef.fadeOutImmidiatlyWithoutshowingEffect()
//        self.filterViewHight.constant = 0
        self.hideFieldsOfFilterView()
        
     //   tblHome.tableFooterView = UIView()
        
        
        self.macroObj.showLoaderMessage(view: viewLot)
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        currentOpeningsJobsAPI()
        
        
    }
}


//MARK: - TableView dataSource and delegates extension
//extension CurrentOpeningVC:UITableViewDelegate,UITableViewDataSource{
//    //TODO: Number of items in section
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return CurrentOpeningsDataModelArr.count
//    }
//    //TODO: Cell for item at indexPath
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        tblHome.register(UINib(nibName: "CurrentOpeningsTableViewCellAndXib", bundle: nil), forCellReuseIdentifier: "CurrentOpeningsTableViewCellAndXib")
//        let cell = tblHome.dequeueReusableCell(withIdentifier: "CurrentOpeningsTableViewCellAndXib", for: indexPath) as! CurrentOpeningsTableViewCellAndXib
//
//        cell.lblDetails.text = CurrentOpeningsDataModelArr[indexPath.row].title
//        cell.lblCompanyName.text = CurrentOpeningsDataModelArr[indexPath.row].companyName
//        cell.lblLocation.text = CurrentOpeningsDataModelArr[indexPath.row].location
//        cell.lblExperiance.text = "\(CurrentOpeningsDataModelArr[indexPath.row].minWorkExp) - \(CurrentOpeningsDataModelArr[indexPath.row].maxWorkExp) Years Experience"
//
//
//     //   cell.lblSummary.text = CurrentOpeningsDataModelArr[indexPath.row].desc.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
//
//
//
//
//        if indexPath.row%2 == 0{
//            cell.applied_BtnObj.backgroundColor = UIColor.clear
//            cell.applied_BtnObj.tintColor = #colorLiteral(red: 0.1411764706, green: 0.4745098039, blue: 0.768627451, alpha: 1)
//        }else{
//            cell.applied_BtnObj.backgroundColor = #colorLiteral(red: 0.7176470588, green: 0.8196078431, blue: 0.2039215686, alpha: 1)
//            cell.applied_BtnObj.setTitleColor(UIColor.white, for: .normal)
//
//        }
//
//        return cell
//    }
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JobDescriptionInJobSeekerVC") as! JobDescriptionInJobSeekerVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}

//MARK:- Animation Filter View
//MARK:-
extension CurrentOpeningVC {
    
    func hideFieldsOfFilterView() {
        self.blur.isHidden = true
        self.filterView.isHidden = true
//        self.txtOldPass.isHidden = true
//        self.txtNewPass.isHidden = true
//        self.txtConfirmPass.isHidden = true
    }
    
    func showHideFieldsOfFilterView() {
        self.blur.isHidden = false
        self.filterView.isHidden = false
//        self.txtOldPass.isHidden = false
//        self.txtNewPass.isHidden = false
//        self.txtConfirmPass.isHidden = false
    }
    
    func animateFilterView() {
        showHideFieldsOfFilterView()
        self.filterView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.blur.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.25,
                       initialSpringVelocity: 8.00,
                       options: .allowUserInteraction,
                       animations: {
                        self.filterView.transform = CGAffineTransform.identity
                        self.blur.transform = CGAffineTransform.identity
        })
        
    }
}

extension CurrentOpeningVC {
    func currentOpeningsJobsAPI(){
        
        if InternetConnection.internetshared.isConnectedToNetwork() {
            
            
            
            let passDict = ["fields":["*"],
                            "filter":"IsCertificationJob=0 AND Status=1",
                            "offset":0,
                            "pageSize":20,
                            "query":"",
                            "searchFields":["*"],
                            "sort":["-Timestamp"]] as [String:AnyObject]
            print("PASSDICT", passDict)
            let header = [
                "Content-Type": "application/json; charset=utf-8",
                "X-Auth-Token" : "b20817a7a558ec0adeb7777801bf7973a0be3fa908686b2f72274b46c74ed9e9e9946f041de883c033ad207dd046bcf40af62700c0caf45493bccd3474beab4cf5bcba4c4e13f12b44c9d9485c8a1b66040a1f532c5248b8382d4e9e7baa7edae899a8b09db9069c10809772c94f94860a13d433f57bfa6305a0b0b7364a7a75"
            ]
            macroObj.showLoader(view: self.view)
            alamoFireObj.postRequestURLSearchTap("https://api.searchtap.io/v1/collections/jobs-prod/query", params: passDict, headers: header, success: { (responseJson,responseCode) in
                self.macroObj.hideLoader()
                print(responseJson)
                print(responseCode)
                if responseCode == 200{
                    self.macroObj.hideLoader()
                    if self.CurrentOpeningsDataModelArr.count > 0{
                        self.CurrentOpeningsDataModelArr.removeAll()
                    }
                    print(responseJson)
                    var rId = String()
                    var rDescription = String()
                    var rTitle = String()
                    var rCompanyName = String()
                    var rMaxWorkExperience = String()
                    var rMinWorkExperience = String()
                    var rName = String()
                    
                    if let resultArray = responseJson["results"].arrayObject as NSArray?{
                        for item in resultArray{
                            if let itemDict = item as? NSDictionary{
                                if let id = itemDict.value(forKey: "Id") as? Int{
                                    print(id)
                                    rId = String(id)
                                }
                                if let Description = itemDict.value(forKey: "Description") as? String{
                                    print(Description)
                                    
                                    rDescription = Description.replacingOccurrences(of: "<p>", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "</p>", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "&nbsp;", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "<br>", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "<h3>", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "</h3>", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "<strong>", with: "")
                                    rDescription = rDescription.replacingOccurrences(of: "</strong>", with: "")
                                }
                                if let Title = itemDict.value(forKey: "Title") as? String{
                                    print(Title)
                                    rTitle = Title
                                }
                                if let CompanyName = itemDict.value(forKey: "CompanyName") as? String{
                                    print(CompanyName)
                                    rCompanyName = CompanyName
                                }
                                if let MaxWorkExperience = itemDict.value(forKey: "MaxWorkExperience") as? Int{
                                    print(MaxWorkExperience)
                                    rMaxWorkExperience = String(MaxWorkExperience)
                                }
                                if let MinWorkExperience = itemDict.value(forKey: "MinWorkExperience") as? Int{
                                    print(MinWorkExperience)
                                    rMinWorkExperience = String(MinWorkExperience)
                                }
                                
                                if let LocationToHireDict = itemDict.value(forKey: "LocationToHire") as? NSDictionary{
                                    if let name = LocationToHireDict.value(forKey: "Name") as? String{
                                        print(name)
                                        rName = name
                                    }
                                }
                                
                                
                                let CurrentOpeningsDataModelItem = CurrentOpeningsDataModel(id: rId, title: rTitle, companyName: rCompanyName, maxWorkExp: rMaxWorkExperience, location: rName, minWorkExp: rMinWorkExperience, desc: rDescription, status: Int())
                                self.CurrentOpeningsDataModelArr.append(CurrentOpeningsDataModelItem)
                            }
                        }
                        
                      //  self.tblHome.reloadData()
                        self.kolodaView.reloadData()
                    }
                    
                }else{
                    self.macroObj.hideLoader()
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.VALIDMESSAGE.WrongPasswordOrNumberAlert.rawValue, style: AlertStyle.error)
                }
                
                
            }, failure: { (error,responseCode) in
                print(error.localizedDescription)
                self.macroObj.hideLoader()
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.ErrorMessage.rawValue, style: AlertStyle.error)
            })
        }
        else {
            //LODER HIDE
            self.macroObj.hideLoader()
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: MacrosForAll.ERRORMESSAGE.NoInternet.rawValue, style: AlertStyle.error)
            
        }
    }
}


extension CurrentOpeningVC: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        print(CurrentOpeningsDataModelArr.count)
        return CurrentOpeningsDataModelArr.count
         //return 50
    }
    
   
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let customView =  Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? ExampleOverlayView
        customView?.lblTitle.text = CurrentOpeningsDataModelArr[index].title
        customView?.lblAddress.text = CurrentOpeningsDataModelArr[index].companyName
        customView?.lblExperience.text = "\(CurrentOpeningsDataModelArr[index].minWorkExp) - \(CurrentOpeningsDataModelArr[index].maxWorkExp) Years Experience"
        customView?.lblLocation.text = CurrentOpeningsDataModelArr[index].location
        customView?.lblQualification.text = CurrentOpeningsDataModelArr[index].desc
        return customView!
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        let customView =  Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? ExampleOverlayView
        customView?.lblTitle.text = CurrentOpeningsDataModelArr[index].title
        customView?.lblAddress.text = CurrentOpeningsDataModelArr[index].companyName
        customView?.lblExperience.text = "\(CurrentOpeningsDataModelArr[index].minWorkExp) - \(CurrentOpeningsDataModelArr[index].maxWorkExp) Years Experience"
        customView?.lblLocation.text = CurrentOpeningsDataModelArr[index].location
        customView?.lblQualification.text = CurrentOpeningsDataModelArr[index].desc
        return customView!
    }
}


extension CurrentOpeningVC: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print("aman")
        //UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
      
        let customView =  Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? ExampleOverlayView
        
        customView?.reloadInputViews()
       // KolodaView.viewForCard(at: index)
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

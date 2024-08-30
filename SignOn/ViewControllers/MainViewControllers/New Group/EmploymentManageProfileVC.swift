//
//  EmploymentManageProfileVC.swift
//  SignOn
//
//  Created by Callsoft on 23/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import DropDown
import RSKPlaceholderTextView

class EmploymentManageProfileVC: UIViewController,UITextViewDelegate {
    
    var alamObject = AlamofireWrapper()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let validation:Validation = Validation.validationManager() as! Validation
    
    var dropDownArray = [DropDownStruct]()
    var indusryId = String()
    var yearId = String()
    var monthId = String()
    var passDict = [String:AnyObject]()


    //Mark: AllLabel Mendetory
 
    @IBOutlet weak var specailProjectTextView: RSKPlaceholderTextView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var desingnationLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var startedWorkingLabel: UILabel!
    @IBOutlet weak var specialProjectLabel: UILabel!
    @IBOutlet weak var txtDesingnation: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtmonth: UITextField!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    var itemIndex = Int()
    
    var dropDownTag = Int()

     var monthArr: [String] = ["Start Month","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
     var monthIdArr = [0,1,2,3,4,5,6,7,8,9,10,11,12]
    
    
    
    //Mark:- Variable
    let realm = try! Realm()
    let dropDown = DropDown()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLbl.attributedText = UpdateUIClass.updateSharedInstance.updateHeaderLabel("Manage Profile", "Employment")
        
        desingnationLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Designation")
        
         companyLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Company")
        
        startedWorkingLabel.attributedText = UpdateUIClass.updateSharedInstance.updateLabelWithStar(title: "Start Period")
        
        
       self.specailProjectTextView.text = "Enter Special Project"
       self.specailProjectTextView.textColor = UIColor.lightGray
       self.specailProjectTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if specailProjectTextView.textColor == UIColor.lightGray {
            specailProjectTextView.text = ""
            specailProjectTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if specailProjectTextView.text == "" {
             specailProjectTextView.text = "Enter Special Project"
             specailProjectTextView.textColor = UIColor.lightGray
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if self.dropDownTag == 1{
                self.txtYear.text = "\(item)"
            }
                
            else if self.dropDownTag == 2{
                self.txtmonth.text = "\(item)"
                self.itemIndex = index
            }
        }
        
    }
    
    @IBAction func yaerBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource = DropDowns.shared.preparePassingYear()
        dropDown.anchorView = yearBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    @IBAction func monthBtnAction(_ sender: Any) {
        dropDownTag = (sender as AnyObject).tag
        dropDown.dataSource =  monthArr
        dropDown.anchorView =  monthBtn
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func saveAction(_ sender: UIButton) {
        validationSetup()
    }
    
    @IBAction func btnSkipTapped(_ sender: Any) {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageProfileJobPrefrenceVC")as! ManageProfileJobPrefrenceVC
        home.passDict = self.passDict
        self.navigationController?.pushViewController(home, animated: true)
    }
    
}

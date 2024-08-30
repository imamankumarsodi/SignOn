//
//  RecruiterProfileVC.swift
//  SignOn
//
//  Created by Callsoft on 05/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class RecruiterProfileVC: UIViewController {
    //MARK:--> AllIBoutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var headerLblObj: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblHeaderNameRef: UILabel!
    
    //MARK: - VARIABLES
    var previousOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSetup()
        // Do any additional setup after loading the view.
    }
   
    
}


//MARK: - Extension UserdefineMethod
extension RecruiterProfileVC{
    func intialSetup() {
        scrollView.delegate = self
        headerLblObj.attributedText = UpdateUIClass.updateSharedInstance.updateMentorHeaderLabel("Register", "5 Years 0 month experience \n 9988776655")
        
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
        } else if newHeight > 240 { // or whatever
            newHeight = 240
        }
            //For show hide image profile
        else if newHeight > 75{
            lblHeaderNameRef.isHidden = true
            imgProfile.isHidden = false
        }
        heightConstraint.constant = newHeight
    }
   
}
    
//MARK: - Extension scroll View Data sources and delegates
extension RecruiterProfileVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
}

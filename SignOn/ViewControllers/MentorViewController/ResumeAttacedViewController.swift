//
//  ResumeAttacedViewController.swift
//  SignOn
//
//  Created by Callsoft on 02/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class ResumeAttacedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resumeattached_Action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

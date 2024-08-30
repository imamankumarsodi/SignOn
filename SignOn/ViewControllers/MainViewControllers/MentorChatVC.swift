//
//  MentorChatVC.swift
//  SignOn
//
//  Created by abc on 02/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class MentorChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToMentor(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

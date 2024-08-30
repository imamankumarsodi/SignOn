//
//  LanguageViewController.swift
//  SignOn
//
//  Created by Callsoft on 04/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var write_Btn: UIButton!
    
    @IBOutlet weak var speak_Btn: UIButton!
    
    @IBOutlet weak var read_Btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func read_BtnAction(_ sender: UIButton)
    {
        if (read_Btn.isSelected == true)
        {
            read_Btn.setBackgroundImage(UIImage(named: "checkedMark"), for: UIControl.State.normal)
            
            read_Btn.isSelected = false;
        }
        else
        {
            read_Btn.setBackgroundImage(UIImage(named: "checkBox"), for: UIControl.State.normal)
            
            read_Btn.isSelected = true;
        }
    }
    
    @IBAction func write_BtnAction(_ sender: UIButton)
    {
        if (write_Btn.isSelected == true)
        {
            write_Btn.setBackgroundImage(UIImage(named: "checkedMark"), for: UIControl.State.normal)
            write_Btn.isSelected = false;
        }
        else
        {
            write_Btn.setBackgroundImage(UIImage(named: ""), for: UIControl.State.normal)
            write_Btn.isSelected = true;
        }
    }
    
    @IBAction func speak_BtnAction(_ sender: Any)
    {
        if (speak_Btn.isSelected == true)
        {
            speak_Btn.setBackgroundImage(UIImage(named: "checkedMark"), for: UIControl.State.normal)
            speak_Btn.isSelected = false;
        }
        else
        {
            speak_Btn.setBackgroundImage(UIImage(named: "checkBox"), for: UIControl.State.normal)
            speak_Btn.isSelected = true;
        }
    }
 
}

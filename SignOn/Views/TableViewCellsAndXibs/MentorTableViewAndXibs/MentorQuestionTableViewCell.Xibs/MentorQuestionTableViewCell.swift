//
//  MentorQuestionTableViewCell.swift
//  SignOn
//
//  Created by Callsoft on 04/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class MentorQuestionTableViewCell: UITableViewCell {
    
    //MARK: - OUTLETS
    @IBOutlet weak var imgProfileView: UIImageView!

    @IBOutlet weak var name_Lbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        intialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//MARK: - Extension UserdefineMethod
extension MentorQuestionTableViewCell{
    func intialSetup() {
        name_Lbl.attributedText = UpdateUIClass.updateSharedInstance.updateMentorHeaderLabel("ishita batra", "i am good")
    }
    
}


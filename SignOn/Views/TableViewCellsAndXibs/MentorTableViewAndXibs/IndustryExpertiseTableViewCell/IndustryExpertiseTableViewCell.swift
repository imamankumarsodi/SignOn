//
//  IndustryExpertiseTableViewCell.swift
//  SignOn
//
//  Created by Deepti Sharma on 16/10/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class IndustryExpertiseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

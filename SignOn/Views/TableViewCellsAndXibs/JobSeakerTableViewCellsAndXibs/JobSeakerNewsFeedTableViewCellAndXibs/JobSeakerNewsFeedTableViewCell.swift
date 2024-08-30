//
//  JobSeakerNewsFeedTableViewCell.swift
//  SignOn
//
//  Created by abc on 24/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class JobSeakerNewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

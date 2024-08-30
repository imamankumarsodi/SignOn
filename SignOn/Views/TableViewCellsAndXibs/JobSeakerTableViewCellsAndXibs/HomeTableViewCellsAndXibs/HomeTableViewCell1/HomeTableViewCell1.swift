//
//  HomeTableViewCell1.swift
//  SignOn
//
//  Created by abc on 30/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class HomeTableViewCell1: UITableViewCell {
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

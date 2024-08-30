//
//  sideMenuXib.swift
//  SignOn
//
//  Created by abc on 01/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class sideMenuXib: UITableViewCell {
    //MARK: - OUTLETS
    
    @IBOutlet weak var img_Item: UIImageView!
    @IBOutlet weak var lbl_Names: UILabel!
    @IBOutlet weak var btnCount: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

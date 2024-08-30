//
//  MessageTableViewCell.swift
//  SignOn
//
//  Created by Callsoft on 02/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTimeStamp: UILabel!
    @IBOutlet weak var imgProfileView: UIImageView!
    
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

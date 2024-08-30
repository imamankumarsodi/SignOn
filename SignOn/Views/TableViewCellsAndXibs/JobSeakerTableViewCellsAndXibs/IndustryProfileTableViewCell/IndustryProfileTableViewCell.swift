//
//  IndustryProfileTableViewCell.swift
//  SignOn
//
//  Created by Callsoft on 27/03/19.
//  Copyright © 2019 Callsoft. All rights reserved.
//

import UIKit

class IndustryProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var message_Btn: UIButton!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        bgView.layer.shadowColor = UIColor.white.cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 5
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  NewsFeedTableViewCell.swift
//  SignOn
//
//  Created by Callsoft on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.shadowColor = UIColor.white.cgColor
        bgView.layer.shadowOpacity = 4
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

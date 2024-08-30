//
//  MentorsTableViewCellAndXib.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class MentorsTableViewCellAndXib: UITableViewCell {
    //MARK: - OUTLETS
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btn_AskQuestion: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

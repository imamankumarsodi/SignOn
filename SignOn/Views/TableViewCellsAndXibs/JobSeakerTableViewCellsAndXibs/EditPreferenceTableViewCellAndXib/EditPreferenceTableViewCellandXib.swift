//
//  EditPreferenceTableViewCellandXib.swift
//  SignOn
//
//  Created by abc on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class EditPreferenceTableViewCellandXib: UITableViewCell {
    //MARK: - OUTLETS
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFieldDetails: UITextField!
  
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var viewSeparator: UIView!
    
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

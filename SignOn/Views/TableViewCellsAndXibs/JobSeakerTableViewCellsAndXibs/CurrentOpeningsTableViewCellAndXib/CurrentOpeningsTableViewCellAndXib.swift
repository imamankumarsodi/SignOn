//
//  CurrentOpeningsTableViewCellAndXib.swift
//  SignOn
//
//  Created by abc on 27/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class CurrentOpeningsTableViewCellAndXib: UITableViewCell {

    @IBOutlet weak var lblDetails: UILabel!
    
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblExperiance: UILabel!
    @IBOutlet weak var applied_BtnObj: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

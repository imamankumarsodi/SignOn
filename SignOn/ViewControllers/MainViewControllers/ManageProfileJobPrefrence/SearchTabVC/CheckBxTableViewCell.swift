//
//  CheckBxTableViewCell.swift
//  LimtedTableExample
//
//  Created by Callsoft on 22/05/19.
//  Copyright © 2019 Gene De Lisa. All rights reserved.
//

import UIKit

class CheckBxTableViewCell: UITableViewCell {

    @IBOutlet weak var chk_BoxBtn: UIButton!
 
    
    @IBOutlet weak var name_Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

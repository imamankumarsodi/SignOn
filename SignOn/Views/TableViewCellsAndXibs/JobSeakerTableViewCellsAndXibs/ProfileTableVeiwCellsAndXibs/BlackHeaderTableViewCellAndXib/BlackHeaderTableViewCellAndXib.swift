//
//  BlackHeaderTableViewCellAndXib.swift
//  SignOn
//
//  Created by Aman on 07/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class BlackHeaderTableViewCellAndXib: UITableViewCell {
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewBottom: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

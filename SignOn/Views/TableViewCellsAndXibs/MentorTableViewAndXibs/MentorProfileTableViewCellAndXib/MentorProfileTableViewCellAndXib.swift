//
//  MentorProfileTableViewCellAndXib.swift
//  SignOn
//
//  Created by Callsoft on 04/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class MentorProfileTableViewCellAndXib: UITableViewCell {
    //MARK: - OUTLETS
    @IBOutlet weak var name_Lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

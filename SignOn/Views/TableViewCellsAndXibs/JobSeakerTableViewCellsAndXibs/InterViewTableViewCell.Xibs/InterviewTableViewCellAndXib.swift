//
//  InterviewTableViewCellAndXib.swift
//  SignOn
//
//  Created by abc on 13/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class InterviewTableViewCellAndXib: UITableViewCell {

    @IBOutlet weak var lblWayOfInterview: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblInterviewType: UILabel!
    @IBOutlet weak var lblInterViewStatus: UILabel!
    @IBOutlet weak var btnTitle: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

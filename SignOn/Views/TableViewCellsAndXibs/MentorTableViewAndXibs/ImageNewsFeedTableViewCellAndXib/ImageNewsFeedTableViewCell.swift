//
//  ImageNewsFeedTableViewCell.swift
//  SignOn
//
//  Created by Callsoft on 28/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class ImageNewsFeedTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var btnLikeRef: UIButton!
    @IBOutlet weak var btnCommentRef: UIButton!
    @IBOutlet weak var btnReportRef: UIButton!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var lblLikeComments: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    
    //Comment Section
    @IBOutlet weak var commentPersonImageHeight: NSLayoutConstraint!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblCommentHeight: NSLayoutConstraint!
    @IBOutlet weak var timeClockHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCommentTime: UILabel!
    
    @IBOutlet weak var heightLblTime: NSLayoutConstraint!
    @IBOutlet weak var imgCommentProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

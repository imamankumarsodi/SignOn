//
//  CommentTableViewCellAndXib.swift
//  SignOn
//
//  Created by Deepti Sharma on 24/07/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit

class CommentTableViewCellAndXib: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(info:CommentDataModel){
        imgView.sd_setImage(with: URL(string: info.image), placeholderImage: UIImage(named: "groupicon"))
        nameLbl.attributedText = UpdateUIClass.updateSharedInstance.forNewsFeeedLblMethodComments(info.userName, info.comment)
        
    }
    
}

//
//  CommentDataModel.swift
//  SignOn
//
//  Created by Deepti Sharma on 24/07/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
class CommentDataModel{
    var image = String()
    var userName = String()
    var date = String()
    var comment = String()
    var id = String()
    init(image:String,userName:String,date:String,comment:String,id:String){
        self.image = image
        self.userName = userName
        self.date = date
        self.comment = comment
        self.id = id
    }
}

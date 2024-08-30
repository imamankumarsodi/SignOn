 
//  NotificationModel.swift
//  SignOn

//  Created by Callsoft on 01/06/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
 
 class NotifiationList {
    var profileImage = String()
    var timestamp = String()
    var postid = String()
    var body = String()
    var title = String()
    
    init(profileImage:String,postid:String,body:String,title:String,timestamp:String){
        
        self.profileImage = profileImage
        self.postid  = postid
        self.body = body
        self.title = title
        self.timestamp = timestamp
    }
 }

//
//  MessageListingModel1.swift
//  SignOn
//
//  Created by Callsoft on 02/06/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
class MentorHomeMessageListingModel{
    var Name = String()
    var Message = String()
    var Url = String()
    var profileUrl = String()
    var timeStamp = String()
    var id = String()
    
    init(Name:String,Message:String,Url:String,profileUrl:String,timeStamp:String,id:String){
        self.Name = Name
        self.Message = Message
        self.Url = Url
        self.profileUrl = profileUrl
        self.timeStamp = timeStamp
        self.id = id
    }
}

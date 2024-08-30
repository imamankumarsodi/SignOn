//
//  MentorListModel.swift
//  SignOn
//
//  Created by Callsoft on 02/06/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
class MentorModelList{
    var Name = String()
    var Message = String()
    var Url = String()
    var email = String()
    var id = String()
    
    init(Name:String,Message:String,Url:String,email:String,id:String){
        self.Name = Name
        self.Message = Message
        self.Url = Url
        self.email = email
        self.id = id
    }
}

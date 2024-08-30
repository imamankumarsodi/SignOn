//
//  CurrentOpeningsDataModel.swift
//  SignOn
//
//  Created by abc on 02/06/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
class CurrentOpeningsDataModel{
    var id = String()
    var title = String()
    var companyName = String()
    var maxWorkExp = String()
    var minWorkExp = String()
    var location = String()
    var desc = String()
    var status = Int()
    
    init(id:String,title:String,companyName:String,maxWorkExp:String,location:String,minWorkExp:String,desc:String,status:Int){
        self.id = id
        self.title = title
        self.companyName = companyName
        self.maxWorkExp = maxWorkExp
        self.location = location
        self.minWorkExp = minWorkExp
        self.desc = desc
        self.status = status
    }
}

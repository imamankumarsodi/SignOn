//
//  AppliedJobsDataModel.swift
//  SignOn
//
//  Created by abc on 02/06/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
class AppliedJobsDataModel{
    var id = String()
    var title = String()
    var companyName = String()
    var status = Int()
    
    init(id:String,title:String,companyName:String,status:Int){
        self.id = id
        self.title = title
        self.companyName = companyName
        self.status = status
    }
}

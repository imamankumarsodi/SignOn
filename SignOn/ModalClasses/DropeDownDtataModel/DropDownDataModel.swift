//
//  DropDownDataModel.swift
//  SignOn
//
//  Created by Callsoft on 09/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

struct DropDownStruct{
    
    var id:String!
    var text:String!
 
    init(id:String,text:String){
        self.id = id
        self.text = text
      }
 
}
struct SearchDataStruct {
    var Index:Int
    var text:String!
    init(index:Int,text:String){
        self.Index = index
        self.text = text
    }
}

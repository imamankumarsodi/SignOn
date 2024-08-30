//
//  SearchBarModel.swift
//  SignOn
//
//  Created by Callsoft on 29/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
protocol searchModel { // Create Protocol
    func  SearchData()->[SearchDataStruct]
}
class SearchBar{
    func SearchData() -> [SearchDataStruct] {
        var SearchdataSource =  [SearchDataStruct]()
        SearchdataSource.append(SearchDataStruct(index:0,  text:""))
        
        return SearchdataSource
    }
    
}

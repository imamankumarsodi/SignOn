//
//  AllDropDown.swift
//  SignOn
//
//  Created by Callsoft on 09/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
protocol DropDownModel { // Create Protocol
 func  prepareDropDown()->[DropDownStruct]
}
class DesignationDropDown: DropDownModel {
    func prepareDropDown() -> [DropDownStruct] {

        var dataSource = [DropDownStruct]()   // here we crete a dropdown Array
        dataSource.append(DropDownStruct(id    : "294", text: "Head"))
        dataSource.append(DropDownStruct(id    : "295", text: "Senior Management"))
        dataSource.append(DropDownStruct(id    : "296", text: "Middle Management"))
        dataSource.append(DropDownStruct(id    : "297", text: "Junior Management"))
        dataSource.append(DropDownStruct(id    : "298", text: "CEO"))
        dataSource.append(DropDownStruct(id    : "299", text: "COO"))
        dataSource.append(DropDownStruct(id    : "300", text: "CFO"))
        dataSource.append(DropDownStruct(id    : "301", text: "Managing Director"))
        dataSource.append(DropDownStruct(id    : "302", text: "Director"))
        dataSource.append(DropDownStruct(id    : "303", text: "Sr. Vice president"))
        dataSource.append(DropDownStruct(id    : "304", text: "Vice President"))
        dataSource.append(DropDownStruct(id    : "305", text: "Assistant Vice President"))
        dataSource.append(DropDownStruct(id    : "306", text: "General Manager"))
        dataSource.append(DropDownStruct(id    : "307", text: "Deputy General Manager"))
        dataSource.append(DropDownStruct(id    : "308", text: "Sr. Manager"))
        dataSource.append(DropDownStruct(id    : "309", text: "Manager"))
        dataSource.append(DropDownStruct(id    : "310", text: "Deputy Manager"))
        dataSource.append(DropDownStruct(id    : "311", text: "Asst. Manager"))
        dataSource.append(DropDownStruct(id    : "312", text: "Sr. Officer"))
        dataSource.append(DropDownStruct(id    : "313", text: "Officer"))
        dataSource.append(DropDownStruct(id    : "314", text: "Jr. Officer"))
        dataSource.append(DropDownStruct(id    : "315", text: "Sr. Associate"))
        dataSource.append(DropDownStruct(id    : "316", text: "Associate"))
        dataSource.append(DropDownStruct(id    : "317", text: "Jr. Associate"))
        dataSource.append(DropDownStruct(id    : "318", text: "Assistant"))
        dataSource.append(DropDownStruct(id    : "319", text: "Analyst"))
        dataSource.append(DropDownStruct(id    : "320", text: "Sr.Analyst"))
        dataSource.append(DropDownStruct(id    : "321", text: "Executive"))
        dataSource.append(DropDownStruct(id    : "322", text: "Sr. Executive"))
        dataSource.append(DropDownStruct(id    : "323", text: "Trainee"))
        dataSource.append(DropDownStruct(id    : "324", text: "Technician"))
        dataSource.append(DropDownStruct(id    : "325", text: "Expert"))
        dataSource.append(DropDownStruct(id    : "326", text: "Teacher    "))
        dataSource.append(DropDownStruct(id    : "327", text: "Scientist"))
        dataSource.append(DropDownStruct(id    : "328", text: "Auditor"))
        dataSource.append(DropDownStruct(id    : "329", text: "Specialist"))
        dataSource.append(DropDownStruct(id    : "330", text: "Fresher"))
        dataSource.append(DropDownStruct(id    : "331", text: "Interns"))
        dataSource.append(DropDownStruct(id    : "332", text: "SME/Mentors/ Asst. Team Leaders"))
        dataSource.append(DropDownStruct(id    : "333", text: "Team Leaders"))
        dataSource.append(DropDownStruct(id    : "334", text: "Team Managers"))
        dataSource.append(DropDownStruct(id    : "335", text: "Self Employed"))
        return dataSource
    }
}


class IndustryEpertise : DropDownModel{
    func prepareDropDown() -> [DropDownStruct] {
        
        var dataSource = [DropDownStruct]()   // here we crete a dropdown Array
        dataSource.append(DropDownStruct(id    : "187", text: "Advertising/PR/Events"))
        dataSource.append(DropDownStruct(id    : "188", text: "Automotive/ Ancillaries"))
        dataSource.append(DropDownStruct(id    : "189", text: "Banking/ Financial Services"))
        dataSource.append(DropDownStruct(id    : "190", text: "Bio Technology & Life Sciences"))
        dataSource.append(DropDownStruct(id    : "191", text: "Chemicals/Petrochemicals"))
        dataSource.append(DropDownStruct(id    : "192", text: "Construction & Engineering"))
        dataSource.append(DropDownStruct(id    : "193", text: "FMCG"))
        dataSource.append(DropDownStruct(id    : "194", text: "Courier/ Freight/ Transportation"))
        dataSource.append(DropDownStruct(id    : "195", text: "Education"))
        dataSource.append(DropDownStruct(id    : "196", text: "E-Learning"))
        dataSource.append(DropDownStruct(id    : "197", text: "Engineering, Procurement, Construction"))
        dataSource.append(DropDownStruct(id    : "198", text: "Entertainment/ Media/ Publishing"))
        dataSource.append(DropDownStruct(id    : "199", text: "Food & Packaged Food"))
        dataSource.append(DropDownStruct(id    : "200", text: "Hospitals/Healthcare/Diagnostics"))
        dataSource.append(DropDownStruct(id    : "201", text: "Hotels/ Restaurant"))
        dataSource.append(DropDownStruct(id    : "202", text: "Insurance"))
        dataSource.append(DropDownStruct(id    : "203", text: "IT/ Computers- Hardware"))
        dataSource.append(DropDownStruct(id    : "204", text: "IT/ Computers - Software"))
        dataSource.append(DropDownStruct(id    : "205", text: "ITES/BPO"))
        dataSource.append(DropDownStruct(id    : "206", text: "KPO/Analytics"))
        dataSource.append(DropDownStruct(id    : "207", text: "Machinery/ Equipment Mfg."))
        dataSource.append(DropDownStruct(id    : "208", text: "Oil/ Gas/ Petroleum"))
        dataSource.append(DropDownStruct(id    : "209", text: "Pharmaceutical"))
        dataSource.append(DropDownStruct(id    : "210", text: "Public Relations (PR)"))
        dataSource.append(DropDownStruct(id    : "211", text: "Real Estate"))
        dataSource.append(DropDownStruct(id    : "212", text: "Retailing"))
        dataSource.append(DropDownStruct(id    : "213", text: "Shipping/ Marine Services"))
        dataSource.append(DropDownStruct(id    : "214", text: "Telecom"))
        dataSource.append(DropDownStruct(id    : "215", text: "Travel/ Tourism"))
         
        return dataSource
    }
}

class Eductaion: DropDownModel {
    
    func prepareDropDown() -> [DropDownStruct] {
        var dataSource = [DropDownStruct]()   // here we crete a dropdown Array
        dataSource.append(DropDownStruct(id    : "3", text: "Bachelors degree"))
        dataSource.append(DropDownStruct(id    : "4", text: "Diploma"))
        dataSource.append(DropDownStruct(id    : "5", text: "Masters Degree"))
        dataSource.append(DropDownStruct(id    : "6", text: "CPA"))
        dataSource.append(DropDownStruct(id    : "7", text: "CFA"))
        dataSource.append(DropDownStruct(id    : "8", text: "Postgraduate Qualification"))
        dataSource.append(DropDownStruct(id    : "9", text: "Chartered Accountant"))
        dataSource.append(DropDownStruct(id    : "10", text: "Company Secretary"))
        dataSource.append(DropDownStruct(id    : "11", text: "Matriculation"))
        dataSource.append(DropDownStruct(id    : "12", text: "PGDM"))
        dataSource.append(DropDownStruct(id    : "13", text: "Others"))

    return dataSource
    }
}

class Degree: DropDownModel {
    func prepareDropDown() -> [DropDownStruct] {
        
        var dataSource = [DropDownStruct]()
        
        dataSource.append(DropDownStruct(id    : "14", text: "Any graduate"))
        dataSource.append(DropDownStruct(id    : "15", text: "Aviation"))
        dataSource.append(DropDownStruct(id    : "16", text: "B.A"))
        dataSource.append(DropDownStruct(id    : "17", text: "B.Arch graduate"))
        dataSource.append(DropDownStruct(id    : "18", text: "B.B.A"))
        dataSource.append(DropDownStruct(id    : "19", text: "BCA"))
        dataSource.append(DropDownStruct(id    : "20", text: "B.Com"))
        dataSource.append(DropDownStruct(id    : "21", text: "BDS"))
        dataSource.append(DropDownStruct(id    : "22", text: "B.E/B.Tech"))
        dataSource.append(DropDownStruct(id    : "23", text: "B.Ed"))
        dataSource.append(DropDownStruct(id    : "24", text: "BAMS"))
        dataSource.append(DropDownStruct(id    : "25", text: "BHM"))
        dataSource.append(DropDownStruct(id    : "26", text: "BHMS"))
        dataSource.append(DropDownStruct(id    : "27", text: "BL/LLB"))
        dataSource.append(DropDownStruct(id    : "28", text: "B.Pharm"))
        dataSource.append(DropDownStruct(id    : "29", text: "B.Sc"))
        dataSource.append(DropDownStruct(id    : "30", text: "BSW"))
        dataSource.append(DropDownStruct(id    : "31", text: "CA"))
        dataSource.append(DropDownStruct(id    : "32", text: "CA Inter"))
        dataSource.append(DropDownStruct(id    : "33", text: "Class 12"))
        dataSource.append(DropDownStruct(id    : "34", text: "CS"))
        dataSource.append(DropDownStruct(id    : "35", text: "Diploma"))
        dataSource.append(DropDownStruct(id    : "36", text: "DSW"))
        dataSource.append(DropDownStruct(id    : "37", text: "ICWA"))
        dataSource.append(DropDownStruct(id    : "38", text: "ICWA Inter"))
        dataSource.append(DropDownStruct(id    : "39", text: "M.A"))
        dataSource.append(DropDownStruct(id    : "40", text: "M.Arch"))
        dataSource.append(DropDownStruct(id    : "41", text: "MBA"))
        dataSource.append(DropDownStruct(id    : "42", text: "MBBS"))
        dataSource.append(DropDownStruct(id    : "43", text: "M.Com"))
        dataSource.append(DropDownStruct(id    : "44", text: "MBA"))
        dataSource.append(DropDownStruct(id    : "45", text: "MD/MS"))
        dataSource.append(DropDownStruct(id    : "46", text: "M.Ed"))
        dataSource.append(DropDownStruct(id    : "47", text: "M.E/M.Tech/MS"))
        dataSource.append(DropDownStruct(id    : "48", text: "ML/LLM"))
        dataSource.append(DropDownStruct(id    : "49", text: "M.Pharm"))
        dataSource.append(DropDownStruct(id    : "50", text: "Mphil"))
        dataSource.append(DropDownStruct(id    : "51", text: "M.Sc"))
        dataSource.append(DropDownStruct(id    : "52", text: "MSW"))
        dataSource.append(DropDownStruct(id    : "53", text: "PGDCA"))
        dataSource.append(DropDownStruct(id    : "54", text: "PG Diploma"))
        dataSource.append(DropDownStruct(id    : "55", text: "PGDM"))
        dataSource.append(DropDownStruct(id    : "56", text: "PGP"))
        dataSource.append(DropDownStruct(id    : "57", text: "PGPX"))
        dataSource.append(DropDownStruct(id    : "58", text: "Phd"))
        dataSource.append(DropDownStruct(id    : "59", text: "Others"))
 
        return dataSource
    }
 }

class Specilization: DropDownModel {
    func prepareDropDown() -> [DropDownStruct] {
        var dataSource =  [DropDownStruct]()
        dataSource.append(DropDownStruct(id:"",  text:""))
        
        return dataSource
    }
     
}


class DropDowns {
    static let shared = DropDowns()
     func prepareYearDropDown() -> [String] {
        var yearArr = [String]()
        
        
        for index in 0...40{
            if index == 0{
                yearArr.append("Year")
            }
            else{
                 yearArr.append("\(index) Year")
            }
            print(yearArr)
        }
        return yearArr
    }
    
    func prepareMonthDropDown() -> [String] {
        var monthArr = [String]()
            for index in 0...12{
            if index == 0{
                monthArr.append("Month")
            }
            else{
                monthArr.append("\(index) Month")
            }
            print(monthArr)
        }
        return monthArr
    }
    
    func preparePassingYear() -> [String] {
        var monthArr = [String]()
        for index in 1960...2020{
            if index == 0{
                monthArr.append("Passing Year")
            }
            else{
                monthArr.append("\(index)")
            }
            print(monthArr)
        }
        return monthArr
    }
    
    func prepareExperienceYear() -> [String] {
        var monthArr = [String]()
        for index in 0...30{
            if index == 0{
                monthArr.append("Passing Year")
            }
            else{
                monthArr.append("\(index)")
            }
            print(monthArr)
        }
        return monthArr
    }
    
 }

 
 

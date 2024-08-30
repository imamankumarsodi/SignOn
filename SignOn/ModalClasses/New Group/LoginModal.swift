//
//  LoginModal.swift
//  SignOn
//
//  Created by Callsoft on 18/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class LoginDataModal:Object{
    @objc dynamic var token = String()
    @objc dynamic var Id = String()
    @objc dynamic var isMentor = Bool()

    
    //JOB SEAKER
    var profilrComlpeteFactor = Int()

    @objc dynamic var IsValidVisa = Bool()
    @objc dynamic var AnnualSalary = Int()
    @objc dynamic var Otp = Int()
    @objc dynamic var Mobile = String()
    @objc dynamic var Bio = String()
    @objc dynamic var Gender = Int()
    @objc dynamic var AddressId = String()
    @objc dynamic var PreferedExpectedSalaryIds = String()
    @objc dynamic var Location = String()
    @objc dynamic var FunctionalArea = String()
    @objc dynamic var RankingPercentileScore = String()
    @objc dynamic var NoticePeriod = String()
    @objc dynamic var Address = String()
    @objc dynamic var Certification = String()
    @objc dynamic var Feedback = String()
    @objc dynamic var IndirectRepotees = String()
    @objc dynamic var HasValidPassport = Bool()
    @objc dynamic var SignonScore = Int()
    @objc dynamic var EmploymentTypes = Int()
    @objc dynamic var ProfileCompleteFactor = Int()
    @objc dynamic var IsPhysicallyChallenged = Bool()
    @objc dynamic var Dob = String()
    @objc dynamic var MaritalStatus = Int()
    @objc dynamic var DirectRepotees = Int()
    @objc dynamic var ResumeId = String()
    @objc dynamic var CandidateRoleId = String()
    @objc dynamic var ExpectedSalaries = String()
    @objc dynamic var CandidateFunctionalAreaId = String()
    @objc dynamic var CandidateIndustryId = String()
    @objc dynamic var IsPhoneVerified = Bool()
    @objc dynamic var Role = String()
    @objc dynamic var ProfileImageId = Int()
    @objc dynamic var Resume = String()
    @objc dynamic var HasWorkPermit = String()
    @objc dynamic var Industry = String()
    @objc dynamic var VersantScore = String()
    @objc dynamic var JobTypes = Int()
 
    @objc dynamic var ProfileViewCount = Int()
    @objc dynamic var UserName = String()
    @objc dynamic var LinkedinUrl = String()
    @objc dynamic var UserRole = String()
    @objc dynamic var Email = String()
    @objc dynamic var TotalWorkingExperience = String()
    @objc dynamic var GoogleUrl = String()
    @objc dynamic var FcmIds = String()
    @objc dynamic var Name = String()
    @objc dynamic var FacebookUrl = String()
    @objc dynamic var IsActive = Bool()
    
    @objc dynamic var DesignationId = Int()
    @objc dynamic var CompanyName = String()
    @objc dynamic var Designation = String()
    @objc dynamic var ProfessionalSummary = String()
    @objc dynamic var Status = Bool()
    @objc dynamic var ProfileImage = String()
    @objc dynamic var ProfileStatus = String()
    
    
    //Skills
    
    @objc dynamic var SkillsId = Int()
    @objc dynamic var SkillsValue = String()
    @objc dynamic var SkillsName = String()
    @objc dynamic var SkillsDisplayOrder = String()
    @objc dynamic var SkillsDataType = String()
    @objc dynamic var SkillsIsIndex = Bool()
    @objc dynamic var SkillsParentId = String()
    
    //KeyWords
    
    @objc dynamic var KeywordsId = Int()
    @objc dynamic var KeywordsName = String()
    @objc dynamic var KeywordsValue = String()
    @objc dynamic var KeywordsDisplayOrder = String()
    @objc dynamic var KeywordsDataType = String()
    @objc dynamic var KeywordsIsIndex = Bool()
    @objc dynamic var KeywordsParentId = String()
    
    
    //PrefrerdIndustry
    
    @objc dynamic var PrefrerdIndustryId = Int()
    @objc dynamic var PrefrerdIndustryName = String()
    @objc dynamic var PrefrerdIndustryValue = String()
    @objc dynamic var PrefrerdIndustryDisplayOrder = String()
    @objc dynamic var PrefrerdIndustryDataType = String()
    @objc dynamic var PrefrerdIndustryIsIndex = Bool()
    @objc dynamic var PrefrerdIndustryParentId = String()
    
    //PrefrerdFuncitionalArea
    
    @objc dynamic var PrefrerdFuncitionalAreaId = Int()
    @objc dynamic var PrefrerdFuncitionalAreaName = String()
    @objc dynamic var PrefrerdFuncitionalAreaValue = String()
    @objc dynamic var PrefrerdFuncitionalAreaDisplayOrder = String()
    @objc dynamic var PrefrerdFuncitionalAreaDataType = String()
    @objc dynamic var PrefrerdFuncitionalAreaIsIndex = Bool()
    @objc dynamic var PrefrerdFuncitionalAreaParentId = String()
    
    //PrefrerdRoles
    
    @objc dynamic var PrefrerdRolesId = Int()
    @objc dynamic var PrefrerdRolesName = String()
    @objc dynamic var PrefrerdRolesValue = String()
    @objc dynamic var PrefrerdRolesDisplayOrder = String()
    @objc dynamic var PrefrerdRolesDataType = String()
    @objc dynamic var PrefrerdRolesIsIndex = Bool()
    @objc dynamic var PrefrerdRolesParentId = String()
    
    //Images
    @objc dynamic var ImageId = Int()
    @objc dynamic var UniqueName = String()
    @objc dynamic var Url = String()
    @objc dynamic var ImageName = String()
    
    
    
    
    // Mentors:-------------------------------------------->>>>>>>>>>>
    
    @objc dynamic var TotalWorkExperience = String()

    
    //Industries
    @objc dynamic var IndustriesId = Int()
    @objc dynamic var IndustriesName = String()
    @objc dynamic var IndustriesValue = String()
    @objc dynamic var IndustriesDisplayOrder = String()
    @objc dynamic var IndustriesDataType = String()
    @objc dynamic var IndustriesIsIndex = Bool()
    @objc dynamic var IndustriesParentId = String()

    //Designation
     @objc dynamic var DesignationName = String()
    @objc dynamic var DesignationValue = String()
    @objc dynamic var DesignationDisplayOrder = String()
    @objc dynamic var DesignationDataType = String()
    @objc dynamic var DesignationIsIndex = Bool()
    @objc dynamic var DesignationParentId = String()
    
}

class ManageProfilePersonalJobSeaker{
    var fullName = String()
    var emailID = String()
    var phoneNumber = String()
    var Dob = String()
    var gender = String()
    var industryExpertise = String()
    var years = String()
    var month = String()
    var selectMeterealStatus = String()
    var profesonalSummary = String()
    var line1 = String()
    var line2 = String()
    var landMark = String()
    var city = String()
    var state = String()
    var country = String()
    var pincode = String()
}
class ManageProfileEducationJobSeaker{
    var selectQualification = String()
    var institution = String()
    var phoneNumber = String()
    var degreeCourse = String()
    var specilization = String()
    var courseType = String()
    var passingYears = String()
 }

class ManageProfileEmploymentJobSeaker{
    var desingnation = String()
    var company = String()
    var startYear    = String()
    var startMonth = String()
    var specialProject = String()
}


class ManageProfileJobPrefrnceJobSeaker{
    var keyword = String()
    var location = String()
    var minimumSalary    = String()
    var industry = String()
    var funcitionalArea = String()
    var roles = String()

}


class ManageProfileProfesnalSummaryJobSeaker{
    var bio = String()
    var lacksStr = String()
    var thousandStr = String()
    var selectJobType = String()
    var employmentType = String()
    var workpermitOutsideIndia = String()
    var validPassword = String()
    var validVisa = String()
    var physicalChallanged = String()
    var noticePeriod = String()
    var role = String()
    var funcitionalArea = String()
    var industry = String()
    var city = String()
    var state = String()
    var country = String()
    var pincode = String()
    var toolsWorkedOn = String()
    var regionServed = String()
    var certification = String()
    var directReportise = String()
    var indirectReportise = String()
  }

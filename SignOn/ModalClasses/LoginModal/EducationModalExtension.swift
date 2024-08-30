//
//  EducationModalExtension.swift
//  SignOn
//
//  Created by Callsoft on 02/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class EducationModalExtension: Object {
    @objc dynamic var CandidateId               = String()
    @objc dynamic var InstitutionName           = String()
 
    
    @objc dynamic var QualificationId           = String()
    @objc dynamic var QualificationName         = String()
    @objc dynamic var QualificationValue        = String()
    @objc dynamic var QualificationDisplayOrder = String()
    @objc dynamic var QualificationDataType     = String()
    @objc dynamic var QualificationIsIndex      = Bool()
    @objc dynamic var QualificationParentId     = String()
    @objc dynamic var QId                       = String()
    @objc dynamic var QualificationUpdatedAt    = String()
    
    @objc dynamic var DegreeId                  = String()
    @objc dynamic var DegreeName                = String()
    @objc dynamic var DegreeValue               = String()
    @objc dynamic var DegreeDisplayOrder        = String()
    @objc dynamic var DegreeDataType            = String()
    @objc dynamic var DegreeIsIndex             = Bool()
    @objc dynamic var DegreeParentId            = String()
    @objc dynamic var DId                       = String()
    @objc dynamic var SpecialisationId          = String()
    @objc dynamic var SpecialisationName        = String()
    @objc dynamic var SpecialisationValue       = String()
    @objc dynamic var SpecialisationDataType    = String()
    @objc dynamic var SpecialisationIsIndex     = Bool()
    @objc dynamic var SpecialisationParentId    = String()
    @objc dynamic var SId                       = String()
    @objc dynamic var SpecialisationCourseId    = String()
    @objc dynamic var CourseName                = String()
    @objc dynamic var CourseValue               = String()
    @objc dynamic var CourseDisplayOrder        = String()
    @objc dynamic var CourseDataType            = String()
    @objc dynamic var CourseIsIndex             = Bool()
    @objc dynamic var CourseParentId            = String()
    @objc dynamic var  CourseId                 = String()
    @objc dynamic var CoursePassingYear         = String()
    @objc dynamic var Role                       = String()

    
}

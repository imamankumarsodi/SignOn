//
//  Constants.swift
//  SignOn
//
//  Created by Callsoft on 18/04/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

//MARK:- API Names
//MARK:-
class APIName {
    
// https://beta-signon.azurewebsites.net/api/v1/mentors/1859
    
    static var login              = "account/login"
    static var registration       =  "account/register"
    static var OTPApi             =  "account/otp"
    static var OTPVerify          = "account/otp/verify"
    static var setPassword        = "account/SetPassword"
    static var sendImage          = "users"
    static var firstGetAllHomeData = "candidates"
    static var homeNewsFeedList   = "feeds?page=1&pageSize=10"
    static let feed = "feeds"
    
 
    static var recomendedCount         =  "jobs/latestRecommendedJobAndCount"
    static var currentopenningCount    =  "jobs/latestRecommendedJobAndCount"
    static var AppliedJobsCount        =  "jobs/latestAppliedJobAndCount"
    static var AppliedDesbordJobs      =  "jobs"
    static var employementsUrl         = "employments"
    static var mentor                  = "mentors"


    static var recomendedJobs = "jobs?recommended=true&applied=false&shortListed=false&page=1&pageSize=10"
    
    static var appliedJobs = "jobs?recommended=false&applied=true&shortListed=false&page=1&pageSize=10"
    static var currentOpenings = "jobs?recommended=false&applied=false&shortListed=false&page=1&pageSize=10"
   
}

//MARK:- Alert Messages

//MARK:-

class ALERT_MESSAGES {
    static var AppName = "SignOn"
    static var internetConnectionError = "No internet access"
    static var SomethingWentWrong      = "Something else"
    static var numberIsAllreadyUse      = "Number Is Already Used"

    static var setPassword             = "Passsword Change Successfully"

    static var OtpWrong                 = "Incorrect Otp"

    static var loginSuccessfully       = "You have login successfully"
    static var registration            = ""
}


//
//  MacrosForAll.swift
//  Monami
//
//  Created by abc on 22/11/18.
//  Copyright © 2018 mobulous. All rights reserved.
//

import Foundation
import UIKit
import Lottie
public class MacrosForAll:NSObject{
    public class var sharedInstanceMacro: MacrosForAll {
        struct Singleton {
            static let instance: MacrosForAll = MacrosForAll()
        }
        return Singleton.instance
    }
    override init() {}
    //MARK: - Variables
    //TODO: App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //TODO: Base URL
    let appName = "SignOn"
    
    var imageView = UIImageView()
    
    let animationView = AnimationView(name: "8052-follow-me")
    //TODO: App Languages
    enum AppLanguage : String {
        case ENGLISH = "en"
        case PORTUGUESE  = "portu"
    }
    enum APINAME : String {
        case ParentSignUp       = "parentsignup"
        case CheckEmailId       = "checkemailid"
        case login              = "login"
        case editprofile        = "editprofile"
        case mapparentcuid      = "mapparentcuid"
        case followaction       = "followaction"
        case sociallogin        = "sociallogin"
        case postlist           = "postlist"
        case changepassword     = "changepassword"
        case followinglist      = "followinglist"
        case familylist         = "familylist"
        case accessforfamily    = "accessforfamily"
        case deleteaccessoffamily    = "deleteaccessoffamily"
        case forgotpassword     = "forgotpassword"
        case resetpassword      = "resetpassword"
        case notificationtrigger      = "notificationtrigger"
        case commentlist        = "commentlist"
        case commentonpost      = "commentonpost"
        case childprofile       = "childprofile"
        case commonsection      = "commonsection"
        case chatlist           = "chatlist"
        case sendmsg            = "sendmsg"
        case aboutus            = "aboutus"
        case reportsection      = "reportsection"
        case getmeal            = "getmeal"
        case notificationList   = "notficationlist"
        case deletepostbyparent   = "deletepostbyparent"
        case reportpreview   = "reportpreview"
        case notify_count   = "notify_count"
        case changelang   = "changelang"
        case deletecomment = "deletecomment"
        case editcomment = "editcomment"
        
    }
    enum VALIDMESSAGE : String {
        //Basic Signup
        case EnterFullName                           = "Please enter full name."
        case EnterFullBio                           = "Please enter Bio."

        case EnterValidFullName                      = "Please enter your valid full name. (Full Name contains A-Z or a-z, no special character or digits are allowed.)"
        case EnterValidFullNameLength                = "Full name length should atleast of 4 characters."
        case EnterMobileNumber                       = "Please enter phone number."
        case DesingnationField                       = "Please enter Desingnation."
        case Year                                    = "Please enter Year."
        case Month                                   = "Please enter Month."
        case specialProjectPlan                      = "Please enter SpecialProjectPlan  ."

        case SelectIndusstry                         = "Please enter SelectIndusstry."
        case ProfessionalSummary                      = "Please enter Professional Summary."
        case specilization                           = "Please enter specilization Summary."


        
        case selectQualification = "Please select qualification."
        case enterInstitution = "Please enter instititution."
        case selectDegree = "Please select degree."
        case selectSpecializion = "Please select specialization."
        case selectCourseType = "Please select course type."
        case selectPassingYear = "Please select passing year."
        
 
        case EnterOTP                                = "Please enter OTP."
        case EmailAddressNotBeBlank                  = "Please enter Email ID."
        case DateOfBirth                             = "Please enter Date Of Birth."
        case Line1                                   = "Please enter Line 1."
        case Line2                                   = "Please enter Line 2."
        case LandMarks                               = "Please enter LandMark."
        case City                                    = "Please enter City."
        case State                                  = "Please enter State."
        case Country                                  = "Please enter Country."
        case Pincode                                  = "Please enter Pincode."




        case Role                                    = "Please Select Role."
        case Funcitionality                         = "Please Select Functional Area."
        case Industry                               = "Please Select Industry."


        case EnterValidEmail                         = "Please enter valid email address."
        case PasswordNotBeBlank                      = "Please enter password."
        case PasswordShouldBeLong                    = "Password Length should be 6-10 characters."
        
          case PasswordLong                        = " Password length should be 6-10 characters."
        case ConfirmPasswordNotBeBlank               = "Please enter confirm password."
        case ConfirmPasswordShouldBeLong             = "Confirm password length should be 6-10 characters."
        case NewPasswordNotBeBlank                   = "Please enter new password."
        case NewPasswordShouldBeLong                 = "New password length should be 6-10 characters."
        case PasswordAndConfimePasswordNotMatched    = "Password and Confirm Password is not matching."
        case AcceptTermsAndConditions                = "Please accept terms & conditions."
        case CUIDAlert                               = "Please enter CUID."
        case invalidCUIDAlert                        = "Please enter correct CUID."
        case CUIDMaxLength                           = "CUID length should be 6 digit long."
        case OldPasswordNotBeBlank                      = "Please enter old password."
        case OldPasswordShouldBeLong                    = "Old Password length should be 6-10 characters."
        case NewPasswordAndConfimePasswordNotMatched    = "New Password and Confirm Pasword is not matching."
        case LoginTokenExpire                       = "User already logged in some other device."
        case IncorrectOTP                           = "Incorrect OTP."
        case WantToLogout                           = "Are you sure?\nYou want to Log out!"
        case reportFeed                            = "Are you sure?\nYou want to report this feed?"
        case ContinueApp                           = "Please enter CUID to continue in the app."
        case ProfileUpdate                         = "Profile updated successfully."
        case DeleteAccess                          = "Are you sure?\nYou want to delete access of "
        case UnfollowChild                         = "Are you sure?\nYou want to unfollow "
        case DeletePost                          = "Are you sure?\nYou want to delete post of "
        case AudioMissing                         = "Audio file is missing."
        case DeleteComment                         = "Are you sure?\nYou want to delete this comment"
        case CommentAlert                              = "Please enter Comment."
        case WrongPasswordOrNumberAlert                = "Phone number or password is incorrect!"
        case ForgotWrongPasswordOrNumberAlert                = "Phone number is Incorrect."
        case SignupErrorMsgAlert                        = "Something Went Wrong"
        case CompanyName                            = "Please Enter Company Name"
        case smothingWentWrong                            = "Smothing Went Wrong"
        case fillFields     = "Please fill fields"


    }
    enum ERRORMESSAGE : String {
        case NoInternet                              = "There is no internet connection. Please try again later."
        case ErrorMessage                            = "There is some error occured. Please try again later."
    }
    
    
    
    
}

//MARK: - Extension Lottie loader
extension MacrosForAll{
    func showLoader(view: UIView) {
        let jeremyGif = UIImage.gifImageWithName(name: "loadingeffect")
        imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        imageView.contentMode = .center
        imageView.backgroundColor = #colorLiteral(red: 0.1188083068, green: 0.4292500615, blue: 0.7812415957, alpha: 1)
      //   imageView.backgroundColor = #colorLiteral(red: 0.1188083068, green: 0.4292500615, blue: 0.7812415957, alpha: 1)
        view.addSubview(imageView)
    }
   func hideLoader() {
        imageView.removeFromSuperview()
    }
    
    
    func returnMonth(month:Int)->String{
        if month == 1{
            return "Jan"
        }else if month == 2{
            return "Feb"
        }else if month == 3{
            return "Mar"
        }else if month == 4{
            return "Apr"
        }else if month == 5{
            return "May"
        }else if month == 6{
            return "Jun"
        }else if month == 7{
            return "July"
        }else if month == 8{
            return "Aug"
        }else if month == 9{
            return "Sept"
        }else if month == 10{
            return "Oct"
        }else if month == 11{
            return "Nov"
        }else if month == 12{
            return "Dec"
        }else{
            return ""
        }
    }
    
    func showLoaderMessage(view: UIView) {
        view.alpha = 1.0
        animationView.isHidden = false
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
    }
    
}

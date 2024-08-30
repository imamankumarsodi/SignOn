//
//  CommonMethods.swift
//  SignOn
//
//  Created by abc on 26/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation
import UIKit
//MARK: - UPDATE UI CLASS
class UpdateUIClass {
   static  let updateSharedInstance = UpdateUIClass()
    //TODO: Method getting custom fonts
    func gettingCustomFonts(){
        let fontFamilyNames = UIFont.familyNames
        
        for familyName in fontFamilyNames {
//            print("-------------Custom Font \(familyName)-----------------")
//            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
//            print("Font Names = [\(names)]")
        }
        
    }
    
    //TODO: Method updating signIn label
    func updateHeaderLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.alignment = .center
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 25.0)!, .foregroundColor :UIColor.white])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor :UIColor.white])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
         myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
    }
    
    //TODO: Method updating terms and condition privacy and policies
    func updateTermAndConditionLabel()->NSMutableAttributedString{
        
        let myMutableString = NSMutableAttributedString()

        let myMutableString1 = NSAttributedString(string: "I have read and accept ", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :UIColor.darkGray])
        
        let myMutableString2 = NSAttributedString(string: "Term of services", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :#colorLiteral(red: 0, green: 0.3954637051, blue: 0.6950598359, alpha: 1), .underlineStyle: NSUnderlineStyle.single.rawValue])
        
        let myMutableString3 = NSAttributedString(string: " and\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :UIColor.darkGray])
        
        let myMutableString4 = NSAttributedString(string: "Privacy Policy", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :#colorLiteral(red: 0, green: 0.3954637051, blue: 0.6950598359, alpha: 1), .underlineStyle: NSUnderlineStyle.single.rawValue])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        myMutableString.append(myMutableString3)
        myMutableString.append(myMutableString4)
       
        return myMutableString
    }
    
    
    //TODO: Method updating updateLabelWithStar *
    func updateLabelWithStar(title:String)->NSMutableAttributedString{
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 14.0)!, .foregroundColor :#colorLiteral(red: 0, green: 0.3954637051, blue: 0.6950598359, alpha: 1)])
        
        let myMutableString2 = NSAttributedString(string: "*", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor :#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)])
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        return myMutableString
    }
    
    
    //TODO: Method updating AppliedFotter label
    func updateAppliedFotterLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.alignment = .center
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 17.0)!, .foregroundColor :UIColor.white])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 17.0)!, .foregroundColor :UIColor.white])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
    }
    
    //TODO: Method updating Mentor label
    func updateMentorCellLabel(_ name:String,_ email:String,_ detail:String)->NSMutableAttributedString{
        
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSMutableAttributedString(string: "\(name)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 17.0)!, .foregroundColor :#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)])
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        myMutableString1.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString1.length))
        
        let myMutableString2 = NSMutableAttributedString(string: "\(email)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :UIColor.darkGray])
        let style1 = NSMutableParagraphStyle()
        style1.lineSpacing = 5
        myMutableString2.addAttribute(NSAttributedString.Key.paragraphStyle, value: style1, range: NSRange(location: 0, length: myMutableString2.length))
        
        let myMutableString3 = NSMutableAttributedString(string: "\(detail)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor :UIColor.darkGray])
        let style2 = NSMutableParagraphStyle()
        style2.lineSpacing = 0
       myMutableString3.addAttribute(NSAttributedString.Key.paragraphStyle, value: style2, range: NSRange(location: 0, length: myMutableString3.length))
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        myMutableString.append(myMutableString3)
        return myMutableString
    }
    
    
    //TODO: Method updating Notification label
    func updateNotificationCellLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 1
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSMutableAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 16.0)!, .foregroundColor :#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        
        let myMutableString2 = NSMutableAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 15.0)!, .foregroundColor :#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
       myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        return myMutableString
    }
    
    //TODO: Method Job Preferences label
    func updateJobPreferencesLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Medium, size: 14.0)!, .foregroundColor :UIColor.darkGray])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 12.0)!, .foregroundColor :UIColor.darkGray])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
    }
    
    
    
    //TODO: Method updating Home header label
    func updateHeaderHomeLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2
        style.alignment = .center
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 9.0)!, .foregroundColor :UIColor.white])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 20.0)!, .foregroundColor :UIColor.white])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        return myMutableString
    }
    
    //TODO: Method updating Home Title header label
    func updateHeaderHomeTitleLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2
        style.alignment = .center
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 20.0)!, .foregroundColor :UIColor.white])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor :UIColor.white])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        return myMutableString
    }
    
     //TODO: Method ProfileVC  Email And Fone Title header label
    
    func updateEmailFoneTitleLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = .left
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 15.0)!, .foregroundColor :UIColor.white])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :UIColor.white])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        return myMutableString
    }
    
    func updateEmailFoneTitleLabel1(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = .left
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 14.0)!, .foregroundColor :UIColor.darkGray])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :UIColor.darkGray])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        return myMutableString
    }
    
    
    //TODO: Method updating thankYou Title header label
    func updateThankYouTitleLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = .center
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 35.0)!, .foregroundColor :UIColor.white])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 20.0)!, .foregroundColor :UIColor.white])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        return myMutableString
    }
    
    
    
    //TODO: Method updating mentorhome label
    func updateMentorHeaderLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.alignment = .center
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSMutableAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 25.0)!, .foregroundColor :UIColor.white])
        myMutableString1.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString1.length))
        
        let style1 = NSMutableParagraphStyle()
        style1.lineSpacing = 5
        style1.alignment = .center
        let myMutableString2 = NSMutableAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor :UIColor.white])
        
        myMutableString2.addAttribute(NSAttributedString.Key.paragraphStyle, value: style1, range: NSRange(location: 0, length: myMutableString2.length))
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        return myMutableString
    }
    //TODO: Method Job Preferences label
    func updateMentorHomeCellLabel(_ title:String,_ subtitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Bold, size: 15.0)!, .foregroundColor : #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :UIColor.darkGray])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
    }
    
    func updateNewsFeedCellLabel(_ title:String,_ like:String,_ comment:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        
        let myMutableString2 = NSAttributedString(string: "\(like) Likes   \(comment) Comments", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 13.0)!, .foregroundColor :#colorLiteral(red: 0.003921568627, green: 0.4745098039, blue: 0.768627451, alpha: 1)])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
        
        
        
        
    }
    //TODO: Method Job Preferences label
    func forNewsFeeedLblMethod(_ title:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 14.0)!, .foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        
        myMutableString.append(myMutableString1)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
    }

    //TODO: Method Job Preferences label
    func forNewsFeeedLblMethodComments(_ title:String,_ subTitle:String)->NSMutableAttributedString{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 2
        
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\n", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 15.0)!, .foregroundColor : #colorLiteral(red: 0.003921568627, green: 0.4745098039, blue: 0.768627451, alpha: 1)])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:UIFont(name: App.Fonts.Roboto.Roboto_Regular, size: 14.0)!, .foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: myMutableString.length))
        
        return myMutableString
    }
    
    
    func convertStringToDate(date:String)->Date{
        let formatter = DateFormatter()
       // formatter.timeZone = TimeZone(abbreviation: "GMT+5:30")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let dateNew = formatter.date(from:date)!
       // dateNew.addingTimeInterval(180)
        return dateNew.addingTimeInterval(19800)
    }
    
    func getFormattedDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return formatter.string(from:Date())
    }
 
  
}


class switchStoryBoard {
    
    let AuthStoryboard = UIStoryboard(name: "AuthStoryboard", bundle: Bundle.main)
    let MentorStoryBoard = UIStoryboard(name: "Mentor", bundle: Bundle.main)
    
}

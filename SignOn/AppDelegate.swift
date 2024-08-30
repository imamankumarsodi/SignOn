//
//  AppDelegate.swift
//  SignOn
//
//  Created by abc on 12/03/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import UIKit
import KYDrawerController
import IQKeyboardManagerSwift
import RealmSwift
import FBSDKCoreKit
import FBSDKLoginKit
import LinkedinSwift
import GoogleSignIn
 


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate , GIDSignInUIDelegate {

    var window: UIWindow?
    var drawerController = KYDrawerController.init(drawerDirection: .left, drawerWidth: 295)
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(3)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        checkAutoLogin()

        if FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions){
            return true
        }
        else{
            GIDSignIn.sharedInstance().clientID = "1061465838558-9u03s5c53kdqolj64bnpkg1tq67fteps.apps.googleusercontent.com"
                GIDSignIn.sharedInstance().delegate = self
                return true

        }
        
        
        //FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
 
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled = Bool()
        if LinkedinSwiftHelper.shouldHandle(url) {
            handled = LinkedinSwiftHelper.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }else{
            handled  = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }
        return handled
    }
  
   //  HomeMentorVC
    
    func homeMentor() -> AppDelegate {
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    let mentorStoryBoard = UIStoryboard(name: "Mentor", bundle: Bundle.main)
        
    let menuVC = storyboard.instantiateViewController(withIdentifier: "Drawer")
    let homeVC = mentorStoryBoard.instantiateViewController(withIdentifier: "HomeMentorVC")
    
    let navigationController = UINavigationController(rootViewController: drawerController)
    
    self.drawerController.mainViewController = homeVC
    self.drawerController.drawerViewController = menuVC
    navigationController.isNavigationBarHidden = true
    
    //ANIMATE THE ROOTVIEW CONTROLLER...
    UIView.transition(with: window!, duration: 0.8, options: .transitionFlipFromRight, animations: {
    self.window?.rootViewController = navigationController
    }, completion: { completed in
    // maybe do something here
    })
    
    self.window?.makeKeyAndVisible()
    return UIApplication.shared.delegate as! AppDelegate
    }
    
    func initHome() -> AppDelegate
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let menuVC = storyboard.instantiateViewController(withIdentifier: "Drawer")
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        let navigationController = UINavigationController(rootViewController: drawerController)
        self.drawerController.mainViewController = homeVC
        self.drawerController.drawerViewController = menuVC
        navigationController.isNavigationBarHidden = true
        
        
        //ANIMATE THE ROOTVIEW CONTROLLER...
        
        UIView.transition(with: window!, duration: 0.8, options: .transitionFlipFromRight, animations: {
            self.window?.rootViewController = navigationController
        }, completion: { completed in
            // maybe do something here
        })
        
        self.window?.makeKeyAndVisible()
        
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func checkAutoLogin()
    {
         let realm = try! Realm()
        if let userInfo = realm.objects(LoginDataModal.self).first{
            if userInfo.isMentor == true{
                print(userInfo.isMentor)
                homeMentor()
            }else{
                self.initHome()
            }
        }

    }
    
    
    func initLoginAtLogOut() -> AppDelegate {
        
        let storyboard = UIStoryboard.init(name: "AuthStoryboard", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        navigationController.isNavigationBarHidden = true
        
        //ANIMATE THE ROOTVIEW CONTROLLER...
        UIView.transition(with: window!, duration: 0.8, options: .transitionFlipFromRight, animations: {
            self.window?.rootViewController = navigationController
        }, completion: { completed in
            // maybe do something here
        })
        
        self.window?.makeKeyAndVisible()
        return UIApplication.shared.delegate as! AppDelegate
        
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{
    //MARK: - Google signIn Delegates
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print("error\(error.localizedDescription)")
        }else{
            guard let name = user.profile.name
                else {return}
            guard let idToken = user.authentication.idToken
                else {return}
            guard let accessToken = user.authentication.accessToken
                else {return}
            print("Successfully loggedIn")
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,withError error: Error!) {
        
        if error != nil{
            print("error\(error.localizedDescription)")
        }else{
            guard let name = user.profile.name
                else {return}
            guard let idToken = user.authentication.idToken
                else {return}
            guard let accessToken = user.authentication.accessToken
                else {return}
            print("Successfully loggedIn")
        }
    }
}

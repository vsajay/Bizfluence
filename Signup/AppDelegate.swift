//
//  AppDelegate.swift
//  Signup
//
//  Created by Sajay Velmurugan on 13/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn
import TwitterKit
import GoogleMaps
import  GooglePlaces
import SafariServices
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
            FirebaseApp.configure()
            FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
            GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
            GIDSignIn.sharedInstance().delegate = self
        GMSServices.provideAPIKey("AIzaSyDoQdpBwJKywyLcalsEcdb3mvsUycw5JnU")
        GMSPlacesClient.provideAPIKey("AIzaSyDoQdpBwJKywyLcalsEcdb3mvsUycw5JnU")
            Twitter.sharedInstance().start(withConsumerKey:"AZRXqxzKC4i4qHvlJlly2CSf6", consumerSecret:"lkc2Nn8Z6HwIPKPCNvbxxb1TQuwWKthBKH45uDRrVUiJMcNhJf")
        
        
        return true
        
    }
    

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    
        return handled || GIDSignIn.sharedInstance().handle(url,
                                                            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                            annotation: options[UIApplicationOpenURLOptionsKey.annotation]) || Twitter.sharedInstance().application(app, open: url, options: options)
    }
    
    
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        
        if let error = error{
            print(error.localizedDescription)
            return
        }
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error
            {
                print(error.localizedDescription)
                return
            }
            print(user?.uid)
            return
        }
        
        
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


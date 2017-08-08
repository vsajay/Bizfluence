//
//  ViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 13/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

class ViewController: UIViewController,GIDSignInUIDelegate {

    @IBAction func googleLogin(_ sender: Any) {
    }
    @IBAction func facebookLogin(_ sender: Any) {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
        
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
        
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present the main view
//                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
//                    UIApplication.shared.keyWindow?.rootViewController = viewController
//                    self.dismiss(animated: true, completion: nil)
//                }
                self.performSegue(withIdentifier: "fbLogin", sender: self)
            })
            
        }
    
    }
    @IBAction func githubLogin(_ sender: Any) {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 155, y: 557, width: 75, height: 30)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self
    
        let twitterButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        // ...
                        return
                    }
                    // User is signed in
                    // ...
                }
            
                // ...
            }
            })
        twitterButton.frame = CGRect(x: 155, y: 280, width: 75, height: 30)
        view.addSubview(twitterButton)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


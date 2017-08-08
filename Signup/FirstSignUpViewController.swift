//
//  FirstSignUpViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 13/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class FirstSignUpViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBAction func goButton(_ sender: Any) {
        //Creating User
        if emailTextfield.text == "" || passwordTextfield.text == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        
        }
        else
        {
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
                if error == nil
                {
                    print("You have successfully signed up")
                    let ref = Database.database().reference(fromURL: "https://bizfluence-7ed9b.firebaseio.com/")
                    let userReference = ref.child("Users").child((user?.uid)!)
                    let values = ["email": self.emailTextfield.text!]
                    userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil
                        {
                            print(error)
                        }
                    })
                 
                    Auth.auth().signIn(withEmail: self.emailTextfield.text!, password: self.passwordTextfield.text!, completion: nil)
                    let user = Auth.auth().currentUser
                    if let user = user
                    
                    {
                  //  Database.database().reference().child("Users1").child(user.uid).child("userInfo").setValue(["First Name": "","Second Name": "","title": "","bio": "","interest": ""])
                        
                        
                        
                    }
                    self.performSegue(withIdentifier: "first", sender: self)
//                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondSignUpViewController") as! SecondSignUpViewController
//                    
//                    // Set "Hello World" as a value to myStringValue
//                    secondViewController.emailId = self.emailTextfield.text
//                    
//                    // Take user to SecondViewController
//                    self.navigationController?.pushViewController(secondViewController, animated: true)
                    
                    
                }
                else
                {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
        
        
        
        
        
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FirebaseApp.configure()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerB = segue.destination as? SecondSignUpViewController {
            viewControllerB.emailId = emailTextfield.text!
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        getProfileInfo()
    }
//Linkedin
    func getProfileInfo() {
        
        if let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken") {
            // Specify the URL string that we'll get the profile info from.
            let targetURLString = "https://api.linkedin.com/v1/people/~:(id,public-profile-url,first-name,last-name,email-address,positions:(title,company))?format=json"
            
            
            // Initialize a mutable URL request object.
            var request = URLRequest(url: URL(string: targetURLString)!)
            
            // Indicate that this is a GET request.
            request.httpMethod = "GET"
            
            // Add the access token as an HTTP header field.
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            
            // Initialize a NSURLSession object.
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // Make the request.
            let task: URLSessionDataTask = session.dataTask(with: request , completionHandler: { (data, response, error) -> Void in
                // Get the HTTP status code of the request.
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    // Convert the received JSON data into a dictionary.
                    do {
                        let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        //print(dataDictionary)
                       let positions = dataDictionary?["positions"] as! NSDictionary
                        print(positions.value(forKey: "title"))
                       print(positions)
                        print(positions["title"])
                        let firstName = dataDictionary?["firstName"] as! String
                        print(firstName)
                        
                        let lastName = dataDictionary?["lastName"] as! String
                        print(lastName)
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            
                        })
                    }
                    catch {
                        print("Could not convert JSON data into a dictionary.")
                    }
                }
            })
            
            task.resume()
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

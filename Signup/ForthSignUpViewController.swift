//
//  ForthSignUpViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 14/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import Firebase
class ForthSignUpViewController: UIViewController {
    var titleContent: String = "What do you do?"
    var firstName:String? = nil
    var secondName:String? = nil

    var nameContent: String = "Name"
    @IBOutlet weak var nameButton: UIButton!
    @IBAction func nameButtonTapped(_ sender: Any) {
    }
    @IBAction func bioButtonTapped(_ sender: Any) {
    }
    @IBOutlet weak var titleButton: UIButton!
  
    @IBAction func nextButton(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        if let user = user {
            print(user.uid)
            print(user.email!)
            //            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            //            changeRequest?.displayName = "Sajay V"
            let ref = Database.database().reference(fromURL: "https://bizfluence-7ed9b.firebaseio.com/")
            let userReference = ref.child("Users").child((user.uid))
            
            let values1 = ["Title": self.titleContent, "Bio": " "]
            userReference.updateChildValues(values1, withCompletionBlock: { (error, ref) in
                if error != nil
                {
                    print(error)
                }
            })
//            Database.database().reference().child("Users1").child(user.uid).child("userInfo").updateChildValues(["title": titleContent,"bio": "","interest": ""])
            
            
            
            performSegue(withIdentifier: "profiletointerest", sender: self)
            
        }

        
        
        
        
        
    }
    @IBAction func titleButtonTapped(_ sender: Any) {
        
        
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if titleContent != "What do you do?"
        {
            titleButton.setTitle(titleContent, for: .normal)
            titleButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        if nameContent != "Name"
        {
            nameButton.setTitle(nameContent, for: .normal)
            nameButton.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if firstName != nil && secondName != nil
        {
        nameContent = firstName!+" "+secondName!
        }
        
                // Do any additional setup after loading the view.
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

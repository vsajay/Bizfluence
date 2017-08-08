//
//  SecondSignUpViewController.swift
//  Pods
//
//  Created by Sajay Velmurugan on 13/07/17.
//
//

import UIKit
import Firebase


class SecondSignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    var emailId:String = "ds"
    
    @IBOutlet weak var emailTextField: UITextField!
    var users: DatabaseReference!
    //Store in Database
    @IBAction func nextButton(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        if let user = user {
            print(user.uid)
            print(user.email!)
            //            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            //            changeRequest?.displayName = "Sajay V"
            let ref = Database.database().reference(fromURL: "https://bizfluence-7ed9b.firebaseio.com/")
            let userReference = ref.child("Users").child((user.uid))

            let values1 = ["First Name": self.firstNameTextField.text!, "Second Name": self.secondNameTextField.text!]
            userReference.updateChildValues(values1, withCompletionBlock: { (error, ref) in
                if error != nil
                {
                    print(error)
                }
            })
            
//            Database.database().reference().child("Users1").child(user.uid).child("userInfo").updateChildValues(["First Name": firstNameTextField.text!,"Second Name": secondNameTextField.text!,"title": "","bio": "","interest": ""])
        
        
       
        performSegue(withIdentifier: "secondtothird", sender: self)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = emailId
        let user = Auth.auth().currentUser
        if let user = user {
                        print(user.uid)
            print(user.email!)
//            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//            changeRequest?.displayName = "Sajay V"
//            Database.database().reference().child("Users1").child(user.uid).child("userInfo").updateChildValues(["First Name": firstNameTextField.text!,"Second Name": secondNameTextField.text!,"title": "","bio": "","interest": ""])

//
//            Database.database().reference().child("Users1").child(user.uid).child("userInfo").observeSingleEvent(of: .value, with: { (snapshot) in
//                if let userName = snapshot.childSnapshot(forPath: "First Name").value
//                {
//                  print(userName)
//                }
//                
//            })
//            changeRequest?.commitChanges(completion: { (error) in
//                if error == nil{
//                   // print(user.NewName!)
//                   // print(user.value(forKey: "NewName")!)
//                    
//                }
//            })
        }
        
        //FirebaseApp.configure()
        users = Database.database().reference().child("users")
        // Do any additional setup after loading the view.
        }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerB = segue.destination as? ForthSignUpViewController {
            viewControllerB.firstName = firstNameTextField.text!
            viewControllerB.secondName = secondNameTextField.text!
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

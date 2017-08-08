//
//  ThirdSignUpViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 14/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import Firebase
class ThirdSignUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func doneButton(_ sender: Any) {
        //Database Integration
        let user = Auth.auth().currentUser
        if let user = user {
            print(user.uid)
            print(user.email!)
            //            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            //            changeRequest?.displayName = "Sajay V"
            let ref = Database.database().reference(fromURL: "https://bizfluence-7ed9b.firebaseio.com/")
            let userReference = ref.child("Users").child((user.uid))
            
            let values1 = ["Interest":interests]
            userReference.updateChildValues(values1, withCompletionBlock: { (error, ref) in
                if error != nil
                {
                    print(error)
                }
            })
//            Database.database().reference().child("Users1").child(user.uid).child("userInfo").updateChildValues(["interest": interests])
        
        }
        
        
    }
    var interests: [String] = []
    var count = 0
    @IBAction func addButton(_ sender: Any) {
        
        interests.append(interestTextField.text!)
        
        count += 1
        tableView.reloadData()
        
    }
    @IBOutlet weak var interestTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        return interests.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "TextInputCell")
        cell.textLabel?.text = String(indexPath.row+1)+"."+interests[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            interests.remove(at: indexPath.row)
            
            tableView.reloadData()
            
            
        }
        
    }

    
    }

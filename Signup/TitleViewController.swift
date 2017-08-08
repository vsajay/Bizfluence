//
//  TitleViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 14/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var atTextField: UITextField!
    @IBAction func okButton(_ sender: Any) {
        
       
        
//        let titleView = storyboard?.instantiateViewController(withIdentifier: "myProfile") as! ForthSignUpViewController
//        titleView.title1 = "Sajay"//title! + " at " + at!
//        navigationController?.pushViewController(titleView, animated: true)
        performSegue(withIdentifier: "occupationtosignup", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerB = segue.destination as? ForthSignUpViewController {
            viewControllerB.titleContent = titleTextField.text! + " at " + atTextField.text!
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

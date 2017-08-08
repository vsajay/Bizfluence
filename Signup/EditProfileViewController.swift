//
//  EditProfileViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 08/08/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
import GoogleSignIn

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, GIDSignInUIDelegate {
    var gender = [0,0,0]
    @IBOutlet weak var maleGender: UIButton!
    @IBOutlet weak var femaleGender: UIButton!
    @IBOutlet weak var specifyGender: UIButton!
    @IBOutlet weak var studentCheckBox: UIButton!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var hideProfileCheckBox: UIButton!
    @IBOutlet weak var fbValid: UIImageView!
    @IBOutlet weak var googleValid: UIImageView!
    @IBOutlet weak var twitterValid: UIImageView!
    @IBOutlet weak var linkedinValid: UIImageView!
    @IBOutlet weak var behanceValid: UIImageView!
    @IBOutlet weak var githubValid: UIImageView!
    @IBOutlet weak var blogValid: UIImageView!
    @IBOutlet weak var webValid: UIImageView!
    @IBOutlet weak var linkedintextField: UITextField!
    @IBOutlet weak var behancetextField: UITextField!
    @IBOutlet weak var blogtextField: UITextField!
    @IBOutlet weak var webtextField: UITextField!
    @IBOutlet weak var fbDelete: UIButton!
    @IBOutlet weak var googleDelete: UIButton!
    @IBOutlet weak var twitterDelete: UIButton!
    @IBOutlet weak var linkedinDelete: UIButton!
    @IBOutlet weak var behanceDelete: UIButton!
    @IBOutlet weak var githubDelete: UIButton!
    @IBOutlet weak var switchFieldofWork: UISwitch!
    @IBOutlet weak var switchIndustry: UISwitch!
    @IBOutlet weak var switchVolunteer: UISwitch!
    @IBOutlet weak var switchSponsor: UISwitch!
    @IBOutlet weak var switchInvest: UISwitch!
    @IBOutlet weak var industryButton: UIButton!
    @IBOutlet weak var fieldofWorkButton: UIButton!
    @IBOutlet weak var volunteerButton: UIButton!
    @IBOutlet weak var sponsorButton: UIButton!
    @IBOutlet weak var investButton: UIButton!
    @IBOutlet weak var facebookConnectButton: UIButton!
    @IBOutlet weak var googleConnectButton: UIButton!
    @IBOutlet weak var twitterConnectButton: UIButton!
    @IBOutlet weak var githubConnectButton: UIButton!
    var gitHubaccessCode = "Sajay"
    
    //integrate with profile screen
    @IBAction func switchFieldofWorkButton(_ sender: Any) {
        if switchFieldofWork.isOn{
            fieldofWorkButton.isEnabled = true
            fieldofWorkButton.isHidden = false
        }
        else
        {
            fieldofWorkButton.isEnabled = false
            fieldofWorkButton.isHidden = true
            
        }
        
    }
    @IBAction func switchIndustryButton(_ sender: Any) {
        if switchIndustry.isOn{
            industryButton.isEnabled = true
            industryButton.isHidden = false
        }
        else
        {
            industryButton.isEnabled = false
            industryButton.isHidden = true
            
        }
        
    }
    @IBAction func switchVolunteerButton(_ sender: Any) {
        if switchVolunteer.isOn{
            volunteerButton.isEnabled = true
            volunteerButton.isHidden = false
        }
        else
        {
            volunteerButton.isEnabled = false
            volunteerButton.isHidden = true
            
        }
    }
    @IBAction func switchSponsorButton(_ sender: Any) {
        if switchSponsor.isOn{
            sponsorButton.isEnabled = true
            sponsorButton.isHidden = false
        }
        else
        {
            sponsorButton.isEnabled = false
            sponsorButton.isHidden = true
            
        }
        
    }
    @IBAction func switchInvestButton(_ sender: Any) {
        if switchInvest.isOn{
            investButton.isEnabled = true
            investButton.isHidden = false
        }
        else
        {
            investButton.isEnabled = false
            investButton.isHidden = true
            
        }
        
        
    }
    
    
    @IBAction func industryButtonTapped(_ sender: Any) {
    }
    
    @IBAction func fieldofWorkButtonTapped(_ sender: Any) {
    }
    @IBAction func volunteerButtonTapped(_ sender: Any) {
    }
    @IBAction func sponsorButtonTapped(_ sender: Any) {
    }
    @IBAction func investButtonTapped(_ sender: Any) {
    }
    
    //Check LinkedIn Url
    @IBAction func linkedintextFieldCheck(_ sender: Any) {
        let linkedinUrl = linkedintextField.text
        if linkedinUrl != ""
        {
            if (linkedinUrl?.contains("linkedin.com"))!
            {
                linkedinValid.image = UIImage(named: "greentick.png")
                linkedinDelete.isHidden = false
                linkedinDelete.isEnabled = true
                linkedintextField.isEnabled = false
            }
            else
            {
                linkedinValid.image = UIImage(named: "redcross.png")
                linkedinDelete.isHidden = true
                linkedinDelete.isEnabled = false
                linkedintextField.isEnabled = true
            }
        }
        else
        {
            linkedinValid.image = nil
        }
    }
    
    @IBAction func fbDeleteButton(_ sender: Any) {
        
        
        
        
    }
    @IBAction func linkedinDeleteButton(_ sender: Any) {
        linkedintextField.isEnabled = true
        linkedintextField.text = ""
        linkedinDelete.isHidden = true
        linkedinValid.image = nil
        
    }
    
    //Check Behance Url
    
    @IBAction func behancetextFieldCheck(_ sender: Any) {
        let behanceUrl = behancetextField.text
        if behanceUrl != ""
        {
            if (behanceUrl?.contains("behance.net"))!
            {
                behanceValid.image = UIImage(named: "greentick.png")
                behanceDelete.isHidden = false
                behanceDelete.isEnabled = true
                behancetextField.isEnabled = false
            }
            else
            {
                behanceValid.image = UIImage(named: "redcross.png")
                behanceDelete.isHidden = true
                behanceDelete.isEnabled = false
                behancetextField.isEnabled = true
            }
        }
        else
        {
            behanceValid.image = nil
        }
        
        
    }
    
    @IBAction func behanceDeleteButton(_ sender: Any) {
        behancetextField.isEnabled = true
        behancetextField.text = ""
        behanceDelete.isHidden = true
        behanceValid.image = nil
        
        
        
    }
    @IBAction func blogtextFieldCheck(_ sender: Any) {
        
        
    }
    
    @IBAction func webtextFieldCheck(_ sender: Any) {
        
        
    }
    
    var hideProfileCheckBoxChoice = 0
    
    var studentCheckBoxChoice = 0
    
    //To check the validity of date
    @IBAction func dobTextFieldEditEnd(_ sender: Any) {
        print(dobTextField.text!)
        if let dob = dobTextField.text
        {
            let dobcomponents = dob.components(separatedBy: "/")
            if dobcomponents.count < 4
            {
                if Int(dobcomponents[0])! < 13 && Int(dobcomponents[1])! < 31
                {
                    print("Valid DOB")
                }
                
            }
            
        }
    }
    
    //integrate with profile
    @IBAction func maleGenderButtonTapped(_ sender: Any) {
        gender = [1,0,0]
        maleGender.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        femaleGender.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        specifyGender.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
    }
    
    @IBAction func femaleGenderButtonTapped(_ sender: Any) {
        gender = [0,1,0]
        femaleGender.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        maleGender.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        specifyGender.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        
    }
    
    @IBAction func specifyGenderButtonTapped(_ sender: Any) {
        gender = [0,0,1]
        maleGender.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        femaleGender.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        specifyGender.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        
    }
    
    @IBAction func studentCheckBoxTapped(_ sender: Any) {
        studentCheckBoxChoice += 1   //even number = unselected
        if studentCheckBoxChoice%2 != 0
        {
            studentCheckBox.setImage(UIImage(named: "checkedselected.png"), for: .normal)
        }
        else
        {
            studentCheckBox.setImage(UIImage(named: "checkedunselected.png"), for: .normal)
        }
    }
    //integrate with profile screen
    @IBAction func hideProfileTapped(_ sender: Any) {
        hideProfileCheckBoxChoice += 1   //even number = unselected
        if hideProfileCheckBoxChoice%2 != 0
        {
            hideProfileCheckBox.setImage(UIImage(named: "checkedselected.png"), for: .normal)
        }
        else
        {
            hideProfileCheckBox.setImage(UIImage(named: "checkedunselected.png"), for: .normal)
        }
        
    }
    
    
    
    @IBAction func addPictureButton(_ sender: Any) {
        selectProfilePic()
        
        
    }
    //integrate with profile screen
    @IBOutlet weak var profilePicture: UIImageView!
    func addProfilePic()
    {
        profilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfilePic)))
        profilePicture.isUserInteractionEnabled = true
        
    }
    
    
    func selectProfilePic()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated:  true, completion:  nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage]
        {
            selectedImageFromPicker = editedImage as? UIImage
        }
        else if let originalImage = info[UIImagePickerControllerOriginalImage]
        {
            selectedImageFromPicker = originalImage
                as? UIImage
            
        }
        
        if let selectedImage = selectedImageFromPicker
        {
            profilePicture.image = selectedImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    //Facebook Connect
    @IBAction func facebookConnectButtonTapped(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            if let accessToken = FBSDKAccessToken.current()
            {
                self.facebookConnectButton.setTitle("Connected", for: .normal)
                self.facebookConnectButton.isEnabled = false
                self.fbValid.image = UIImage(named: "greentick.png")
                self.fbDelete.isHidden = false
                self.fbDelete.isEnabled = true
            }
                
            else {
                print("Failed to get access token")
                return
            }
            
        }
        
        
    }
    
    @IBAction func googleConnectButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
        print("sign1")
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
        print("sign2")
        self.googleConnectButton.setTitle("Connected", for: .normal)
        self.googleConnectButton.isEnabled = false
        self.googleValid.image = UIImage(named: "greentick.png")
        self.googleDelete.isHidden = false
        self.googleDelete.isEnabled = true
    }
    
    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print(email!)
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!){
        
    }
    @IBAction
    func twitterConnectButtonTapped(_ sender: Any) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                print("signed in as \(String(describing: session?.userName))");
                self.twitterConnectButton.setTitle("Connected", for: .normal)
                self.twitterConnectButton.isEnabled = false
                self.twitterValid.image = UIImage(named: "greentick.png")
                self.twitterDelete.isHidden = false
                self.twitterDelete.isEnabled = true
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        })
        
        
        
    }
    @IBAction func githubConnectButtonTapped(_ sender: Any) {
        // performSegue(withIdentifier: "gitHub", sender: self)
        
        
    }
    
    func gitHubCheck()
    {
        if gitHubaccessCode != "Sajay"
        {
            self.githubConnectButton.setTitle("Connected", for: .normal)
            self.githubConnectButton.isEnabled = false
            self.githubValid.image = UIImage(named: "greentick.png")
            self.githubDelete.isHidden = false
            self.githubDelete.isEnabled = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dobTextField.delegate = self
        addProfilePic()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signOut()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        gitHubCheck()
        print(gitHubaccessCode)
}

}

//
//  PremiumSettingViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 07/08/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
//import Firebase
//import FirebaseAuth
class PremiumSettingViewController: UIViewController,CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var viewedProfileRadio: UIButton!
    @IBOutlet weak var blogTextField: UITextField!
    @IBOutlet weak var webTextField: UITextField!
    @IBOutlet weak var linkedinTextField: UITextField!
    @IBOutlet weak var behanceTextField: UITextField!
    @IBOutlet weak var blogValid: UIImageView!
    @IBOutlet weak var webValid: UIImageView!
    @IBOutlet weak var linkedinValid: UIImageView!
    @IBOutlet weak var behanceValid: UIImageView!
    @IBOutlet weak var blogDeleteButton: UIButton!
    @IBOutlet weak var webDeleteButton: UIButton!
    @IBOutlet weak var behanceDeleteButton: UIButton!
    
    @IBOutlet weak var customTagTextField: UITextField!
    @IBOutlet weak var customDropDown: UIPickerView!
    @IBOutlet weak var linkedinDeleteButton: UIButton!
    @IBOutlet weak var addCustomTag: UIButton!
    @IBOutlet weak var customLabel1: UILabel!
    @IBOutlet weak var customLabel2: UILabel!
    @IBOutlet weak var customLabel3: UILabel!
    @IBOutlet weak var customLabel4: UILabel!
    @IBOutlet weak var customLabel5: UILabel!
    @IBOutlet weak var customTextField1: UITextField!
    @IBOutlet weak var customTextField2: UITextField!
    @IBOutlet weak var customTextField3: UITextField!
    @IBOutlet weak var customTextField4: UITextField!
    @IBOutlet weak var customTextField5: UITextField!
    @IBOutlet weak var industryExpertRadio: UIButton!
    @IBOutlet weak var volunteerRadio: UIButton!
    @IBOutlet weak var sponsorRadio: UIButton!
    @IBOutlet weak var investorRadio: UIButton!
    @IBOutlet weak var professionalRadio: UIButton!
    @IBOutlet weak var studentRadio: UIButton!
    var currentCity = ""
    var latitude: Double? = nil
    var longitude: Double? = nil
    var count = 1
    var userlocation: CLLocation? = nil
    var custom = -1
    var customLabels = [UILabel]()
    var customTextField = [UITextField]()
    var badge = [0,0,0,0,0,0]
    var cityNameChoosed = ""
    var customList = ["Industry","2","3","4","5","Other"]
    var profileView = 0
    @IBAction func viewedProfileRadioTapped(_ sender: Any) {    //integrate with profile screen
        if profileView == 0
        {
            viewedProfileRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
            profileView = 1
        }
        else
        {
            viewedProfileRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
            profileView = 0
        }
        
        
        
    }
    
    
    
    @IBAction func behanceTextFieldCheck(_ sender: Any) {
        let behanceUrl = behanceTextField.text
        if behanceUrl != ""
        {
            if (behanceUrl?.contains("behance.net"))!
            {
                behanceValid.image = UIImage(named: "greentick.png")
                behanceDeleteButton.isHidden = false
                behanceDeleteButton.isEnabled = true
                behanceTextField.isEnabled = false
            }
            else
            {
                behanceValid.image = UIImage(named: "redcross.png")
                behanceDeleteButton.isHidden = true
                behanceDeleteButton.isEnabled = false
                behanceTextField.isEnabled = true
            }
        }
        else
        {
            behanceValid.image = nil
        }
        
        
        
        
        
        
    }
    @IBAction func linkedinTextFieldCheck(_ sender: Any) {
        let linkedinUrl = linkedinTextField.text
        if linkedinUrl != ""
        {
            if (linkedinUrl?.contains("linkedin.com"))!
            {
                linkedinValid.image = UIImage(named: "greentick.png")
                linkedinDeleteButton.isHidden = false
                linkedinDeleteButton.isEnabled = true
                linkedinTextField.isEnabled = false
            }
            else
            {
                linkedinValid.image = UIImage(named: "redcross.png")
                linkedinDeleteButton.isHidden = true
                linkedinDeleteButton.isEnabled = false
                linkedinTextField.isEnabled = true
            }
        }
        else
        {
            linkedinValid.image = nil
        }
        
    }
    @IBAction func behanceDeleteButtonTapped(_ sender: Any) {
        behanceTextField.isEnabled = true
        behanceTextField.text = ""
        behanceDeleteButton.isHidden = true
        behanceValid.image = nil
        
    }
    @IBAction func linkedinDeleteButtonTapped(_ sender: Any) {
        linkedinTextField.isEnabled = true
        linkedinTextField.text = ""
        linkedinDeleteButton.isHidden = true
        linkedinValid.image = nil
        
        
    }
    @IBAction func webDeleteButtonTapped(_ sender: Any) {
    }
    
    @IBAction func blogDeleteButtonTapped(_ sender: Any) {
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userlocation = locations[0]
        findCity()
        locationManager.stopUpdatingLocation()
    }
    
    func getCurrentLocation(){ //integrate with profile screen
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func appendCustomTags()  //integrate with profile screen
    {
        customLabels.append(customLabel1)
        customLabels.append(customLabel2)
        customLabels.append(customLabel3)
        customLabels.append(customLabel4)
        customLabels.append(customLabel5)
        customTextField.append(customTextField1)
        customTextField.append(customTextField2)
        customTextField.append(customTextField3)
        customTextField.append(customTextField4)
        customTextField.append(customTextField5)
        
    }
    @IBAction func addCustomLabelButtonTapped(_ sender: Any) {
        let tag = customTagTextField.text
        if tag != ""
        {
            if tag != "Other"
            {
                
                
                self.custom += 1
                self.customLabels[self.custom].isEnabled = true
                self.customLabels[self.custom].isHidden = false
                
                self.customLabels[self.custom].text = tag
                self.customTextField[self.custom].isEnabled = true
                self.customTextField[self.custom].isHidden = false
                if self.custom == 4
                {
                    self.addCustomTag.isEnabled = false
                }
            }
            else
            {
                let addCustom = UIAlertController(title: "Custom Tags", message: "Type the tag you want to add:", preferredStyle: UIAlertControllerStyle.alert)
                
                
                
                
                
                
                addCustom.addTextField { (textField) -> Void in
                    textField.placeholder = "Tag?"
                }
                
                let findAction = UIAlertAction(title: "Custom Tag", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                    let tag = (addCustom.textFields![0] as UITextField).text!
                    self.custom += 1
                    self.customLabels[self.custom].isEnabled = true
                    self.customLabels[self.custom].isHidden = false
                    self.customLabels[self.custom].text = tag
                    self.customTextField[self.custom].isEnabled = true
                    self.customTextField[self.custom].isHidden = false
                    if self.custom == 4
                    {
                        self.addCustomTag.isEnabled = false
                    }
                    
                }
                
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
                    
                }
                
                addCustom.addAction(findAction)
                addCustom.addAction(closeAction)
                
                present(addCustom, animated: true, completion: nil)
                
            }
            
        }
        
    }
    //integrate with profile screen
    @IBAction func industryExpertRadioTapped(_ sender: Any) {
        badge = [1,0,0,0,0,0]
        industryExpertRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        volunteerRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        sponsorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        investorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        professionalRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        studentRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        
    }
    @IBAction func volunteerRadioTapped(_ sender: Any) {
        badge = [0,1,0,0,0,0]
        industryExpertRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        volunteerRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        sponsorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        investorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        professionalRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        studentRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
    }
    @IBAction func sponsorRadioTapped(_ sender: Any) {
        badge = [0,0,1,0,0,0]
        industryExpertRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        volunteerRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        sponsorRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        investorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        professionalRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        studentRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
    }
    @IBAction func investorRadioTapped(_ sender: Any) {
        badge = [0,0,0,1,0,0]
        industryExpertRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        volunteerRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        sponsorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        investorRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        professionalRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        studentRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
    }
    @IBAction func professionalRadioTapped(_ sender: Any) {
        badge = [0,0,0,0,1,0]
        industryExpertRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        volunteerRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        sponsorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        investorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        professionalRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
        studentRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
    }
    @IBAction func studentRadioTapped(_ sender: Any) {
        badge = [0,0,0,0,0,1]
        industryExpertRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        volunteerRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        sponsorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        investorRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        professionalRadio.setImage(UIImage(named: "radiounchecked.png"), for: .normal)
        studentRadio.setImage(UIImage(named: "radiochecked.png"), for: .normal)
    }
    //integrate with profile screen
    func findCity()
    {
        CLGeocoder().reverseGeocodeLocation(userlocation!) { (placemarks, error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
                if let placemark = placemarks?[0]
                {
                    if placemark.subAdministrativeArea != nil
                    {
                        if self.count == 1
                        {
                            self.locationLabel.text = placemark.subAdministrativeArea!
                            print(placemark.subAdministrativeArea!)
                            self.count += 1
                        }
                    }
                    
                }
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
        locationLabel.text = cityNameChoosed
        
        print(cityNameChoosed+"Re")
        
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return customList.count
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return customList[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.customTagTextField.text = self.customList[row]
        self.customDropDown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.customTagTextField {
            self.customDropDown.isHidden = false
            //if you dont want the users to se the keyboard type:
            
            textField.endEditing(true)
        }
        
    }
    //integrate with Database
    
    //    func saveDatabase()
    //    {
    //        let user = Auth.auth().currentUser
    //        if let user = user {
    //            print(user.uid)
    //            print(user.email!)
    //            let ref = Database.database().reference(fromURL: "https://bizfluence-7ed9b.firebaseio.com/")
    //            let userReference = ref.child("Users").child((user.uid)).child("Premium Settings")
    //            let values1 = ["My Location": locationLabel.text, "Latitude": latitude, "Longitude": longitude, "My Location Invisible": ,"Profile View": profileView, "Hidden Mode": ,"LinkedIn": linkedinTextField.text, "Behance": behanceTextField.text, "Blog": blogTextField.text, "Web": webTextField.text]
    //            userReference.updateChildValues(values1, withCompletionBlock: { (error, ref) in
    //                if error != nil
    //                {
    //                    print(error)
    //                }
    //            })
    //
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendCustomTags()
        getCurrentLocation()
        locationLabel.text = currentCity
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


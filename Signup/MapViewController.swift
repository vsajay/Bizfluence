//
//  MapViewController.swift
//  Premium Settings
//
//  Created by Sajay Velmurugan on 22/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class MapViewController: UIViewController, CLLocationManagerDelegate {
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    var fetchedFormattedAddress: String!
    var city = ""
    
    var fetchedAddressLongitude: Double!
    
    var fetchedAddressLatitude: Double!
    var userlocation: CLLocation? = nil
    var desireduserlocation: CLLocation? = nil
    var foundCity = false
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    @IBAction func changeAddress(_ sender: Any) {
        
        let addressAlert = UIAlertController(title: "Address Finder", message: "Type the address you want to find:", preferredStyle: UIAlertControllerStyle.alert)
        
        addressAlert.addTextField { (textField) -> Void in
            textField.placeholder = "Address?"
        }
        
        let findAction = UIAlertAction(title: "Find Address", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            let address = (addressAlert.textFields![0] as UITextField).text!
            self.getAddress(city: address)
            sleep(1)
            if self.foundCity
            {
                
                self.desireduserlocation = CLLocation(latitude: self.fetchedAddressLatitude, longitude: self.fetchedAddressLongitude)
                self.mapView.camera = GMSCameraPosition.camera(withTarget: (self.desireduserlocation?.coordinate)!, zoom: 14.0)
                self.findCity()
                
            }
        }
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        addressAlert.addAction(findAction)
        addressAlert.addAction(closeAction)
        
        present(addressAlert, animated: true, completion: nil)
        
    }
    @IBAction func changeMapType(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.mapView.mapType = GMSMapViewType(rawValue: 1)!
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.mapView.mapType = GMSMapViewType(rawValue: 2)!
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.mapView.mapType = GMSMapViewType(rawValue: 3)!
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userlocation = locations[0]
        desireduserlocation = userlocation
        findCity()
        mapView.camera = GMSCameraPosition.camera(withTarget: (userlocation?.coordinate)!, zoom: 10.0)
        mapView.settings.myLocationButton = true
        manager.stopUpdatingLocation()
        didFindMyLocation = true
        
    }
    
    
    
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
        }
    }
    
    func showAlertWithMessage(message: String) {
        let alertController = UIAlertController(title: "GMapsDemo", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func getAddress(city: String)
    {
        
        let fetchURL: URL = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address="+city)!
        URLSession.shared.dataTask(with: (fetchURL as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                var status = jsonObj?["status"] as! String
                if status == "OK"
                {
                    self.foundCity = true
                    let allResults = jsonObj?["results"] as! Array<Dictionary<NSObject, AnyObject>>
                    self.lookupAddressResults = allResults[0]
                    // print(self.lookupAddressResults)
                    // Keep the most important values.
                    let dic = self.lookupAddressResults! as NSDictionary
                    self.fetchedFormattedAddress = dic["formatted_address"] as! String
                    let location = (dic["geometry"] as! NSDictionary)["location"] as! NSDictionary
                    self.fetchedAddressLongitude = (location["lng"] as! NSNumber).doubleValue
                    self.fetchedAddressLatitude = (location["lat"] as! NSNumber).doubleValue
                    print(self.fetchedAddressLatitude)
                }
                else
                {
                    self.foundCity = false
                }
            }
            
            
            
        }).resume()
    }
    
    func findCity()
    {
        CLGeocoder().reverseGeocodeLocation(desireduserlocation!) { (placemarks, error) in
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
                        self.city = placemark.subAdministrativeArea!
                    }
                    
                }
            }
        }
    }
    @IBAction func doneButton(_ sender: Any) {
        // findCity()
        
        //        print(city)
        //        let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "OriginalScreen") as! ViewController
        //
        //        // Set "Hello World" as a value to myStringValue
        //        mainScreen.cityNameChoosed = city
        //
        //        // Take user to SecondViewController
        //        self.navigationController?.pushViewController(mainScreen, animated: true)
        performSegue(withIdentifier: "back", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = city
        let latitude = fetchedAddressLatitude
        let longitude = fetchedAddressLongitude
        if let destinationViewController = segue.destination as? PremiumSettingViewController {
            destinationViewController.cityNameChoosed = data
            destinationViewController.latitude = latitude
            destinationViewController.longitude = longitude
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
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

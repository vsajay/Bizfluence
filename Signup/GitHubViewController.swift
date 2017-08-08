//
//  GitHubViewController.swift
//  Signup
//
//  Created by Sajay Velmurugan on 16/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit
import Firebase
//import Alamofire
class GitHubViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    let githubClientId = "ca449d183d343f6b4a4a"
    let gitHubClientSecret = "08dde0a7cefc51c6703ac9b86a1cbcd36e3ef6ec"
    let gitHubredirectUrl = "https://bizfluence-7ed9b.firebaseapp.com/__/auth/handler"
    let authorizationEndPoint = "https://github.com/login/oauth/authorize"
    let tokenendpoint = "https://github.com/login/oauth/access_token"
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        // Do any additional setup after loading the view.
        startAuthorization()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    
    func startAuthorization() {
        // Specify the response type which should always be "code".
        let clientId = githubClientId
        
        // Set the redirect URL. Adding the percent escape characthers is necessary.
        let redirectURL = gitHubredirectUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!        // Create a random string based on the time interval (it will be in the form linkedin12345679).
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        
        // Set preferred scope.
        let scope = "user"
        
        let allow_signup = "true"
        
        var authorizationURL = "\(authorizationEndPoint)?"
        //authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(githubClientId)&"
        authorizationURL += "redirect_uri=\(redirectURL)&"
        authorizationURL += "scope=\(scope)&"

        authorizationURL += "state=\(state)&"
        authorizationURL += "allow_signup=\(allow_signup)"
        let request = URLRequest(url: URL(string: authorizationURL)!)
        print(authorizationURL)
        webView.loadRequest(request)
       // print("sajay"+String(describing: request.url!))
        
        
    }
//    func accestoken(_ authorizationCode: String)
//    {
////        let redirectURL = gitHubredirectUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
////        Alamofire.request(tokenendpoint, method: .post, parameters: [
////            "client_id"    : githubClientId,
////            "client_secret": gitHubClientSecret,
////            "code" : authorizationCode ,
////            "redirect_uri" : redirectURL], encoding: JSONEncoding.default, headers: nil).responseJSON { response in
////                print("S1"+String(describing: response.request as Any))  // original URL request
////                print("S1"+String(describing: response.response as Any)) // URL response
////                print("S1"+String(describing: response.value as Any))   // result of response serialization
//        
//        
//        
//        let getTokenPath:String = "https://github.com/login/oauth/access_token"
//        let tokenParams = ["client_id": githubClientId , "client_secret": gitHubClientSecret, "code": authorizationCode]
//        Alamofire.request(getTokenPath, method: .post, parameters: tokenParams).responseString { (response) in
//            print(response.result)
//        }
//        
    
        
        
        
        
    
    func requestForAccessToken(_ authorizationCode: String) {
        
        let redirectURL = gitHubredirectUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        // Set the POST parameters.
       // var postParams = "\(tokenendpoint)?"

        var postParams = "client_id=\(githubClientId)&"
        postParams += "client_secret=\(gitHubClientSecret)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(redirectURL)&"
        
        postParams += "state=\(state)"
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.data(using: String.Encoding.utf8)
        
        
        // Initialize a mutable URL request object using the access token endpoint URL string.
        var request = URLRequest(url: URL(string: tokenendpoint)!)
        
        // Indicate that we're about to make a POST request.
        request.httpMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.httpBody = postData
        
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
       // webView.loadRequest(request)
        
        // Initialize a NSURLSession object.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        print("Saaaa"+String(describing: request.url))
        // Make the request.
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            // Get the HTTP status code of the request.
            let statusCode = (response as! HTTPURLResponse).statusCode
            print(String(statusCode)+"Status")
            if statusCode == 200 {
                // Convert the received JSON data into a dictionary.
                do {
                    print(String(describing: data)+"Data")
                    
                    let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)// as? [String:Any]
                    print(dataDictionary)
//                    let accessToken = dataDictionary?["access_token"] as! String
//                    print("SAJU"+accessToken)
//                    UserDefaults.standard.set(accessToken, forKey: "LIAccessToken")
//                    UserDefaults.standard.synchronize()
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        //self.dismiss(animated: true, completion: nil)
                   //     self.performSegue(withIdentifier: "linkedintofirst", sender: self)
                    })
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        })
        
        task.resume()
    }

   
    func token(_ authorizationCode: String)
    {
        let urlString = "https://github.com/login/oauth/access_token"
        if let tokenUrl = NSURL(string: urlString) {
            let req = NSMutableURLRequest(url: tokenUrl as URL)
            req.httpMethod = "POST"
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            let params = [
                "client_id" : githubClientId,
                "client_secret" : gitHubClientSecret,
                "code" : authorizationCode
            ]
            req.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            let task = URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
                if let data = data {
                    do {
                        if let content = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                            if let accessToken = content["access_token"] as? String {
                                //self.getUser(accessToken)
                                print("ACCES"+accessToken)
                                let credential = GitHubAuthProvider.credential(withToken: accessToken)
                                Auth.auth().signIn(with: credential, completion: { (user, error) in
                                    
                                })
                            }
                        }
                    } catch {}
                }
            }
            task.resume()
        
        }
}

    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url!
        print(url)
        if url.host == "bizfluence-7ed9b.firebaseapp.com" {
            if url.absoluteString.range(of: "code") != nil {
                // Extract the authorization code.
                let urlParts = url.absoluteString.components(separatedBy: "?")
                print("URL: " + urlParts[1])
                var code = urlParts[1].components(separatedBy: "=")[1]
                
                code = code.components(separatedBy: "&")[0]
                print(code)
                token(code)
            }
        }

        
        
        return true
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

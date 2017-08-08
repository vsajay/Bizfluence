//
//  GitHubViewController2.swift
//  Signup
//
//  Created by Sajay Velmurugan on 08/08/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import UIKit

class GitHubViewController2:UIViewController,UIWebViewDelegate {
    let githubClientId = "ca449d183d343f6b4a4a"
    let gitHubClientSecret = "08dde0a7cefc51c6703ac9b86a1cbcd36e3ef6ec"
    let gitHubredirectUrl = "https://bizfluence-7ed9b.firebaseapp.com/__/auth/handler"
    let authorizationEndPoint = "https://github.com/login/oauth/authorize"
    let tokenendpoint = "https://github.com/login/oauth/access_token"
    var access = ""
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
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
                                //                                let credential = GitHubAuthProvider.credential(withToken: accessToken)
                                //                                Auth.auth().signIn(with: credential, completion: { (user, error) in
                                //
                                self.access = accessToken
                                //  self.performSegue(withIdentifier: "back", sender: self)
                                //                                })
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
                
                
                // if (navigationType == UIWebViewNavigationType.formSubmitted) {
                //                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "myViewControllerName") as? ViewController
                //
                //                    let navigationController = UINavigationController(rootViewController: VC!)
                //                    self.navigationController?.present(navigationController, animated: true, completion:nil)
                
                performSegue(withIdentifier: "back", sender: self)
                // }
            }
        }
        
        
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let secondViewController = segue.destination as! EditProfileViewController
        print(access+"Check")
        // set a variable in the second view controller with the String to pass
        secondViewController.gitHubaccessCode = access
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

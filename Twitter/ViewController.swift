//
//  ViewController.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/6/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (request) -> Void in
            print("Got the request token")
            
            // token allows for redirecting to twitter login
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(request.token)")
            
            // redirect
            UIApplication.sharedApplication().openURL(authURL!)
            
        }) { (error: NSError!) -> Void in
            print("Failed to get request token")
        }
    }

}


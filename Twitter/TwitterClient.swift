//
//  TwitterClient.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/7/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "2SOqbgLeODgzn2NVqKsaeZRv2"
let twitterConsumerSecret = "hEAejvx4rcaklBAx9sV1Kzl5r1U9KXuUsrCZGzg1XBJpsJVHtO"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
}

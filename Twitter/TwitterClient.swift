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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation, response) -> Void in
            print("user \(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
            for tweet in tweets {
                print("text: \(tweet.text)")
            }
            
            completion(tweets: tweets, error: nil)
            }, failure: { (operation, error) -> Void in
                print("error getting the home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (request) -> Void in
            print("Got the request token")
            
            // token allows for redirecting to twitter login
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(request.token)")
            
            // redirect
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken) -> Void in
            print("got the access token!")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation, response) -> Void in
                print("user \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation, error) -> Void in
                    print("error getting the current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
            }) { (error) -> Void in
                print("failed to recieve access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func retweet(id: Int) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation, response) -> Void in
            print("succesfully retweeted")
            
            }, failure: { (operation, error) -> Void in
                print("error retweeting")
        })
    }
    
    func favoriteTweet(id: Int) {
        POST("1.1/favorites/create.json", parameters: ["id": id], success: { (operation, response) -> Void in
            print("succesfully favorited")
            
            }, failure: { (operation, error) -> Void in
                print("error favoriting")
        })
    }
    
    
}

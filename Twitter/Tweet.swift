//
//  Tweet.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/7/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: Int!
    var retweetCount: Int!
    var favoritedCount: Int!
    var retweeted: Bool!
    var favorited: Bool!
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as! Int
        
        retweetCount = dictionary["retweet_count"] as! Int
        favoritedCount = dictionary["favorite_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool
        favorited = dictionary["favorited"] as! Bool
        
        
        print("retweet count = \(retweetCount)")
        print("retweeted = \(retweeted)")
        print("favorited count = \(favoritedCount)")
        print("favorited = \(favorited)")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d GG HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    // class func = public static method 
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}

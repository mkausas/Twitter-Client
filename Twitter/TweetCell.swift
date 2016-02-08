//
//  TweetCell.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/8/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            fullNameLabel.text = tweet.user?.name
            usernameLabel.text = tweet.user?.screenname
            descriptionLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            
            if let imgUrl = tweet.user?.profileImageUrl {
                avatarImageView.setImageWithURL(NSURL(string: imgUrl)!)
//                print("could not get image url")
            } else {
                print("could not get image url")
                
            }
            
        }
    }
    
    @IBAction func onReply(sender: AnyObject) {
    }
    

    @IBAction func onRetweet(sender: AnyObject) {
    }
    
    
    @IBAction func onLike(sender: AnyObject) {
    }
    
}

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
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweetID: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // rounded edges on photo
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
        
        
    }
    
    
    var tweet: Tweet! {
        didSet {
            fullNameLabel.text = tweet.user?.name
            usernameLabel.text = tweet.user?.screenname
            descriptionLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            tweetID = tweet.id
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoriteCountLabel.text = "\(tweet.favoritedCount)"
            
            let retweetedImageName = tweet.retweeted == false ? "retweet-action" : "retweet-action-pressed"
            retweetButton.setImage(UIImage(named: retweetedImageName), forState: .Normal)

            let favoritedImageName = tweet.favorited == false ? "like-action" : "like-action-pressed"
            favoriteButton.setImage(UIImage(named: favoritedImageName), forState: .Normal)
            
            if let imgUrl = tweet.user?.profileImageUrl {
                avatarImageView.setImageWithURL(NSURL(string: imgUrl)!)
            }
        }
    }
    
    @IBAction func onReply(sender: AnyObject) {
    }
    

    @IBAction func onRetweet(sender: AnyObject) {
        if tweet.retweeted == false {
            TwitterClient.sharedInstance.retweet(tweetID)
            retweetButton.setImage(UIImage(named: "retweet-action-pressed"), forState: .Normal)
            retweetCountLabel.text = "\(tweet.retweetCount + 1)"
        } else {
            TwitterClient.sharedInstance.untweet(tweetID)
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: .Normal)
            retweetCountLabel.text = "\(tweet.retweetCount)"
        }
        
        tweet.retweeted = !tweet.retweeted
    }
    
    
    @IBAction func onLike(sender: AnyObject) {
        if tweet.favorited == false {
            TwitterClient.sharedInstance.favoriteTweet(tweetID)
            favoriteButton.setImage(UIImage(named: "like-action-pressed"), forState: .Normal)
            favoriteCountLabel.text = "\(tweet.favoritedCount + 1)"
        } else {
            TwitterClient.sharedInstance.unFavoriteTweet(tweetID)
            favoriteButton.setImage(UIImage(named: "like-action"), forState: .Normal)
            favoriteCountLabel.text = "\(tweet.favoritedCount)"
        }
        
        tweet.favorited = !tweet.favorited
    }
    
}

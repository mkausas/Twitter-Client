//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/11/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
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

    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTweetView()
    }

    func setupTweetView() {
        fullNameLabel.text = tweet.user?.name
        usernameLabel.text = "@\((tweet.user?.screenname)!)"
        descriptionLabel.text = tweet.text
        timestampLabel.text = tweet.createdAtString
        tweetID = tweet.id
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoriteCountLabel.text = "\(tweet.favoritedCount)"
        
        let retweetedImageName = (tweet.retweeted != nil) ? "retweet-action" : "retweet-action-pressed"
        retweetButton.setImage(UIImage(named: retweetedImageName), forState: .Normal)
        
        if let imgUrl = tweet.user?.profileImageUrl {
            avatarImageView.setImageWithURL(NSURL(string: imgUrl)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func onFavorite(sender: AnyObject) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

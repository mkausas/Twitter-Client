//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/13/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var tweets: [Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 169
        
        // rounded edges on photo
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
    }
    
    func setupView() {
        fullNameLabel.text = user.name
        usernameLabel.text = "@\(user.screenname!)"
        
        avatarImageView.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        backgroundImageView.setImageWithURL(NSURL(string: user.backgroundImageUrl!)!)
        
        tweetCountLabel.text = String(user.tweet_count!)
        followingCountLabel.text = String(user.following_count!)
        followersCountLabel.text = String(user.followers_count!)
        
        reloadTimeline()
    }
    
    func reloadTimeline() {
        TwitterClient.sharedInstance.userTimelineWithParams(["screen_name": user.screenname!]) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }

    var selectedTweet: Tweet!
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedTweet = tweets![indexPath.row]
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destinationViewController
        if let vc = vc as? TweetDetailViewController {
            vc.tweet = selectedTweet
        }
    }
    
    

}

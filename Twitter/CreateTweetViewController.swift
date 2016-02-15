//
//  CreateTweetViewController.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/12/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    var user: User!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.delegate = self
        
        setupView()
        
        // rounded edges on photo
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
    }
    
    func setupView() {
        fullnameLabel.text = user?.name
        usernameLabel.text = user?.screenname
        if let imgUrl = user?.profileImageUrl {
            avatarImageView.setImageWithURL(NSURL(string: imgUrl)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        print(text)
        return charCount < 140 || text == ""
    }
    
    var charCount = 0;
    func textViewDidChange(textView: UITextView) {
        charCount = textView.text.characters.count
        characterCountLabel.text = "\(charCount)"
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
        }
    }

    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.tweet(tweetTextView.text)
        dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
    }
    */
    

}

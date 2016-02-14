//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Martynas Kausas on 2/13/16.
//  Copyright © 2016 Martynas Kausas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupView()
        
        // rounded edges on photo
        avatarImageView.layer.cornerRadius = 5
        avatarImageView.clipsToBounds = true
    }
    
    func setupView() {
        fullNameLabel.text = user.name
        usernameLabel.text = "@\(user.screenname!)"
        
        avatarImageView.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        backgroundImageView.setImageWithURL(NSURL(string: user.backgroundImageUrl!)!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

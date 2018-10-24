//
//  TwitterCell.swift
//  twitter_alamofire_demo
//
//  Created by Tony Zhang on 10/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TwitterCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetField: UILabel!
    
    @IBOutlet weak var timeStampField: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var replyCount: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    // Create a parent view so I can call the function refresh
    var parentView : TimelineViewController?

    var tweet : Tweet?{
        didSet{
            displayName.text = tweet?.user?.name
            let name = tweet!.user!.screenName as! String
            print(name)
            userName.text = "@\(name)"
            tweetField.text = tweet?.text
            retweetCount.text = String(tweet?.retweetCount as! Int)
            likesCount.text = String(tweet?.favoriteCount as! Int)
            profileImage.af_setImage(withURL: (tweet?.user?.profilepic)!)
            timeStampField.text = tweet?.createdAtString
            // Make the reply count to nil for now
            replyCount.text = " "
        }
    }
    var user : User?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateFavoriteTweetCounts() {
        retweetCount.text = String(self.tweet?.retweetCount as! Int)
        likesCount.text = String(self.tweet?.favoriteCount as! Int)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func retweetAction(_ sender: Any) {
        tweet?.retweeted = true
        tweet?.retweetCount = (tweet?.retweetCount)! + 1
        
        updateFavoriteTweetIcons()

        APIManager.shared.retweet(self.tweet!) { (post, error) in
            if let  error = error {
                print("Error Favoriting Tweet: \(error.localizedDescription)")
            } else {
                self.parentView?.completeNetworkRequest()
            }
        }
        
    }
    
    @IBAction func likedAction(_ sender: Any) {
        // TODO: Update the local tweet model
        tweet?.favorited = true
        tweet?.favoriteCount = (tweet?.favoriteCount)! + 1
        
        
        
        // TODO: Update cell UI
        updateFavoriteTweetIcons()
        // TODO: Send a POST request to the POST favorites/create endpoint
        
        APIManager.shared.favorite(self.tweet!) { (post, error) in
            if let  error = error {
                print("Error Favoriting Tweet: \(error.localizedDescription)")
            } else {
                self.parentView?.completeNetworkRequest()
            }
        }
    }
    
    func updateFavoriteTweetIcons() {
        if (self.tweet!.favorited! == true) {
            self.likeButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        }
        else {
            self.likeButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
        }
        if (self.tweet!.retweeted == true) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        }
        else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
        }
    }
    
    //Make the new liked count
    
    func updateAllContent() {
        if let tweet = self.tweet, let user = self.user {
            
            self.updateFavoriteTweetIcons()
            self.updateFavoriteTweetCounts()
        }
    }
}

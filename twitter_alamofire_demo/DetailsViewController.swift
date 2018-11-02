//
//  DetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tony Zhang on 11/1/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var FullName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var favoriteCounts: UILabel!
    @IBOutlet weak var retweetCounts: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweet : Tweet?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContent()
        // Do any additional setup after loading the view.
    }
    
    func updateContent() {
        if let tweet = self.tweet, let user = self.user  {
            if let propicURL = user.profilepic {
                userImage.af_setImage(withURL: (tweet.user?.profilepic)!)
                
            }
            FullName.text = tweet.user?.name
            let name = tweet.user!.screenName as! String
            print(name)
            username.text = "@\(name)"
            tweetText.text = tweet.text
            retweetCounts.text = String(tweet.retweetCount as! Int)
            favoriteCounts.text = String(tweet.favoriteCount as! Int)
            
            timeStamp.text = tweet.createdAtString
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTapLike(_ sender: Any) {
        if (tweet!.favorited == false) {
            APIManager.shared.favorite(self.tweet!) { (post, error) in
                
                self.favoriteCounts.text = String((self.tweet!.favoriteCount as! Int) + 1)
                self.tweet?.favorited = true
                
                // To Do, change the icon color
            }
        }
        else {
            APIManager.shared.unfavorite(self.tweet!) { (post, error) in
                self.favoriteCounts.text = String((self.tweet!.favoriteCount as! Int) - 1)
                self.tweet?.favorited = false

            }
        }
        updateFavoriteTweetIcons()

    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
        
        if (tweet!.retweeted == false) {
            APIManager.shared.retweet(self.tweet!) { (post, error) in
                self.retweetCounts.text = String((self.tweet!.retweetCount as! Int) + 1)
                self.tweet?.retweeted = true
            }
        }
        else {
            APIManager.shared.unretweet(self.tweet!) { (post, error) in
                self.retweetCounts.text = String((self.tweet!.retweetCount as! Int) - 1)
                self.tweet?.retweeted = false

            }
        }
        updateFavoriteTweetIcons()
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
}

//
//  TwitterCell.swift
//  twitter_alamofire_demo
//
//  Created by Tony Zhang on 10/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetField: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var replyCount: UILabel!
    
    var tweet : Tweet?{
        didSet{
            displayName.text = tweet?.user?.screenName
            userName.text = tweet?.user?.name
            tweetField.text = tweet?.text
            retweetCount.text = String(tweet?.retweetCount as! Int)
            likesCount.text = String(tweet?.favoriteCount as! Int)
            
        }
    }
    var user : User?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

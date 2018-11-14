//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tony Zhang on 11/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var following: UILabel!
    
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var tweets: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullName.text = User.current?.name
        userName.text = User.current?.screenName
        let followingCount = User.current?.friends_count as! Int
        following.text = String(followingCount)
        let followerCount = User.current?.followers_count as! Int
        followers.text = String(followerCount)
        profileImage.af_setImage(withURL: (User.current?.profilepic)!)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

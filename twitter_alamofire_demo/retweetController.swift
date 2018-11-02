
//
//  retweetController.swift
//  twitter_alamofire_demo
//
//  Created by Tony Zhang on 10/23/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class retweetController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var tweetTextView: UITextField!
    weak var delegate: retweetControllerDelegate?
    var parentView : TimelineViewController?
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tweetTaped(_ sender: Any) {
        if (tweet!.retweeted == false) {
            APIManager.shared.retweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                }
            }
        }
        else {
            APIManager.shared.unretweet(self.tweet!) { (post, error) in
                if let  error = error {
                    print("Error Favoriting Tweet: \(error.localizedDescription)")
                } else {
                    self.parentView?.completeNetworkRequest()
                }
            }
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

}

protocol retweetControllerDelegate  : class {
    func did(post : Tweet)
}

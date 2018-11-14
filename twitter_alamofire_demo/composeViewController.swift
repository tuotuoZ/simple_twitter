//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Tony Zhang on 11/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}


class ComposeViewController: UIViewController, UITextViewDelegate {
 
    var delegate: ComposeViewControllerDelegate?


    @IBOutlet weak var composeTweetTextView: UITextView!
    
    @IBOutlet weak var charCountLabel: UILabel!
    
    var tweet: Tweet?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        composeTweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      
        let characterLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        charCountLabel.text = "Characters Remaining: " +  String(characterLimit - newText.count)
        
        return newText.characters.count < characterLimit
    }

    @IBAction func didTapPost(_ sender: Any) { //onPost
        print("trying to compose")
        APIManager.shared.composeTweet(with: composeTweetTextView.text ?? "test tweet") { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Compose Tweet Success!")

                // CAll the delegate
                self.delegate?.did(post: tweet)

                NotificationCenter.default.post(name: NSNotification.Name("didTapPost"), object: nil)
                
            }
        }
    }
    @IBAction func didCancel(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
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

//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import KeychainAccess
import Alamofire
import OAuthSwift
import OAuthSwiftAlamofire

class TimelineViewController: UIViewController, UITableViewDataSource {

    var tweets: [Tweet]?
    var tableView: UITableView?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTweets()
        tableView?.dataSource = self
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 120


        // Pull-To-Refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.completeNetworkRequest), for: .valueChanged)
        tableView?.insertSubview(refreshControl, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweets!
                self.tableView?.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        let tweet = tweets?[indexPath.row]
        cell.tweet = tweet
        cell.user = tweet?.user // User.current
        cell.updateAllContent()
        cell.parentView = self as TimelineViewController
        return cell
        
        
    }
    
    // Request new tweets
    func completeNetworkRequest() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweets!
                self.tableView?.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

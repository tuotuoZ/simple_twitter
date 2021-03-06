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

class TimelineViewController: UIViewController, UITableViewDataSource, ComposeViewControllerDelegate {
    func did(post: Tweet) {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView?.reloadData()
                self.refreshControl.endRefreshing()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    

    var tweets: [Tweet]?
    var tableView: UITableView?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 120


        // Pull-To-Refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.refreshControlAction(_:)), for: .valueChanged)
        tableView?.insertSubview(refreshControl, at: 0)
        
        self.tableView?.reloadData()


        completeNetworkRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        completeNetworkRequest()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        let tweet = tweets?[indexPath.row]
        cell.tweet = tweet
        cell.indexPath = indexPath
        cell.user = tweet?.user // User.current
        cell.updateAllContent()
        cell.parentView = self as TimelineViewController
        return cell
        
        
    }
    
    // Request new tweets
    func completeNetworkRequest() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView?.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        refreshControl.endRefreshing()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let detailView = segue.destination as? DetailsViewController {   
                if let cell = sender as! TwitterCell? {
                    detailView.tweet = tweets?[(cell.indexPath?.row)!]
                }
                detailView.user = User.current
            }
        }
        else if segue.identifier == "composeTweetSegue" {
            print("3")
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.delegate = self;
            present(composeViewController, animated: true, completion: nil)
        } 
    }
}

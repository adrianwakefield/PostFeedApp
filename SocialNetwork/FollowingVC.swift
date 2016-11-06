//
//  FollowingVC.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit
import Firebase

class FollowingVC: UITableViewController {
    
    var followingArray: [UserModel] = []
    
    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FollowCell.self, forCellReuseIdentifier: followingCellId)
        returnFollowing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBarCleanup()
    }
    
    // Returns the people that the current user is following and observes any changes in following relations
    func returnFollowing() {
        FIREBASE_FOLLOWING_REF.child(CURRENT_UID!).observe(.childAdded, with: { (snapshot) in
            let userId = snapshot.key
            APIService.sharedInstance.returnUserFromId(userID: userId, completionHandler: { (userReturned) in
                self.followingArray.append(userReturned)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            
        }, withCancel: nil)
        
        FIREBASE_FOLLOWING_REF.child(CURRENT_UID!).observe(.childRemoved, with: { (snapshot) in
            let userId = snapshot.key
            for (index, eachUser) in self.followingArray.enumerated() {
                if eachUser.uid! == userId {
                   self.followingArray.remove(at: index)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            }, withCancel: nil)
    }
}

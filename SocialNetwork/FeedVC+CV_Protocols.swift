//
//  FeedVC+Protocols.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

extension FeedVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FollowDelegate {
    
    // MARK: Collection View Functionality
    
    // Sets up cell registration, delegate and data source for collection view handling
    func setupCollectionView() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // How many collection view cells based on amount of posts
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    // Handles configuration of each collection view cell post
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath) as! FeedCell
        cell.delegate = self
        cell.configureFeedCell(feedPost: posts[indexPath.row])
        return cell
    }
    
    // Handles sizing of each collection view cell post
    @objc(collectionView:layout:sizeForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 300)
    }
    
    // Responds to following a user event
    func didFollowUser(userId: String) {
        APIService.sharedInstance.returnUserFromId(userID: userId) { (user) in
            let userName = user.name!
            self.displayFollowPopup(name: userName)
        }
    }
    
    // Error handling for following
    func followDidFail(error: ErrorHandling.FollowUserError) {
        switch error {
        case .cannotFollowSelf:
            displayErrorModal(errorTitle: "UNABLE TO FOLLOW", errorDescription: "You can only follow other people. Sorry!")
        case .alreadyFollowingUser:
            displayErrorModal(errorTitle: "ALREADY FOLLOWING", errorDescription: "Whoops! Looks like you're already following this user.")
        }
    }
    
    // MARK: Error Handling Functionality
    
    func displayErrorModal(errorTitle: String, errorDescription: String) {
        let popup = ErrorModal()
        popup.configureModal(errorTitle: errorTitle, errorDescription: errorDescription)
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
    
    func displayFollowPopup(name: String) {
        dismissTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(hideFollowPopup), userInfo: nil, repeats: false)
        self.followingPopup.isHidden = false
        self.followingPopup.followingLabel.text = "You are now following " + name
        UIView.animate(withDuration: 3.0, animations: {
            self.followingPopup.alpha = 0.0
        })
    }
    
    func hideFollowPopup() {
        dismissTimer?.invalidate()
        self.followingPopup.isHidden = true
        self.followingPopup.alpha = 1.0
    }
    
}

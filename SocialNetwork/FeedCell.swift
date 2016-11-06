//
//  FeedCell.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UICollectionViewCell {
    
    private var currentPost: FeedPostModel?
    var delegate: FollowDelegate?
    
    // MARK: Initial Cell Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAppearance()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup for each cell's appearance
    func setAppearance() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        contentView.layer.shadowRadius = 5.0
        contentView.layer.shadowOpacity = 0.7
    }
    
    // MARK: View object setup
    
    lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.layer.cornerRadius = 20
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.isUserInteractionEnabled = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(followUser)))
        return profileImage
    }()
    
    let userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()
    
    let timestampLabel: UILabel = {
        let timestampLabel = UILabel()
        timestampLabel.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        timestampLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        return timestampLabel
    }()
    
    let attachedImageView: UIImageView = {
        let attachedImageView = UIImageView()
        attachedImageView.translatesAutoresizingMaskIntoConstraints = false
        return attachedImageView
    }()
    
    let captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        return captionLabel
    }()
    
    lazy var heartImage: UIImageView = {
        let heartImage = UIImageView()
        heartImage.image = UIImage(named: "heart_icon")
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        heartImage.isUserInteractionEnabled = true
        heartImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likePost)))
        return heartImage
    }()
    
    // MARK: Cell Configuration

    // Adds specified cell information to the cell
    func configureFeedCell(feedPost: FeedPostModel) {
        self.currentPost = feedPost
        attachedImageView.image = nil
        APIService.sharedInstance.returnUserFromId(userID: feedPost.userPoster!) { (user) in
            self.userNameLabel.text = user.name!
            self.profileImage.downloadImageFromURL(url: user.profileImageURL!, imageType: .profileImage, completionHandler: { 
                ()
            })
        }
        timestampLabel.text = "Posted " + Date.timeAgoSinceDate(timeInterval: feedPost.timestamp!, numericDates: true)
        captionLabel.text = feedPost.caption!
        attachedImageView.downloadImageFromURL(url: feedPost.imageURL!, imageType: .postImage) {
            ()
        }
        
        FIREBASE_LIKES_REF.child(CURRENT_UID!).child((currentPost?.postId!)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.heartImage.image = UIImage(named: "heart_icon")
            }
            else {
                self.heartImage.image = UIImage(named: "heart_icon_filled")?.withRenderingMode(.alwaysTemplate)
                self.heartImage.tintColor = .red
            }
            }, withCancel: nil)
    }
    
    // Handles the following of a user
    func followUser() {
        if currentPost?.userPoster! == CURRENT_UID! {
            // handle error popup
            self.delegate?.followDidFail(error: .cannotFollowSelf)
            return
        }
        
        else {
            FIREBASE_FOLLOWING_REF.child(CURRENT_UID!).child((currentPost?.userPoster!)!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let _ = snapshot.value as? NSNull {
                    FIREBASE_FOLLOWING_REF.child(CURRENT_UID!).child((self.currentPost?.userPoster!)!).updateChildValues([(self.currentPost?.userPoster!)!: true])
                    self.delegate?.didFollowUser(userId: (self.currentPost?.userPoster!)!)
                }
                else {
                    self.delegate?.followDidFail(error: .alreadyFollowingUser)
                    return
                }
            }, withCancel: nil)
        }
    }
    
    // Handles liking OR unliking of a post
    func likePost() {
        FIREBASE_LIKES_REF.child(CURRENT_UID!).child((currentPost?.postId!)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                FIREBASE_LIKES_REF.child(CURRENT_UID!).child((self.currentPost?.postId!)!).updateChildValues([(self.currentPost?.postId!)!: true])
                self.heartImage.image = UIImage(named: "heart_icon_filled")?.withRenderingMode(.alwaysTemplate)
                self.heartImage.tintColor = .red
            }
            else {
                FIREBASE_LIKES_REF.child(CURRENT_UID!).child((self.currentPost?.postId!)!).removeValue()
                self.heartImage.image = UIImage(named: "heart_icon")
            }
        }, withCancel: nil)
    }
}

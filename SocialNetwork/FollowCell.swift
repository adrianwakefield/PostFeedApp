//
//  FollowCell.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 5/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

class FollowCell: UITableViewCell {
    
    var currentUser: UserModel?
    
    // MARK: Initial Cell Setup
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Object Setup
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.backgroundColor = .lightGray
        profileImage.layer.cornerRadius = 25
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    lazy var unfollowButton: UIButton = {
        let unfollowButton = UIButton(type: .system)
        unfollowButton.backgroundColor = NAVBAR_BLUE_COLOR
        unfollowButton.layer.cornerRadius = 5
        unfollowButton.setTitle("UNFOLLOW", for: .normal)
        unfollowButton.setTitleColor(.white, for: .normal)
        unfollowButton.translatesAutoresizingMaskIntoConstraints = false
        unfollowButton.addTarget(self, action: #selector(unfollowUser), for: .touchUpInside)
        return unfollowButton
    }()
    
    // Unfollows a user
    func unfollowUser() {
        FIREBASE_FOLLOWING_REF.child(CURRENT_UID!).child((currentUser?.uid!)!).removeValue()
    }
    
    // MARK: Cell Configuration
    
    func configureCell(user: UserModel) {
        self.currentUser = user
        nameLabel.text = user.name!
        profileImage.downloadImageFromURL(url: user.profileImageURL!, imageType: .profileImage) {
            ()
        }
    }
}

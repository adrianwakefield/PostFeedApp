//
//  FollowCell+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 5/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension FollowCell {
    
    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(unfollowButton)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: unfollowButton.leftAnchor, constant: -15).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        
        unfollowButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        unfollowButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        unfollowButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        unfollowButton.heightAnchor.constraint(equalTo: profileImage.heightAnchor, constant: -10).isActive = true
    }
}

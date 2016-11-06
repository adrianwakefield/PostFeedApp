//
//  FeedCell+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension FeedCell {
    
    // MARK: View Configuration
    
    override func prepareForReuse() {
        attachedImageView.image = nil
        super.prepareForReuse()
    }
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(timestampLabel)
        contentView.addSubview(attachedImageView)
        contentView.addSubview(captionLabel)
        contentView.addSubview(heartImage)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        
        userNameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: heartImage.leftAnchor, constant: -10).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        timestampLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        timestampLabel.rightAnchor.constraint(equalTo: heartImage.leftAnchor, constant: -10).isActive = true
        timestampLabel.topAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        timestampLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        heartImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        heartImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        heartImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        heartImage.heightAnchor.constraint(equalTo: heartImage.widthAnchor).isActive = true
        
        attachedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        attachedImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        attachedImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        attachedImageView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
        
        captionLabel.leftAnchor.constraint(equalTo: attachedImageView.leftAnchor, constant: 10).isActive = true
        captionLabel.rightAnchor.constraint(equalTo: attachedImageView.rightAnchor, constant: -10).isActive = true
        captionLabel.topAnchor.constraint(equalTo: attachedImageView.bottomAnchor, constant: 10).isActive = true
        captionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}

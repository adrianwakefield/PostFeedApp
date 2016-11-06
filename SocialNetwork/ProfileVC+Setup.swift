//
//  ProfileVC+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension ProfileVC {
    
    // MARK: View Configuration

    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        view.addSubview(bgView)
        bgView.addSubview(profileLabel)
        bgView.addSubview(nameLabel)
        bgView.addSubview(emailLabel)
        bgView.addSubview(profileImage)
        bgView.addSubview(logoutButton)
        profileImage.addSubview(loadingSpinner)
        view.addSubview(whiteOverlayView)
        whiteOverlayView.addSubview(usingAppTitleLabel)
        whiteOverlayView.addSubview(appDescriptionLabel)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
        bgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        profileLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 40).isActive = true
        profileLabel.widthAnchor.constraint(equalToConstant: profileLabel.intrinsicContentSize.width).isActive = true
        profileLabel.heightAnchor.constraint(equalToConstant: profileLabel.intrinsicContentSize.height).isActive = true
        
        profileImage.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: bgView.centerYAnchor, constant: -30).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 110).isActive = true
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        
        loadingSpinner.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        loadingSpinner.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        loadingSpinner.widthAnchor.constraint(equalTo: profileImage.widthAnchor, multiplier: 1/2).isActive = true
        loadingSpinner.heightAnchor.constraint(equalTo: loadingSpinner.widthAnchor).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: bgView.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        emailLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: bgView.widthAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        logoutButton.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: bgView.widthAnchor, multiplier: 1/3).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        whiteOverlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteOverlayView.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -30).isActive = true
        whiteOverlayView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        whiteOverlayView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
        
        usingAppTitleLabel.centerXAnchor.constraint(equalTo: whiteOverlayView.centerXAnchor).isActive = true
        usingAppTitleLabel.topAnchor.constraint(equalTo: whiteOverlayView.topAnchor, constant: 20).isActive = true
        usingAppTitleLabel.widthAnchor.constraint(equalToConstant: usingAppTitleLabel.intrinsicContentSize.width).isActive = true
        usingAppTitleLabel.heightAnchor.constraint(equalToConstant: usingAppTitleLabel.intrinsicContentSize.height).isActive = true
        
        appDescriptionLabel.centerXAnchor.constraint(equalTo: whiteOverlayView.centerXAnchor).isActive = true
        appDescriptionLabel.topAnchor.constraint(equalTo: usingAppTitleLabel.bottomAnchor, constant: 10).isActive = true
        appDescriptionLabel.widthAnchor.constraint(equalTo: whiteOverlayView.widthAnchor, constant: -20).isActive = true
        appDescriptionLabel.bottomAnchor.constraint(equalTo: whiteOverlayView.bottomAnchor, constant: -10).isActive = true
    }
}

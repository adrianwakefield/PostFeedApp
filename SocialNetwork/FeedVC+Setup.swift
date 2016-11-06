//
//  FeedVC+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension FeedVC {
    
    // MARK: Navigation Bar Setup
    
    // Setup navigation bar elements
    func setupNavigationBar() {
        navigationItem.title = "GLOBAL POST FEED"
    }
    
    // Remove navigation bar elements
    func navigationBarCleanup() {
        navigationItem.title = nil
    }
    
    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        view.addSubview(createPostView)
        createPostView.addSubview(addImageButton)
        createPostView.addSubview(captionInputTextField)
        createPostView.addSubview(postButton)
        view.addSubview(collectionView)
        view.addSubview(loadingView)
        view.addSubview(followingPopup)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        createPostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createPostView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        createPostView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        createPostView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addImageButton.leftAnchor.constraint(equalTo: createPostView.leftAnchor, constant: 10).isActive = true
        addImageButton.topAnchor.constraint(equalTo: createPostView.topAnchor, constant: 10).isActive = true
        addImageButton.bottomAnchor.constraint(equalTo: createPostView.bottomAnchor, constant: -10).isActive = true
        addImageButton.widthAnchor.constraint(equalTo: addImageButton.heightAnchor).isActive = true
        
        captionInputTextField.leftAnchor.constraint(equalTo: addImageButton.rightAnchor, constant: 10).isActive = true
        captionInputTextField.topAnchor.constraint(equalTo: addImageButton.topAnchor).isActive = true
        captionInputTextField.bottomAnchor.constraint(equalTo: addImageButton.bottomAnchor).isActive = true
        captionInputTextField.rightAnchor.constraint(equalTo: postButton.leftAnchor, constant: -10).isActive = true
        
        postButton.rightAnchor.constraint(equalTo: createPostView.rightAnchor, constant: -10).isActive = true
        postButton.topAnchor.constraint(equalTo: captionInputTextField.topAnchor).isActive = true
        postButton.bottomAnchor.constraint(equalTo: captionInputTextField.bottomAnchor).isActive = true
        postButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: createPostView.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        followingPopup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        followingPopup.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
        followingPopup.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        followingPopup.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

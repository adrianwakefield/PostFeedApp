//
//  FollowingBottomModal.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

class FollowingBottomModal: UIView {
    
    // MARK: Initial View Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.85)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Object Creation
    
    let followingLabel: UILabel = {
        let followingLabel = UILabel()
        followingLabel.textAlignment = .center
        followingLabel.text = "You are now following..."
        followingLabel.textColor = .white
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        return followingLabel
    }()
    
    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        addSubview(followingLabel)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        followingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        followingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        followingLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -10).isActive = true
        followingLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -10).isActive = true
    }
}

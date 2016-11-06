//
//  LoadingView.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: Initial View Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.85)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Object Creation
    
    let loadingLabel: UILabel = {
        let loadingLabel = UILabel()
        loadingLabel.textAlignment = .center
        loadingLabel.text = "CREATING POST"
        loadingLabel.font = UIFont.systemFont(ofSize: 12)
        loadingLabel.textColor = .white
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        return loadingLabel
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.color = .white
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadingIndicator
    }()
    
    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        addSubview(loadingLabel)
        addSubview(loadingIndicator)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        loadingIndicator.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        loadingIndicator.heightAnchor.constraint(equalTo: loadingIndicator.widthAnchor).isActive = true
        
        loadingLabel.leftAnchor.constraint(equalTo: loadingIndicator.rightAnchor, constant: 20).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        loadingLabel.heightAnchor.constraint(equalTo: loadingIndicator.heightAnchor).isActive = true
    }
    
}

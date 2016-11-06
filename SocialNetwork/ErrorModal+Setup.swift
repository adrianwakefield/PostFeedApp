//
//  ErrorModal+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 3/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension ErrorModal {
    
    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        view.addSubview(modalView)
        modalView.addSubview(errorImage)
        modalView.addSubview(errorTitleLabel)
        modalView.addSubview(errorDescriptionLabel)
        modalView.addSubview(separatorLine)
        modalView.addSubview(tryAgainButton)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        modalView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        modalView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2.5/5).isActive = true
        
        errorImage.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        errorImage.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20).isActive = true
        errorImage.widthAnchor.constraint(equalTo: errorImage.heightAnchor).isActive = true
        errorImage.heightAnchor.constraint(equalTo: modalView.heightAnchor, multiplier: 1/6).isActive = true
        
        errorTitleLabel.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        errorTitleLabel.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: 10).isActive = true
        errorTitleLabel.widthAnchor.constraint(equalTo: modalView.widthAnchor).isActive = true
        errorTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        errorDescriptionLabel.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        errorDescriptionLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 10).isActive = true
        errorDescriptionLabel.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -10).isActive = true
        errorDescriptionLabel.widthAnchor.constraint(equalTo: modalView.widthAnchor, constant: -30).isActive = true
        
        separatorLine.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: tryAgainButton.topAnchor, constant: -10).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: modalView.widthAnchor, constant: -15).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        tryAgainButton.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        tryAgainButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -10).isActive = true
        tryAgainButton.widthAnchor.constraint(equalTo: modalView.widthAnchor).isActive = true
        tryAgainButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

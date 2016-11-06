//
//  LoginVC+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 31/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension LoginVC {
    
    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        view.addSubview(bgImage)
        bgImage.addSubview(darkOverlay)
        view.addSubview(logoImage)
        view.addSubview(chatHeading)
        view.addSubview(subtitleLabel)
        view.addSubview(loginBox)
        loginBox.addSubview(emailImage)
        loginBox.addSubview(emailTextField)
        loginBox.addSubview(separatorLine)
        loginBox.addSubview(passwordImage)
        loginBox.addSubview(passwordTextField)
        loginBox.addSubview(loginButton)
        view.addSubview(createAnAccountButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loadingView)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        bgImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        darkOverlay.centerXAnchor.constraint(equalTo: bgImage.centerXAnchor).isActive = true
        darkOverlay.centerYAnchor.constraint(equalTo: bgImage.centerYAnchor).isActive = true
        darkOverlay.widthAnchor.constraint(equalTo: bgImage.widthAnchor).isActive = true
        darkOverlay.heightAnchor.constraint(equalTo: bgImage.heightAnchor).isActive = true
        
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        chatHeading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chatHeading.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        chatHeading.widthAnchor.constraint(equalToConstant: chatHeading.intrinsicContentSize.width).isActive = true
        chatHeading.heightAnchor.constraint(equalToConstant: chatHeading.intrinsicContentSize.height).isActive = true
        
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: chatHeading.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: subtitleLabel.intrinsicContentSize.width).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: subtitleLabel.intrinsicContentSize.height).isActive = true
        
        loginBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        loginBox.heightAnchor.constraint(equalToConstant: 150).isActive = true
        loginBoxBottomConstraint = loginBox.bottomAnchor.constraint(equalTo: createAnAccountButton.topAnchor, constant: -15)
        loginBoxBottomConstraint?.isActive = true
        
        emailImage.leftAnchor.constraint(equalTo: loginBox.leftAnchor, constant: 20).isActive = true
        emailImage.centerYAnchor.constraint(equalTo: loginBox.topAnchor, constant: 25).isActive = true
        emailImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: emailImage.rightAnchor, constant: 20).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailImage.centerYAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: loginBox.rightAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        separatorLine.centerXAnchor.constraint(equalTo: loginBox.centerXAnchor).isActive = true
        separatorLine.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: loginBox.widthAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordImage.leftAnchor.constraint(equalTo: loginBox.leftAnchor, constant: 20).isActive = true
        passwordImage.centerYAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20).isActive = true
        passwordImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: passwordImage.rightAnchor, constant: 20).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordImage.centerYAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: loginBox.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: loginBox.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: loginBox.bottomAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginBox.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        createAnAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        createAnAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        createAnAccountButton.widthAnchor.constraint(equalToConstant: createAnAccountButton.intrinsicContentSize.width).isActive = true
        createAnAccountButton.heightAnchor.constraint(equalToConstant: createAnAccountButton.intrinsicContentSize.height).isActive = true
        
        forgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        forgotPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: createAnAccountButton.intrinsicContentSize.width).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: createAnAccountButton.intrinsicContentSize.height).isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

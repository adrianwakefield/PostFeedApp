//
//  RegisterVC+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension RegisterVC {

    // MARK: View Configuration
    
    // Add subviews to relevant superviews
    func setupViewHierarchy() {
        view.addSubview(bgImage)
        bgImage.addSubview(bgImageMask)
        view.addSubview(registerBox)
        registerBox.addSubview(nameImage)
        registerBox.addSubview(nameTextField)
        registerBox.addSubview(separatorLine)
        registerBox.addSubview(emailImage)
        registerBox.addSubview(emailTextField)
        registerBox.addSubview(separatorLineTwo)
        registerBox.addSubview(passwordImage)
        registerBox.addSubview(passwordTextField)
        registerBox.addSubview(profileImage)
        profileImage.addSubview(photoView)
        profileImage.addSubview(addPhotoImage)
        registerBox.addSubview(registerButton)
        bgImageMask.addSubview(loginButton)
        view.addSubview(loadingView)
    }
    
    // Add autolayout constraints to each view object
    func setupConstraints() {
        bgImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        bgImageMask.centerXAnchor.constraint(equalTo: bgImage.centerXAnchor).isActive = true
        bgImageMask.centerYAnchor.constraint(equalTo: bgImage.centerYAnchor).isActive = true
        bgImageMask.widthAnchor.constraint(equalTo: bgImage.widthAnchor).isActive = true
        bgImageMask.heightAnchor.constraint(equalTo: bgImage.heightAnchor).isActive = true
        
        registerBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        registerBox.heightAnchor.constraint(equalToConstant: 230).isActive = true
        registerBoxBottomConstraint = registerBox.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -15)
        registerBoxBottomConstraint?.isActive = true

        nameImage.leftAnchor.constraint(equalTo: registerBox.leftAnchor, constant: 20).isActive = true
        nameImage.centerYAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5).isActive = true
        nameImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        nameImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: nameImage.rightAnchor, constant: 20).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: nameImage.centerYAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: registerBox.rightAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        separatorLine.centerXAnchor.constraint(equalTo: registerBox.centerXAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: registerBox.widthAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailImage.leftAnchor.constraint(equalTo: registerBox.leftAnchor, constant: 20).isActive = true
        emailImage.centerYAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 25).isActive = true
        emailImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: emailImage.rightAnchor, constant: 20).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailImage.centerYAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: registerBox.rightAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        separatorLineTwo.centerXAnchor.constraint(equalTo: registerBox.centerXAnchor).isActive = true
        separatorLineTwo.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
        separatorLineTwo.widthAnchor.constraint(equalTo: registerBox.widthAnchor).isActive = true
        separatorLineTwo.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordImage.leftAnchor.constraint(equalTo: registerBox.leftAnchor, constant: 20).isActive = true
        passwordImage.centerYAnchor.constraint(equalTo: separatorLineTwo.bottomAnchor, constant: 25).isActive = true
        passwordImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: passwordImage.rightAnchor, constant: 20).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordImage.centerYAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: registerBox.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        profileImage.centerXAnchor.constraint(equalTo: registerBox.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: registerBox.topAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        profileImage.layer.cornerRadius = 50
    
        addPhotoImage.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        addPhotoImage.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        addPhotoImage.widthAnchor.constraint(equalTo: profileImage.widthAnchor, multiplier: 1/3).isActive = true
        addPhotoImage.heightAnchor.constraint(equalTo: addPhotoImage.widthAnchor).isActive = true
        
        photoView.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        photoView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor).isActive = true
        photoView.layer.cornerRadius = 40
        
        registerButton.centerXAnchor.constraint(equalTo: registerBox.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: registerBox.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: registerBox.bottomAnchor).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: bgImageMask.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: bgImageMask.bottomAnchor, constant: -20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: loginButton.intrinsicContentSize.width).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: loginButton.intrinsicContentSize.height).isActive = true
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}

//
//  RegisterVC+Keyboard.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 5/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

extension RegisterVC {
    
    // MARK: Keyboard Handling
    
    // Adds keyboard observers
    func setupKeyboardHeightObservation() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardChange), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardChange), name: .UIKeyboardWillHide, object: nil)
    }
    
    // Responds to keyboard showing and hiding events - modification of view constraints in response to these events
    func handleKeyboardChange(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                if notification.name == .UIKeyboardWillShow {
                    registerBoxBottomConstraint?.constant = -(keyboardHeight - 40)
                }
                if notification.name == .UIKeyboardWillHide {
                    registerBoxBottomConstraint?.constant = -15
                }
            }
        }
    }
}

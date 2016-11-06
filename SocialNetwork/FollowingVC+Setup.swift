//
//  FollowingVC+Setup.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

extension FollowingVC {
    
    // MARK: Navigation Bar Setup
    
    // Setup navigation bar elements
    func navigationBarSetup() {
        navigationItem.title = "FOLLOWING"
    }
    
    // Remove navigation bar elements
    func navigationBarCleanup() {
        navigationItem.title = nil
    }
}

//
//  FeedCell+Protocols.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 5/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation

// Handles following of user events
protocol FollowDelegate {
    func didFollowUser(userId: String)
    func followDidFail(error: ErrorHandling.FollowUserError)
}

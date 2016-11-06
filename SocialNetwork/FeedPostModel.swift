//
//  FeedModel.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

// Stores a created feed post object of relevant feed post details

class FeedPostModel {
    
    var postId: String?
    var caption: String?
    var userPoster: String?
    var imageURL: String?
    var timestamp: Double?
    var likes: Int?
    
    init(caption: String, userIdPoster: String, imageURL: String, timestamp: Double, likes: Int) {
        self.caption = caption
        self.userPoster = userIdPoster
        self.imageURL = imageURL
        self.timestamp = timestamp
        self.likes = likes
    }
    
}

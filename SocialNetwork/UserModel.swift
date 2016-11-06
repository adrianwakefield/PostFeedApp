//
//  UserModel.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

// Stores a downloaded user object of relevant user details

class UserModel {
    
    var uid: String?
    var name: String?
    var email: String?
    var profileImageURL: String?
    
    init(uid: String, name: String, email: String, profileImageURL: String) {
        self.uid = uid
        self.name = name
        self.email = email
        self.profileImageURL = profileImageURL
    }
}

//
//  GlobalConstants.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation
import Firebase

// MARK: Firebase References

// Firebase Database References
let FIREBASE_ROOT_REF = FIRDatabase.database().reference()
let FIREBASE_USERS_REF = FIREBASE_ROOT_REF.child("Users")
let FIREBASE_POSTS_REF = FIREBASE_ROOT_REF.child("Posts")
let FIREBASE_POSTS_RELATION_REF = FIREBASE_ROOT_REF.child("Post_Relations")
let FIREBASE_FOLLOWING_REF = FIREBASE_ROOT_REF.child("Following_Relation")
let FIREBASE_LIKES_REF = FIREBASE_ROOT_REF.child("Post_Likes")

// Firebase Storage References
let FIREBASE_STORAGE_ROOT_REF = FIRStorage.storage().reference()
let FIREBASE_PROFILE_IMAGE_STORAGE_REF = FIREBASE_STORAGE_ROOT_REF.child("Profile_Images")
let FIREBASE_POST_IMAGE_STORAGE_REF = FIREBASE_STORAGE_ROOT_REF.child("Post_Images")

// Current User ID reference
var CURRENT_UID: String? {
    if FIRAuth.auth()?.currentUser != nil {
        return FIRAuth.auth()?.currentUser?.uid
    }
    else {
        return nil
    }
}

// MARK: Caching

// Cache References
let postImageCache = NSCache<AnyObject, AnyObject>()
let profileImageCache = NSCache<AnyObject, AnyObject>()

// MARK: Appearance

// Color References
let NAVBAR_BLUE_COLOR = UIColor(red: 0.13, green: 0.59, blue: 0.95, alpha: 1)

// MARK: Cell Reuse Identifiers

// Table View & Collection View Cell Reuse Identifiers
let feedCellId = "feedCellId"
let followingCellId = "followingCellId"
let friendCellId = "friendCellId"

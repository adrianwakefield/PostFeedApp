//
//  APIService.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

// This class is reponsible for all Firebase API-related functionality handling.
// This includes authentication, database and storage related tasks.

import Foundation
import Firebase

class APIService {
    
    // Defines singleton instance
    static let sharedInstance = APIService()
    
    // MARK: Login & Logout Functionality
    
    // Handles login of a user using provided credentials
    func loginUser(email: String, password: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                completionHandler(false, error)
            }
            
            else {
                completionHandler(true, nil)
            }
        })
    }
    
    // Handles logout of currently logged-in user
    func logoutUser(completionHandler: @escaping (Bool, Error?) -> ()) {
        do {
            try FIRAuth.auth()?.signOut()
            completionHandler(true, nil)
        }
        catch let error {
            completionHandler(false, error)
        }
    }
    
    // MARK: Registration Functionality
    
    // Handles registration of a new user into Firebase Authentication and into database
    func createNewUser(email: String, password: String, name: String, profileImage: UIImage, completionHandler: @escaping (Bool, Error?) -> ()) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                completionHandler(false, error)
            }
                
            else {
                let newUserRef = FIREBASE_USERS_REF.child((user?.uid)!)
                self.uploadProfileImageToStorage(image: profileImage, completionHandler: { (imageURL, error) in
                    if error != nil {
                        completionHandler(false, error)
                    }
                    else {
                        let values = ["name": name, "email": email, "profileImageURL": imageURL!] as [String : Any]
                        newUserRef.updateChildValues(values, withCompletionBlock: { (error, reference) in
                            if error != nil {
                                completionHandler(false, error)
                            }
                                
                            else {
                                completionHandler(true, nil)
                            }
                        })
                    }
                })
            }

        })
    }
    
    // Handles upload of profile picture to Firebase storage upon registration
    func uploadProfileImageToStorage(image: UIImage, completionHandler: @escaping (String?, Error?) -> ()) {
        let imageName = NSUUID().uuidString
        let compressedImage = UIImageJPEGRepresentation(image, 0.1)
        FIREBASE_PROFILE_IMAGE_STORAGE_REF.child(imageName).put(compressedImage!, metadata: nil) { (metadata, error) in
            if error != nil {
                completionHandler(nil, error)
            }
                
            else {
                if let downloadURL = metadata?.downloadURL()?.absoluteString {
                    completionHandler(downloadURL, nil)
                }
            }
        }
    }
        
    // MARK: Post Creation Functionality
    
    // Handles upload of image and caption post to storage and database
    func uploadNewPost(caption: String, image: UIImage, completionHandler: @escaping (FeedPostModel?, Error?) -> ()) {
        let imageName = NSUUID().uuidString
        let compressedImage = UIImageJPEGRepresentation(image, 0.1)
        FIREBASE_POST_IMAGE_STORAGE_REF.child(imageName).put(compressedImage!, metadata: nil) { (metadata, error) in
            if error != nil {
                completionHandler(nil, error)
            }
            
            if let downloadURL = metadata?.downloadURL()?.absoluteString {
                let newPostsRef = FIREBASE_POSTS_REF.childByAutoId()
                let caption = caption
                let imageURL = downloadURL
                let timestamp = Date().timeIntervalSince1970
                let likesCount = 0
                let userPoster = CURRENT_UID!
                let post = FeedPostModel(caption: caption, userIdPoster: userPoster, imageURL: imageURL, timestamp: timestamp, likes: likesCount)
                let values = ["caption": caption, "imageURL": imageURL, "timestamp": timestamp, "likesCount": likesCount, "userPoster": userPoster] as [String : Any]
                newPostsRef.updateChildValues(values) { (error, reference) in
                    if error != nil {
                        print(error)
                        completionHandler(nil, error)
                    }
                    post.postId = newPostsRef.key
                    completionHandler(post, nil)
                }
                
            }
        }
    }
    
    // MARK: Miscellaneous Functionality
    
    // Returns a user object from a provided user ID
    func returnUserFromId(userID: String, completionHandler: @escaping (UserModel) -> ()) {
        FIREBASE_USERS_REF.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let id = snapshot.key
                let name = dictionary["name"] as! String
                let email = dictionary["email"] as! String
                let imageURL = dictionary["profileImageURL"] as! String
                let user = UserModel(uid: id, name: name, email: email, profileImageURL: imageURL)
                completionHandler(user)
            }
            }, withCancel: nil)
    }
}

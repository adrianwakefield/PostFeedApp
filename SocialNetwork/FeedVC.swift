//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {
    
    var dismissTimer: Timer?
    var posts: [FeedPostModel] = []
    
    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupCollectionView()
        setupImagePicker()
        setupViewHierarchy()
        setupConstraints()
        retrievePostsFromDatabase()
        self.loadingView.isHidden = true
        self.followingPopup.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBarCleanup()
    }
    
    // MARK: View Object Setup
    
    let createPostView: UIView = {
        let createPostView = UIView()
        createPostView.isUserInteractionEnabled = true
        createPostView.backgroundColor = .white
        createPostView.translatesAutoresizingMaskIntoConstraints = false
        return createPostView
    }()
    
    lazy var addImageButton: UIImageView = {
        let addImageButton = UIImageView()
        addImageButton.isUserInteractionEnabled = true
        addImageButton.image = UIImage(named: "add_image_icon")
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displayImagePicker)))
        return addImageButton
    }()
    
    let captionInputTextField: UITextField = {
        let captionInputTextField = UITextField()
        captionInputTextField.borderStyle = .roundedRect
        captionInputTextField.placeholder = "Type a caption here..."
        captionInputTextField.translatesAutoresizingMaskIntoConstraints = false
        return captionInputTextField
    }()
    
    lazy var postButton: UIButton = {
        let postButton = UIButton(type: .system)
        postButton.setTitle("POST", for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.addTarget(self, action: #selector(addPostToDatabase), for: .touchUpInside)
        return postButton
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let imagePicker = UIImagePickerController()
    
    let loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    let followingPopup: FollowingBottomModal = {
        let followingPopup = FollowingBottomModal()
        followingPopup.translatesAutoresizingMaskIntoConstraints = false
        return followingPopup
    }()
    
    // MARK: View Controller Functionality
    
    // Adds a new post to the database
    func addPostToDatabase() {
        if addImageButton.image != UIImage(named: "add_image_icon") && !(captionInputTextField.text?.isEmpty)! {
            guard let chosenImage = addImageButton.image, let captionText = captionInputTextField.text else {
                displayErrorModal(errorType: .createPostNoCaptionOrImageEntered)
                return
            }
            
            loadingView.isHidden = false
            loadingView.loadingLabel.text = "CREATING POST"
            loadingView.loadingIndicator.startAnimating()
            
            APIService.sharedInstance.uploadNewPost(caption: captionText, image: chosenImage, completionHandler: { (post, error) in
                if error != nil {
                    self.loadingView.isHidden = true
                    self.loadingView.loadingIndicator.stopAnimating()
                    let firebaseError = ErrorHandling.handleFirebaseError(error: error!)
                    self.displayFirebaseErrorModal(error: firebaseError)
                }
                
                else {
                    FIREBASE_POSTS_RELATION_REF.child(CURRENT_UID!).updateChildValues([(post?.postId!)!: true])
                    self.loadingView.isHidden = true
                    self.loadingView.loadingIndicator.stopAnimating()
                }
            })
            
            addImageButton.image = UIImage(named: "add_image_icon")
            captionInputTextField.text?.removeAll()
        }
        
        else {
            displayErrorModal(errorType: .createPostNoCaptionOrImageEntered)
            return
        }
    }
    
    // Observes posts in the database and adds them to collection view accordingly
    func retrievePostsFromDatabase() {
        FIREBASE_POSTS_REF.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let postId = snapshot.key
                let caption = dictionary["caption"] as? String
                let imageURL = dictionary["imageURL"] as? String
                let timestamp = dictionary["timestamp"] as? Double
                let likesCount = dictionary["likesCount"] as? Int
                let userPoster = dictionary["userPoster"] as? String
                let post = FeedPostModel(caption: caption!, userIdPoster: userPoster!, imageURL: imageURL!, timestamp: timestamp!, likes: likesCount!)
                post.postId = postId
                self.posts.insert(post, at: 0)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            }, withCancel: nil)
    }

    // MARK: Error Handling Functionality
    
    func displayFirebaseErrorModal(error: (String, String)) {
        let popup = ErrorModal()
        popup.configureModal(errorTitle: error.0, errorDescription: error.1)
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
    
    func displayErrorModal(errorType: ErrorHandling.ErrorType) {
        let popup = ErrorModal()
        popup.configureModal(errorTitle: errorType.description.0, errorDescription: errorType.description.1)
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
    
    // MARK: Displaying Other Screens
    
    // Displays an image picker
    func displayImagePicker() {
        present(self.imagePicker, animated: true, completion: nil)
    }
}

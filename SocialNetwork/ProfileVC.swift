//
//  ProfileVC.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    var user: UserModel?
    
    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setupViewHierarchy()
        setupConstraints()
        loadProfileDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: View Object Setup
    
    let bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = NAVBAR_BLUE_COLOR
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    let profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.text = "MY PROFILE"
        profileLabel.textAlignment = .center
        profileLabel.textColor = .white
        profileLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightThin)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        return profileLabel
    }()
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.backgroundColor = .white
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 55
        profileImage.contentMode = .scaleAspectFill
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    let loadingSpinner: UIActivityIndicatorView = {
        let loadingSpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        loadingSpinner.hidesWhenStopped = true
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        return loadingSpinner
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = " "
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = " "
        emailLabel.textAlignment = .center
        emailLabel.textColor = .white
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    lazy var logoutButton: UIButton = {
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = .white
        logoutButton.setTitleColor(NAVBAR_BLUE_COLOR, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        return logoutButton
    }()
    
    let whiteOverlayView: UIView = {
        let whiteOverlayView = UIView()
        whiteOverlayView.backgroundColor = .white
        whiteOverlayView.layer.cornerRadius = 5
        whiteOverlayView.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
        whiteOverlayView.layer.shadowOpacity = 0.8
        whiteOverlayView.layer.shadowRadius = 5.0
        whiteOverlayView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        whiteOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return whiteOverlayView
    }()
    
    let usingAppTitleLabel: UILabel = {
        let usingAppTitleLabel = UILabel()
        usingAppTitleLabel.text = "USING THE APP"
        usingAppTitleLabel.textAlignment = .center
        usingAppTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usingAppTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return usingAppTitleLabel
    }()
    
    let appDescriptionLabel: UITextView = {
        let appDescriptionLabel = UITextView()
        appDescriptionLabel.isEditable = false
        appDescriptionLabel.textAlignment = .center
        appDescriptionLabel.text = "Welcome to the Social Network Feed App! Here you can post images and captions to a global feed for all other users to see and like. \n\nYou can also follow other people and build a following-base. To follow another person, simply tap on their profile picture on one of their posts on the Global Post Feed screen."
        appDescriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return appDescriptionLabel
    }()
    
    // MARK: View Controller Functionality
    
    // Handles loading of the currently logged-in user's profile details
    func loadProfileDetails() {
        loadingSpinner.startAnimating()
        APIService.sharedInstance.returnUserFromId(userID: CURRENT_UID!) { (user) in
            DispatchQueue.main.async {
                self.nameLabel.text = user.name!
                self.emailLabel.text = user.email!
                self.profileImage.downloadImageFromURL(url: user.profileImageURL!, imageType: .profileImage, completionHandler: { 
                    self.loadingSpinner.stopAnimating()
                    self.loadingSpinner.isHidden = true
                })
            }
        }
    }
    
    // Handles the logout of the current user
    func logoutUser() {
        APIService.sharedInstance.logoutUser { (success, error) in
            if error != nil {
                let firebaseError = ErrorHandling.handleFirebaseError(error: error!)
                self.displayFirebaseErrorModal(error: firebaseError)

            }
            
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Error Handling Popups
    
    func displayFirebaseErrorModal(error: (String, String)) {
        let popup = ErrorModal()
        popup.configureModal(errorTitle: error.0, errorDescription: error.1)
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
}

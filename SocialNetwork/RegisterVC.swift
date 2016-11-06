//
//  RegisterVC.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    var loginVCReference: LoginVC?
    
    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupImagePicker()
        setupViewHierarchy()
        setupConstraints()
        setupKeyboardHeightObservation()
        loadingView.isHidden = true
    }
    
    // MARK: View Object Setup
    
    let bgImage: UIImageView = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "bgImage")
        bgImage.clipsToBounds = true
        bgImage.isUserInteractionEnabled = true
        bgImage.contentMode = .scaleAspectFill
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        return bgImage
    }()
    
    let bgImageMask: UIView = {
        let bgImageMask = UIView()
        bgImageMask.backgroundColor = UIColor(white: 0, alpha: 0.5)
        bgImageMask.translatesAutoresizingMaskIntoConstraints = false
        return bgImageMask
    }()
    
    let registerBox: UIView = {
        let loginBox = UIView()
        loginBox.backgroundColor = .white
        loginBox.translatesAutoresizingMaskIntoConstraints = false
        return loginBox
    }()
    
    var registerBoxBottomConstraint: NSLayoutConstraint?
    
    let profileImage: UIView = {
        let profileImage = UIView()
        profileImage.backgroundColor = .white
        profileImage.isUserInteractionEnabled = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    lazy var photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFill
        photoView.layer.masksToBounds = true
        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RegisterVC.displayPickerController)))
        return photoView
    }()
    
    let addPhotoImage: UIImageView = {
        let addPhotoImage = UIImageView()
        addPhotoImage.image = UIImage(named: "add_image_icon")
        addPhotoImage.translatesAutoresizingMaskIntoConstraints = false
        return addPhotoImage
    }()
    
    let nameImage: UIImageView = {
        let nameImage = UIImageView()
        nameImage.image = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
        nameImage.tintColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        nameImage.translatesAutoresizingMaskIntoConstraints = false
        return nameImage
    }()
    
    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    let separatorLineTwo: UIView = {
        let separatorLineTwo = UIView()
        separatorLineTwo.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorLineTwo.translatesAutoresizingMaskIntoConstraints = false
        return separatorLineTwo
    }()
    
    let emailImage: UIImageView = {
        let emailImage = UIImageView()
        emailImage.image = UIImage(named: "email")?.withRenderingMode(.alwaysTemplate)
        emailImage.tintColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        emailImage.translatesAutoresizingMaskIntoConstraints = false
        return emailImage
    }()
    
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email Address"
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()
    
    let separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    let passwordImage: UIImageView = {
        let passwordImage = UIImageView()
        passwordImage.image = UIImage(named: "lock")?.withRenderingMode(.alwaysTemplate)
        passwordImage.tintColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        passwordImage.translatesAutoresizingMaskIntoConstraints = false
        return passwordImage
    }()
    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    lazy var registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.backgroundColor = NAVBAR_BLUE_COLOR
        registerButton.setTitle("CREATE ACCOUNT", for: UIControlState())
        registerButton.setTitleColor(.white, for: UIControlState())
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(RegisterVC.registerNewUser), for: .touchUpInside)
        return registerButton
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Already have an account? Login here.", for: UIControlState())
        loginButton.setTitleColor(.white, for: UIControlState())
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(RegisterVC.displayLoginScreen), for: .touchUpInside)
        return loginButton
    }()
    
    let imagePicker = UIImagePickerController()
    
    let loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    // MARK: View Controller Functionality
    
    // Registering a new user from provided details
    func registerNewUser() {
        guard let email = emailTextField.text, !email.isEmpty else {
            displayErrorModal(errorType: .loginFieldEmpty)
            print("Error getting field data.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            displayErrorModal(errorType: .loginFieldEmpty)
            print("Error getting field data.")
            return
        }
            
        guard let name = nameTextField.text, !name.isEmpty else {
            displayErrorModal(errorType: .loginFieldEmpty)
            print("Invalid values entered...")
            return
        }
        
        guard let image = photoView.image else {
            displayErrorModal(errorType: .registerNoImageSelected)
            print("No image selected...")
            return
        }
        
        loadingView.isHidden = false
        loadingView.loadingLabel.text = "REGISTERING USER"
        loadingView.loadingIndicator.startAnimating()
        
        APIService.sharedInstance.createNewUser(email: email, password: password, name: name, profileImage: image) { (success, error) in
            if success {
                self.loadingView.isHidden = true
                self.loadingView.loadingIndicator.stopAnimating()
                self.dismiss(animated: true, completion: {
                    self.loginVCReference?.displayFeedScreen()
                })
            }
            
            else {
                let firebaseError = ErrorHandling.handleFirebaseError(error: error!)
                self.displayFirebaseErrorModal(error: firebaseError)
            }
        }
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
    
    // Displays the image picker controller
    func displayPickerController() {
        present(imagePicker, animated: true, completion: nil)
    }

    // Displays the login screen
    func displayLoginScreen() {
        let vc = LoginVC()
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    func displayFeedScreen() {
        let vc = TabBar()
        present(vc, animated: true, completion: nil)
    }
}

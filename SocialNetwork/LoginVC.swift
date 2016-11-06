//
//  LoginVC.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()
        setupKeyboardHeightObservation()
        self.loadingView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetFields()
    }
    
    // MARK: View Object Setup
    
    let bgImage: UIImageView = {
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "bgImage")
        bgImage.isUserInteractionEnabled = true
        bgImage.contentMode = .scaleAspectFill
        bgImage.clipsToBounds = true
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        return bgImage
    }()
    
    let darkOverlay: UIView = {
        let darkOverlay = UIView()
        darkOverlay.isUserInteractionEnabled = true
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        darkOverlay.translatesAutoresizingMaskIntoConstraints = false
        return darkOverlay
    }()
    
    let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "sn_logo")?.withRenderingMode(.alwaysTemplate)
        logoImage.tintColor = NAVBAR_BLUE_COLOR
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    let chatHeading: UILabel = {
        let chatHeading = UILabel()
        chatHeading.text = "SOCIAL NETWORK"
        chatHeading.textColor = .white
        chatHeading.font = UIFont.systemFont(ofSize: 30)
        chatHeading.textAlignment = .center
        chatHeading.translatesAutoresizingMaskIntoConstraints = false
        return chatHeading
    }()
    
    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "SEE • POST • CONNECT"
        subtitleLabel.textColor = .white
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    let loginBox: UIView = {
        let loginBox = UIView()
        loginBox.isUserInteractionEnabled = true
        loginBox.backgroundColor = .white
        loginBox.translatesAutoresizingMaskIntoConstraints = false
        return loginBox
    }()
    
    var loginBoxBottomConstraint: NSLayoutConstraint?
    
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
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = NAVBAR_BLUE_COLOR
        loginButton.setTitle("SIGN IN", for: UIControlState())
        loginButton.setTitleColor(.white, for: UIControlState())
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        return loginButton
    }()
    
    lazy var createAnAccountButton: UIButton = {
        let createAnAccountButton = UIButton(type: .system)
        createAnAccountButton.setTitle("Create An Account", for: UIControlState())
        createAnAccountButton.setTitleColor(.white, for: UIControlState())
        createAnAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        createAnAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAnAccountButton.addTarget(self, action: #selector(displaySignupScreen), for: .touchUpInside)
        return createAnAccountButton
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Forgot Password?", for: UIControlState())
        forgotPasswordButton.setTitleColor(.white, for: UIControlState())
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    let loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    // MARK: View Controller Functionality
    
    // Handles logging in of a user after credentials have been provided.
    func loginUser() {
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
        
        loadingView.isHidden = false
        loadingView.loadingLabel.text = "LOGGING IN"
        loadingView.loadingIndicator.startAnimating()
        
        APIService.sharedInstance.loginUser(email: email, password: password) { (success, error) in
            if error != nil {
                self.loadingView.isHidden = true
                self.loadingView.loadingIndicator.stopAnimating()
                let firebaseError = ErrorHandling.handleFirebaseError(error: error!)
                self.displayFirebaseErrorModal(error: firebaseError)
            }
            
            if success {
                self.loadingView.isHidden = true
                self.loadingView.loadingIndicator.stopAnimating()
                self.displayFeedScreen()
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
    
    // MARK: Reset Functionality
    
    // Sends a reset password to the user's provided email
    func handleForgotPassword() {
        guard let email = emailTextField.text else {
            return
        }
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) -> Void in
            if error != nil {
                let firebaseError = ErrorHandling.handleFirebaseError(error: error!)
                self.displayFirebaseErrorModal(error: firebaseError)
            }
        })
    }
    
    // Resets the login fields
    func resetFields() {
        emailTextField.text?.removeAll()
        passwordTextField.text?.removeAll()
    }
    
    // MARK: Displaying Other Screens
    
    // Displays the registration screen
    func displaySignupScreen() {
        let vc = RegisterVC()
        vc.loginVCReference = self
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    // Displays the news feed screen
    func displayFeedScreen() {
        let vc = TabBar()
        present(vc, animated: true, completion: nil)
    }
}

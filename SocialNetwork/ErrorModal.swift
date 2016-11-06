//
//  ErrorModal.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

class ErrorModal: UIViewController {
    
    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupViewHierarchy()
        setupConstraints()
    }
    
    func configureModal(errorTitle: String, errorDescription: String) {
        self.errorTitleLabel.text = errorTitle
        self.errorDescriptionLabel.text = errorDescription
    }
    
    // MARK: View Object Setup
    
    let modalView: UIView = {
        let modalView = UIView()
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 5
        modalView.translatesAutoresizingMaskIntoConstraints = false
        return modalView
    }()
    
    let errorImage: UIImageView = {
        let errorImage = UIImageView()
        errorImage.image = UIImage(named: "error_icon")?.withRenderingMode(.alwaysTemplate)
        errorImage.tintColor = .red
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        return errorImage
    }()
    
    let errorTitleLabel: UILabel = {
        let errorTitleLabel = UILabel()
        errorTitleLabel.text = ""
        errorTitleLabel.font = UIFont.boldSystemFont(ofSize: 23)
        errorTitleLabel.textAlignment = .center
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorTitleLabel
    }()
    
    let errorDescriptionLabel: UILabel = {
        let errorDescriptionLabel = UILabel()
        errorDescriptionLabel.numberOfLines = 0
        errorDescriptionLabel.text = ""
        errorDescriptionLabel.textAlignment = .center
        errorDescriptionLabel.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorDescriptionLabel
    }()
    
    let separatorLine: UIView = {
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        return separatorLine
    }()
    
    lazy var tryAgainButton: UIButton = {
        let tryAgainLabel = UIButton(type: .system)
        tryAgainLabel.setTitle("TRY AGAIN", for: .normal)
        tryAgainLabel.setTitleColor(.red, for: .normal)
        tryAgainLabel.translatesAutoresizingMaskIntoConstraints = false
        tryAgainLabel.addTarget(self, action: #selector(handleTryAgain), for: .touchUpInside)
        return tryAgainLabel
    }()
    
    // MARK: Modal Functionality
    
    // Handles modal dismissal
    func handleTryAgain() {
        dismiss(animated: true, completion: nil)
    }
}

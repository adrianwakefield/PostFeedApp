//
//  FeedVC+IP_Protocols.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

extension FeedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Image Picker Functionality
    
    // Sets up delegate for image picker handling
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    // Handles picking of an image from the image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismiss(animated: true, completion: {
                self.addImageButton.image = chosenImage
            })
        }
    }
}

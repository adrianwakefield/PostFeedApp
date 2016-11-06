//
//  RegisterVC+IP_Protocols.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Image Picker Functionality
    
    // Sets up delegte and relevant properties for image picker functionality
    func setupImagePicker() {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    // Handles choosing of a profile image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            photoView.image = editedImage
        }
            
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            photoView.image = originalImage
        }
        
        addPhotoImage.isHidden = true
        dismiss(animated: true, completion: nil)
    }    
}

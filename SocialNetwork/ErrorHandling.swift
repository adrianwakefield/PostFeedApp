//
//  ErrorHandling.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 3/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import Foundation
import Firebase

struct ErrorHandling {
    
    // Local application errors
    enum ErrorType {
        // Local Error Cases
        case loginFieldEmpty
        case registerNoImageSelected
        case forgotPasswordNoEmailEntered
        case createPostNoCaptionOrImageEntered
        
        // Return Values
        var description: (String, String) {
            switch self {
            case .loginFieldEmpty:
                return ("EMPTY FIELD(S)", "Whoops! You've left one of the fields blank. Please try again.")
            case .registerNoImageSelected:
                return ("NO IMAGE SELECTED", "Whoops! You need to select a profile image in order to register. Please select one.")
            case .forgotPasswordNoEmailEntered:
                return ("NO EMAIL ADDRESS", "Whoops! We can't send a reset link without an email address. Please try again.")
            case .createPostNoCaptionOrImageEntered:
                return ("SOMETHING'S MISSING", "Whoops! Posts must contain both an image and a caption. Please make sure you have selected both and try again.")
            }
        }
    }
    
    // Follow a user potential error cases
    enum FollowUserError {
        case cannotFollowSelf
        case alreadyFollowingUser
    }
    
    // Potential Firebase errors - returns values to be displayed in error popup modal
    static func handleFirebaseError(error: Error) -> (errorTitle: String, errorDescription: String) {
        let firebaseError = error as NSError
        if let errCode = FIRAuthErrorCode(rawValue: firebaseError.code) {
            switch errCode {
            case .errorCodeEmailAlreadyInUse:
                return ("EMAIL ALREADY IN USE", "Whoops! This email address has already been associated with another account. Please use a different email address.")
            case .errorCodeInvalidEmail:
                return ("INVALID EMAIL", "Whoops! Looks like this email address is not valid. Please check it again and try a different one. Emails must be in the form 'user@example.com'.")
            case .errorCodeUserDisabled:
                return ("ACCOUNT DISABLED", "This account has been disabled. This could be for a number of reasons.")
            case .errorCodeUserNotFound:
                return ("NO SUCH ACCOUNT", "Whoops! We couldn't find an account with these provided credentials.")
            case .errorCodeWeakPassword:
                return ("WEAK PASSWORD", "The password you selected isn't that strong. Please choose a longer and more complex password.")
            case .errorCodeWrongPassword:
                return ("WRONG PASSWORD", "The password you provided is not correct. Please try again.")
            case .errorCodeNetworkError:
                fallthrough
            case .errorCodeInternalError:
                fallthrough
            default:
                return ("WHOOPS!", "Looks like something went wrong on our end. Please try again.")
            }
        }
        if let errCode = FIRStorageErrorCode(rawValue: firebaseError.code) {
            switch errCode {
            default:
                return ("WHOOPS", "Looks like something went wrong on our end. Please try again.")
            }
        }
        return ("", "")
    }
    
}

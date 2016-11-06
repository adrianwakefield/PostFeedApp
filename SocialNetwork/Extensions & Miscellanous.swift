//
//  Extensions.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 31/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

// Type of image - used to distinguish which cache the downloaded image is stored in.
enum ImageType {
    case postImage
    case profileImage
}

// Downloads an image from a provided URL and assigns the image to the associated image view
extension UIImageView {
    func downloadImageFromURL(url: String, imageType: ImageType, completionHandler: @escaping () -> ()) {
        self.image = nil
        
        // Firstly check if image is already stored in one of the caches
        if let postCachedImage = postImageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = postCachedImage
            completionHandler()
            return
        }
        
        if let profileCachedImage = profileImageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = profileCachedImage
            completionHandler()
            return
        }
        
        // Image is not in any caches - download from URL and store in relevant cache
        let urlString = URL(string: url)
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            if error != nil {
                print("Error occurred")
                completionHandler()
            }
            
            DispatchQueue.main.async {
                if let newImage = UIImage(data: data!) {
                    if imageType == .postImage {
                        postImageCache.setObject(newImage, forKey: url as AnyObject)
                    }
                    if imageType == .profileImage {
                        profileImageCache.setObject(newImage, forKey: url as AnyObject)
                    }
                    self.image = newImage
                    completionHandler()
                }
            }
        }
        task.resume()
    }
}

// Returns correct timestamp format for feed cell - adapted from: https://gist.github.com/minorbug/468790060810e0d29545
extension Date {
    static func timeAgoSinceDate(timeInterval: TimeInterval, numericDates: Bool) -> String {
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date, to: latest as Date)
        
        if components.year! >= 2 {
            return "\(components.year!) years ago"
        }
            
        else if components.year! >= 1 {
            if numericDates {
                return "1 year ago"
            }
            else {
                return "Last year"
            }
        }
            
        else if components.month! >= 2 {
            return "\(components.month!) months ago"
        }
            
        else if components.month! >= 1 {
            if numericDates {
                return "1 month ago"
            }
            else {
                return "Last month"
            }
        }
            
        else if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!) weeks ago"
        }
            
        else if components.weekOfYear! >= 1 {
            if numericDates {
                return "1 week ago"
            }
            else {
                return "Last week"
            }
        }
            
        else if components.day! >= 2 {
            return "\(components.day!) days ago"
        }
            
        else if components.day! >= 1 {
            if numericDates {
                return "1 day ago"
            }
            else {
                return "Yesterday"
            }
        }
            
        else if components.hour! >= 2 {
            return "\(components.hour!) hours ago"
        }
            
        else if components.hour! >= 1 {
            if numericDates {
                return "1 hour ago"
            }
            else {
                return "An hour ago"
            }
        }
            
        else if components.minute! >= 2 {
            return "\(components.minute!) minutes ago"
        }
            
        else if components.minute! >= 1 {
            if numericDates {
                return "1 minute ago"
            }
            else {
                return "A minute ago"
            }
        }
            
        else if components.second! >= 3 {
            return "\(components.second!) seconds ago"
        }
            
        else {
            return "Just now"
        }
    }
}

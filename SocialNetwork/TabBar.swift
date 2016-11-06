//
//  TabBar.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 30/10/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    // MARK: Initial View Controller Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllers()
        configureTabBar()
    }
    
    // MARK: Tab Bar Setup
    
    // Create view controllers to be added to the tabbar
    func createViewControllers() {
        let feedVC = FeedVC()
        let feedNavVC = UINavigationController(rootViewController: feedVC)
        let tabOneBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed_tabbar_icon"), selectedImage: UIImage(named: "feed_tabbar_icon"))
        feedNavVC.tabBarItem = tabOneBarItem
        
        let followingVC = FollowingVC()
        let followingNavVC = UINavigationController(rootViewController: followingVC)
        let tabThreeBarItem = UITabBarItem(title: "Following", image: UIImage(named: "following_tabbar_icon"), selectedImage: UIImage(named: "following_tabbar_icon"))
        followingNavVC.tabBarItem = tabThreeBarItem
        
        let profileVC = ProfileVC()
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        let tabTwoBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tabbar_icon"), selectedImage: UIImage(named: "profile_tabbar_icon"))
        profileNavVC.tabBarItem = tabTwoBarItem
        
        viewControllers = [feedNavVC, followingNavVC, profileNavVC]
    }
    
    // MARK: Tab Bar Appearance Customisation
    
    func configureTabBar() {
        tabBar.isTranslucent = false
    }

}

//
//  Following+TV_Protocols.swift
//  SocialNetwork
//
//  Created by Adrian Wakefield on 2/11/2016.
//  Copyright © 2016 Adrian Wakefield. All rights reserved.
//

import UIKit

extension FollowingVC {
    
    // MARK: Table View Functionality
    
    // Determines amount of table view cells dependant on how many people the current user is following
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingArray.count
    }
    
    // Configures the following table view cell based on the followee's details
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: followingCellId, for: indexPath) as! FollowCell
        cell.tag = indexPath.row
        cell.configureCell(user: followingArray[indexPath.row])
        return cell
    }
    
    // Determines height of table view following cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

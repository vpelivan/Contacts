//
//  Randomizer.swift
//  Contacts
//
//  Created by Victor Pelivan on 27.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import Foundation
import UIKit

class Randomizer {
    
    private let request = NetworkService.shared
    
    // MARK: - The method creates a separate background view, and performs picture requests and randomization inside a loop in this queue using groups
    func getRandomUsersArray(completion: @escaping ([User])->()) {
        var users = [User]() //users array
        let usersNumber = Int(arc4random_uniform(UInt32(100))) // random number of avaliable users
        var confirmedUsersCounter = 0 //loop counter
        
        let queue = DispatchQueue(label: "Separate background thread", qos: .background) // creating a background queue
        let group = DispatchGroup() // Creating a group
        
        queue.async {
            while confirmedUsersCounter <= usersNumber {
                group.enter()
                var user = User() // when a user var is set, inside an initializer happens part of randomization
                guard let emailHash = user.emailHash, let url = URL(string: "https://www.gravatar.com/avatar/\(emailHash)?s=250") else {group.leave(); continue }
                self.request.getImage(from: url) { (image) in
                    if let image = image {
                        user.image = image
                        users.append(user)
                        confirmedUsersCounter += 1
                    }
                    group.leave()
                }
                group.wait() //all other tasks wait untill the request is being finished and then leave the group
                print(confirmedUsersCounter)
            }
            completion(users)
        }
    }
}

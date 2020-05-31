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
    
    func getRandomUsersArray(completion: @escaping ([User])->()) {
        var users = [User]()
        let usersNumber = Int(arc4random_uniform(UInt32(100)))
        var confirmedUsersCounter = 0
        
        let queue = DispatchQueue(label: "Separate background thread", qos: .background)
        let group = DispatchGroup()
        
        queue.async {
            while confirmedUsersCounter <= usersNumber {
                group.enter()
                var user = User()
                guard let emailHash = user.emailHash, let url = URL(string: "https://www.gravatar.com/avatar/\(emailHash)?s=250") else {group.leave(); continue }
                self.request.getImage(from: url) { (image) in
                    if let image = image {
                        user.image = image
                        users.append(user)
                        confirmedUsersCounter += 1
                    }
                    group.leave()
                }
                group.wait()
                print(confirmedUsersCounter)
            }
            completion(users)
        }
    }
}

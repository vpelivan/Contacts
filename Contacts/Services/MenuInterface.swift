//
//  TableMenu.swift
//  Contacts
//
//  Created by Victor Pelivan on 28.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import Foundation
import UIKit

class MenuInterface: NSObject {
    
    let viewController = UIApplication.shared.windows.first!.rootViewController as! PeopleController
    
    let collectionView: UICollectionView = {
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collView.backgroundColor = .clear
        collView.isSpringLoaded = true
        return collView
    }()
    
    var tableIsEnabled = true
    var users: [User] = [] // Array of Ramdom Users
    var user: User? // selected user
    let randomizer = Randomizer() // Randomizer class
    
    private func setCollectionView() {
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: "tableCell")
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "gridCell")
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        animateMenu()
    }
    
    public func randomizeUsers() {
        randomizer.getRandomUsersArray { (users) in
            DispatchQueue.main.async {
                self.users = users
                self.setCollectionView()
            }
        }
    }
    
    override init() {
        super.init()
        randomizeUsers()
    }
    
    public func animateMenu() {
        let window = UIApplication.shared.windows[0]
        
        window.addSubview(collectionView)
        collectionView.frame = CGRect(x: -1000, y: 90, width: window.frame.width, height: 500)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.collectionView.frame = CGRect(x: 0, y: 90, width: window.frame.width, height: window.frame.height - 170)
        }, completion: nil)
        collectionView.reloadData()
    }
}

extension MenuInterface: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tableIsEnabled {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell", for: indexPath) as! TableCell
            
            cell.label.text = users[indexPath.row].name!
            cell.imageView.image = users[indexPath.row].image
            cell.statusIndicator.isHidden = users[indexPath.row].status!
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridCell
            
            cell.imageView.image = users[indexPath.row].image
            cell.statusIndicator.isHidden = users[indexPath.row].status!
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tableIsEnabled {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: 50, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.user = users[indexPath.row]
    }
    
}

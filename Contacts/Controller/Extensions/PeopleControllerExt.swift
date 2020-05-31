//
//  Extensions.swift
//  Contacts
//
//  Created by Victor Pelivan on 31.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import Foundation
import UIKit

extension PeopleController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
}

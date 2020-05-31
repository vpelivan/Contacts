//
//  GridCell.swift
//  Contacts
//
//  Created by Victor Pelivan on 29.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    override var isSelected: Bool { // Overriding variable to set elements selection color
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.8797182441, green: 0.8797182441, blue: 0.8797182441, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imageView.alpha = isSelected ?  0.5 : 1
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        let frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        imageView.frame = frame
        imageView.layer.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statusIndicator: UIView = {
        let indicator = UIView()
        indicator.layer.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        let frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        indicator.frame = frame
        indicator.layer.cornerRadius = indicator.frame.width / 2
        indicator.layer.borderWidth = 2
        indicator.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        indicator.clipsToBounds = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    func setupViews() {
        addSubview(imageView)
        imageView.addSubview(statusIndicator)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0(<=48)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(<=48)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-31-[v3]-2-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3": statusIndicator]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-31-[v3]-2-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3": statusIndicator]))
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
        statusIndicator.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

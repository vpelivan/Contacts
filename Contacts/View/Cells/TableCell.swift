//
//  CollectionViewCell.swift
//  Contacts
//
//  Created by Victor Pelivan on 28.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import UIKit

class TableCell: UICollectionViewCell {
    
    override var isSelected: Bool { // Overriding variable to set elements selection color
        didSet {
            backgroundColor = isSelected ? #colorLiteral(red: 0.8797182441, green: 0.8797182441, blue: 0.8797182441, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = isSelected ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        let frame = CGRect(x: 0, y: 0, width: 42, height: 42)
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
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inset: UIView = {
       let inset = UIView()
        inset.layer.backgroundColor = #colorLiteral(red: 0.8797182441, green: 0.8797182441, blue: 0.8797182441, alpha: 1)
        let frame = CGRect(x: 0, y: 0, width: 1000, height: 0.3)
        inset.frame = frame
        inset.translatesAutoresizingMaskIntoConstraints = false
        return inset
    }()
    
    func setupViews() {
        addSubview(label)
        addSubview(imageView)
        addSubview(inset)
        imageView.addSubview(statusIndicator)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(<=42)]-[v1]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView, "v1": label]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-3-[v0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v1]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1": label]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2": inset]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-49-[v2]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2": inset]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v3]-2-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3": statusIndicator]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[v3]-2-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3": statusIndicator]))
        
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

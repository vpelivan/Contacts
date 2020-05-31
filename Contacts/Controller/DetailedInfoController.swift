//
//  DetailedInfoController.swift
//  Contacts
//
//  Created by Victor Pelivan on 29.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import TinyConstraints

class DetailedInfoController: UIViewController {

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let image = UIImage(named: "default")
        let imgView = UIImageView(image: image)
        let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        imgView.frame = frame
        imgView.layer.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        return imgView
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Name Label"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    let statusLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Status Label"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    let emailLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .link
        label.textAlignment = .center
        label.text = "Email Label"
        label.font = UIFont.systemFont(ofSize: 27)
        return label
    }()
    
    var user: User! // User Info passed using segue from People Controller
    let request = NetworkService.shared // For Image Requests
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchData()
    }
    
    //MARK: Selector Function performing unwind segue when tapping on "Back" button
    @objc func tapButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToPeopleController", sender: nil)
    }
    
    //MARK: The method sets constraints and adds elements to screen
    private func setupViews() {
        view.addSubview(button)
        button.edgesToSuperview(excluding: [.bottom, .right], insets: .top(10) + .left(0), usingSafeArea: true)
        button.height(30)
        button.width(100)
        
        view.addSubview(imageView)
        imageView.centerInSuperview(offset: CGPoint(x: 0, y: -100), usingSafeArea: true)
        imageView.height(300)
        imageView.width(300)
        
        view.addSubview(nameLabel)
        nameLabel.centerInSuperview(offset: CGPoint(x: 0, y: 80), usingSafeArea: true)
        nameLabel.height(35)
        nameLabel.width(300)
        
        view.addSubview(statusLabel)
        statusLabel.centerInSuperview(offset: CGPoint(x: 0, y: 120), usingSafeArea: true)
        statusLabel.height(20)
        statusLabel.width(100)
        
        view.addSubview(emailLabel)
        emailLabel.centerInSuperview(offset: CGPoint(x: 0, y: 160), usingSafeArea: true)
        emailLabel.height(30)
        emailLabel.width(350)
    }
    
    //MARK: This Method performs bigger size image request and fetches all user data
    private func fetchData() {
        guard let emailHash = user.emailHash, let url = URL(string: "https://www.gravatar.com/avatar/\(emailHash)?s=500") else { return }
        request.getImage(from: url) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        nameLabel.text = user.name
        statusLabel.text = user.status ? "offline" : "online"
        emailLabel.text = user.nickName + user.emailServer
    }
}

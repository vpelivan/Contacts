//
//  ViewController.swift
//  Contacts
//
//  Created by Victor Pelivan on 26.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import SwiftHash
import TinyConstraints

class PeopleController: UIViewController {
    
    let segmentedControl: UISegmentedControl = {
        let items = ["List", "Grid"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeMenuView(_:)), for: .valueChanged)
        return control
    }()
    
    let collectionView: UICollectionView = {
        let collView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collView.backgroundColor = .clear
        collView.isSpringLoaded = true
        return collView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .clear
        button.setTitle("Simulate Changes", for: .normal)
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let randomizer = Randomizer() // Randomizer Class
    var tableIsEnabled = true
    var users: [User] = [] // Array of Ramdom Users
    var user: User? // selected user

    override func viewDidLoad() {
        super.viewDidLoad()
        randomizeUsers()
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        animateMenu()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dic = segue.destination as? DetailedInfoController else { return }
        dic.user = user
    }

    
    @objc func tapButton(_ sender: UIButton) {
        randomizeUsers()
    }
    
    @objc func changeMenuView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tableIsEnabled = true
            animateMenu()
        case 1:
            tableIsEnabled = false
            animateMenu()
        default:
            break
        }
    }
    
    private func setCollectionView() {
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: "tableCell")
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "gridCell")
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        animateMenu()
    }
    
    private func randomizeUsers() {
        randomizer.getRandomUsersArray { (users) in
            DispatchQueue.main.async {
                self.users = users
                self.setCollectionView()
            }
        }
    }
    
    private func animateMenu() {
        let window = UIApplication.shared.windows[0]
        
        window.addSubview(collectionView)
        collectionView.frame = CGRect(x: -1000, y: 90, width: window.frame.width, height: 500)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.collectionView.frame = CGRect(x: 0, y: 90, width: window.frame.width, height: window.frame.height - 170)
        }, completion: nil)
        collectionView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(segmentedControl)
        view.addSubview(button)
        segmentedControl.height(30)
        segmentedControl.width(200)
        segmentedControl.centerXToSuperview()
        segmentedControl.edgesToSuperview(excluding: [.bottom, .left, .right], insets: .top(10),  usingSafeArea: true)
        button.edgesToSuperview(excluding: [.top, .left, .right], insets: .bottom(10), usingSafeArea: true)
        button.height(30)
        button.width(170)
        button.centerXToSuperview()
    }
    
    @IBAction func unwindToPeopleController(_ unwindSegue: UIStoryboardSegue) {
    }
    
}

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
    
    let menuInterface = MenuInterface()
    let randomizer = Randomizer()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["List", "Grid"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeMenuView(_:)), for: .valueChanged)
        return control
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        menuInterface.animateMenu()
    }
    
    @objc func tapButton(_ sender: UIButton) {
        menuInterface.randomizeUsers()
    }
    
    @objc func changeMenuView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            menuInterface.tableIsEnabled = true
            menuInterface.animateMenu()
        case 1:
            menuInterface.tableIsEnabled = false
            menuInterface.animateMenu()
        default:
            break
        }
    }
    
    private func setupViews() {
        view.addSubview(segmentedControl)
        view.addSubview(button)
        segmentedControl.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 8, left: 100, bottom: 0, right: 100),  usingSafeArea: true)
        button.edgesToSuperview(excluding: .top, insets: UIEdgeInsets(top: 10, left: 100, bottom: 10, right: 100), usingSafeArea: true)
        segmentedControl.height(30)
        segmentedControl.width(200)
        button.height(30)
        button.width(200)
    }
    
    @IBAction func unwindToPeopleController(_ unwindSegue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dic = segue.destination as? DetailedInfoController else { return }
        dic.user = menuInterface.user
    }
    
    
}


//
//  TabBar.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    private var feedVC: NewsFeedVC = {
        let vc = NewsFeedVC()
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return vc
    }()
    
    private var readVC: ReadLaterVC = {
        let vc = ReadLaterVC()
        vc.tabBarItem = UITabBarItem(title: "Read Later", image: UIImage(systemName: "folder"), tag: 1)
        return vc
    }()
    
    private var settingVC: SettingsVC = {
        let vc = SettingsVC()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feedVC, readVC, settingVC]
    }
}

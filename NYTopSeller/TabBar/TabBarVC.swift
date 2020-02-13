//
//  TabBar.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarVC: UITabBarController {
    
    private var dataPersistence = DataPersistence<Article>(filename: "articles.plist")
    
    private lazy var feedVC: NewsFeedVC = {
        let vc = NewsFeedVC(dataPersistence: dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return vc
    }()
    
    private lazy var readVC: ReadLaterVC = {
        let vc = ReadLaterVC(dataPersistence: dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Read Later", image: UIImage(systemName: "folder"), tag: 1)
        return vc
    }()
    
    private lazy var settingVC: SettingsVC = {
        let vc = SettingsVC()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feedVC, readVC, settingVC]
    }
}

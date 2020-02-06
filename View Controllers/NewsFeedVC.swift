//
//  NewsFeedVC.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    private var feedView = NewsFeedView()
    
    override func loadView() {
        view = feedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

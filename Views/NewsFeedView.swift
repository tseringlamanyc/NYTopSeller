//
//  NewsFeedView.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class NewsFeedView: UIView {
    
    public lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search for articles"
        return searchBar
    }()
    
    override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
    super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}

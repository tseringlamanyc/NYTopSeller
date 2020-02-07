//
//  DetailView.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/7/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Abstract"
        return label
    }()
    
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "By"
        return label
    }()
    
    public lazy var dateLine: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Date"
        return label
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
        setupImage()
        setupAbstract()
        setupBy()
    }
    
    private func setupImage() {
        addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            newsImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newsImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newsImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func setupAbstract() {
        addSubview(abstractLabel)
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8),
            abstractLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            abstractLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupBy() {
        addSubview(byLine)
        byLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            byLine.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            byLine.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ])
    }
    
}

//
//  FeedCell.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/7/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // image, title, abstract
    
    public lazy var newsImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemYellow
        return imageView
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
    }
    
    private func setupImage() {
        addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsImage.heightAnchor.constraint(equalTo: heightAnchor, constant: 0.20),
            newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor)
        ])
    }
    
}

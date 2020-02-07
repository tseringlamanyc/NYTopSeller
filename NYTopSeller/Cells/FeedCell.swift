//
//  FeedCell.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/7/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit

class FeedCell: UICollectionViewCell {
    
    // image, title, abstract
    
    public lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article"
        return label
    }()
    
    public lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract"
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
        setupArticleTitle()
        setupAbstract()
    }
    
    private func setupImage() {
        addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60),
            newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor)
        ])
    }
    
    private func setupArticleTitle() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: newsImage.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupAbstract() {
        addSubview(abstractLabel)
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractLabel.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8),
            abstractLabel.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstractLabel.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor)
        ])
    }
    
    public func updateUI(article: Article) {
        newsImage.getImage(with: article.getImageURL(imageFormat: .thumbLarge)) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("no picture")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.newsImage.image = image
                }
            }
        }
        
        articleTitle.text = article.title
        abstractLabel.text = article.abstract
    }
    
}

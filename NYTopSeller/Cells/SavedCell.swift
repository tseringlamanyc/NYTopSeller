//
//  SavedCell.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/10/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

protocol SavedCellDelegate: AnyObject {
    func didSelectButton(cell: SavedCell, article: Article)
}

class SavedCell: UICollectionViewCell {
    
    private var currentArticle: Article!
    
    weak var delegate: SavedCellDelegate?
    
    private lazy var longPress: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(gesture:)))
        return gesture
    }()
    
    // more button
    // article title
    // news image
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Article title"
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "gear")
        iv.alpha = 0 
        return iv
    }()
    
    private var isImageThere = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupButton()
        setupLabel()
        setupImage()
        addGestureRecognizer(longPress)
    }
    
    @objc
    private func buttonPressed(sender: UIButton) {
        print("\(currentArticle.title)")
        delegate?.didSelectButton(cell: self, article: currentArticle)
    }
    
    @objc
    private func didLongPress(gesture: UILongPressGestureRecognizer) {
        guard let currentArticle = currentArticle else {
            fatalError()
        }
        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
        isImageThere.toggle()
        
        imageView.getImage(with: currentArticle.getImageURL(imageFormat: .normal)) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("nope")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    self?.animate()
                }
            }
        }
    }
    
    private func animate() {
        let duration: Double = 1.0
        if isImageThere {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.imageView.alpha = 1.0
                self.articleLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.imageView.alpha = 0.0
                self.articleLabel.alpha = 1.0
            }, completion: nil)
        }
    }
    
    private func setupButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.widthAnchor)
        ])
    }
    
    private func setupLabel() {
        addSubview(articleLabel)
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleLabel.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupImage() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func updateUI(article: Article) {
        currentArticle = article
        articleLabel.text = article.title
    }
}

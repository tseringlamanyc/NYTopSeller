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
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Article title"
        label.numberOfLines = 0
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
        setupButton()
        setupLabel()
    }
    
    @objc
    private func buttonPressed(sender: UIButton) {
        print("\(currentArticle.title)")
        delegate?.didSelectButton(cell: self, article: currentArticle)
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
    
    public func updateUI(article: Article) {
        currentArticle = article
        articleLabel.text = article.title
    }
}

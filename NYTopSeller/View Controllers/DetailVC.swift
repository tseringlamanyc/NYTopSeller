//
//  DetailVC.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/7/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class DetailVC: UIViewController {
    
    public var article: Article?
    
    private var detailView = DetailView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane.fill"), style: .plain, target: self, action: #selector(saveArticle(sender:)))
        updateUI()
    }
    
    private func updateUI() {
        guard let article = article else {
            fatalError()
        }
        navigationItem.title = article.title
        detailView.newsImage.getImage(with: article.getImageURL(imageFormat: .superJumbo)) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("no picture")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.newsImage.image = image
                }
            }
        }
        detailView.abstractLabel.text = article.abstract
    }
    
    @objc
    private func saveArticle(sender: UIBarButtonItem) {
        guard let article = article else {
            fatalError()
        }
        do {
            try dataPersistence.createItem(article) 
        } catch {
            print("couldnt save")
        }
    }
}


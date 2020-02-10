//
//  NewsFeedVC.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedVC: UIViewController {
    
    private var feedView = NewsFeedView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    override func loadView() {
        view = feedView
    }
    
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.feedCV.reloadData()
            }
        }
    }
    
    private var sectionName = "Technology" {
        didSet {
            hitAPI(section: sectionName)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        feedView.feedCV.dataSource = self
        feedView.feedCV.delegate = self
        feedView.feedCV.register(FeedCell.self, forCellWithReuseIdentifier: "feedCell")
        feedView.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchStories()
    }
    
    private func fetchStories(string: String = "Technology") {
        if let sectionName = UserDefaults.standard.object(forKey: Userkey.sectionName) as? String {
            if sectionName != self.sectionName {
                // if technology != technology
                // new search
                hitAPI(section: sectionName)
                self.sectionName = sectionName
            } else {
               hitAPI(section: sectionName)
            }
        } else {
            // use the default name
            hitAPI(section: sectionName)
        }
    }
    
    private func hitAPI(section: String) {
        NYTimesAPI.getTopStories(section: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let articles):
                self?.newsArticles = articles
            }
        }
    }
}

extension NewsFeedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            fatalError()
        }
        let aNews = newsArticles[indexPath.row]
        cell.backgroundColor = .systemBackground
        cell.updateUI(article: aNews)
        return cell
    }
}

extension NewsFeedVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let maxSize = UIScreen.main.bounds.size
           let itemHeight: CGFloat = maxSize.height * 0.20
           let itemWidth: CGFloat = maxSize.width
           return CGSize(width: itemWidth, height: itemHeight)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        let detailVC = DetailVC()
        detailVC.article = article
        detailVC.dataPersistence = dataPersistence
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if feedView.searchBar.isFirstResponder {
            feedView.searchBar.resignFirstResponder()
        }
    }
}

extension NewsFeedVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            fetchStories()
            return
        }
        newsArticles = newsArticles.filter {$0.title.lowercased().contains(searchText.lowercased())}
    }
}

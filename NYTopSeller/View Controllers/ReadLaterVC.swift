//
//  ReadLaterVC.swift
//  NYTopSeller
//
//  Created by Tsering Lama on 2/6/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class ReadLaterVC: UIViewController {
    
    // step 4: setting up data persistence and its delegate
    private var dataPersistence: DataPersistence<Article>
    
    init(dataPersistence: DataPersistence<Article>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.dataPersistence.delegate = self 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init couldnt be implemented")
    }
    
    private let savedView = SavedView()
    
    override func loadView() {
        view = savedView
    }
    
    // TODO: create a SavedArticleView
    // TODO: add a collection view to the SavedArticleView
    // TODO: collection view is vertical with 2 cells per row
    // TODO: add SavedArticleView to SavedArticleViewController
    // TODO: create an array of savedArticle = [Article]
    // TODO: reload collection view in didSet of savedArticle array
    
    private var savedArticles = [Article]() {
        didSet {
            print("there are \(savedArticles.count) articles")
            savedView.collectionView.reloadData()
            if savedArticles.isEmpty {
                savedView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "No saved articles")
            } else {
                savedView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        savedView.collectionView.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
        dataPersistence.delegate = self
        savedView.collectionView.dataSource = self
        savedView.collectionView.delegate = self
        fetchSavedArticles()
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        } catch {
            print("error fetching articles: \(error)")
        }
    }
}

// step 5: setting up data persistence and its delegate
// conforming to the DataPersistenceDelegate
extension ReadLaterVC: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("items was saved")
        fetchSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("items was deleted")
        fetchSavedArticles()
    }
}

extension ReadLaterVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight: CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

extension ReadLaterVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError()
        }
        let aArticle = savedArticles[indexPath.row]
        cell.updateUI(article: aArticle)
        cell.delegate = self
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // setup segue
        let aArticle = savedArticles[indexPath.row]
        let detailVC = DetailVC(dataPersistence: dataPersistence, article: aArticle)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ReadLaterVC: SavedCellDelegate {
    func didSelectButton(cell: SavedCell, article: Article) {
        print("new: \(article.title)")
        
        // create action sheet (delete and cancel)
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
            // need a helper function to delete 
            self.deleteArticle(article: article)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteArticle(article: Article) {
        guard let index = savedArticles.firstIndex(of: article) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("couldnt delete article")
        }
    }
}

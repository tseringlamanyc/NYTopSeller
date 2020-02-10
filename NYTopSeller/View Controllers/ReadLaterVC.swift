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
  public var dataPersistence: DataPersistence<Article>!
    
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
        self.savedView.collectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
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
    print("ites was deleted")
  }
}

extension ReadLaterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

extension ReadLaterVC: UICollectionViewDelegateFlowLayout {
    
}

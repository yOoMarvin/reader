//
//  ArticleCollectionViewController.swift
//  reader
//
//  Created by Marvin Messenzehl on 28.02.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ArticleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var articles = [Article]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        let rssResource = RSSResource()
        rssResource.processFeed { (articles) in
            self.articles = articles
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return articles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = articles[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as! ArticleCollectionViewCell
        // Configure the cell
        cell.titleLabel.text = article.title
        
        //TODO: Download picture
    
        return cell
    }

    
    
    
    // MARK: Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let columns = 2
        let gaps = 1
        
        let tmpWidth = width - CGFloat(gaps)
        let itemWidth = tmpWidth / CGFloat(columns)
        let itemHeight = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    
}

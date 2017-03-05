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
    
    let rssResource = RSSResource()
    var articles = [Article]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        rssResource.processFeed { (articles) in
            self.articles = articles
        }
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        if segue.identifier == "showDetail" {
            let dstCtrl = segue.destination as! DetailViewController
            dstCtrl.currentArticle = articles[indexPath.row]
        }
    }
 
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: indexPath)
    }

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
        
        //image call
        rssResource.fetchImage(url: article.imageUrl) {
            (image:UIImage) in
            
            cell.imageView.image = image
        }
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(1)
    }
    
    
    
    
    
}

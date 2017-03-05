//
//  DetailViewController.swift
//  reader
//
//  Created by Marvin Messenzehl on 05.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    var currentArticle: Article?
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentArticle = currentArticle else {
            print("not article set")
            return
        }
        
        guard let url = URL(string: currentArticle.url) else {
            print("error in url: \(currentArticle.url)")
            return
        }
        
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }


}

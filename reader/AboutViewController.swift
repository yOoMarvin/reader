//
//  AboutViewController.swift
//  reader
//
//  Created by Marvin Messenzehl on 06.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func didTapLink(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://www.github.com/yoomarvin")!)
    }

   
}

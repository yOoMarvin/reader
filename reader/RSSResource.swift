//
//  RSSResource.swift
//  reader
//
//  Created by Marvin Messenzehl on 02.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import Foundation

class RSSResource: NSObject {
    
    var articleList = [Article]()
    
    //tmp helper
    var currentArticle = Article()
    var currentImageUrl = ""
    var parsedElement = ""
    
    var completionHandler: ((_ articles:[Article]) -> ())?
    
    func processFeed(completion: @escaping (_ articles:[Article]) -> ()) {
        self.completionHandler = completion
        
        
    }
}

// MARK: RSS Extension

extension RSSResource: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //item name of rss feed from codingtutor.de
        //at "item" a new entry begins
        if elementName == "item" {
            currentArticle = Article()
            currentImageUrl = ""
            return
        }
        
        //called when item is processing. check what to process
        if elementName == "title" {
            parsedElement = "title"
        }
        
        if elementName == "link" {
            parsedElement = "link"
        }
        
        //care: this is an attribut. Not a value between tags
        if elementName == "media:content"{
            if let url = attributeDict["url"] {
                currentImageUrl = url
            }
        }
        
    }
    
    //called inside of the element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //cut whitespaces
        let str = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if parsedElement == "title" {
            currentArticle.title += str
        }
        if parsedElement == "link" {
            currentArticle.url += str
        }
    }
    
    //called on end of item
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName != "item" {
            return
        }
        
        //image url must be set here, because it is an attribute. Will never be called in foundCharacters function
        currentArticle.imageUrl = currentImageUrl
        articleList.append(currentArticle)
    }
    
    //called on end of document
    func parserDidEndDocument(_ parser: XMLParser) {
        
        DispatchQueue.main.async {
            if let completionHandler = self.completionHandler {
                completionHandler(self.articleList)
            }
        }
    }
}

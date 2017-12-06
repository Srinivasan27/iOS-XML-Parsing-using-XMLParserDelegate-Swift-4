//
//  XMLParser.swift
//  XML Parsing Demo
//
//  Created by Guest User on 12/6/17.
//  Copyright © 2017 Peakaeriest Technologies. All rights reserved.
//

import Foundation

struct ITunesTopTen {
    var title: String
    var link: String
    var description : String
    var pubDate : String
}


class FeedParser: NSObject, XMLParserDelegate {
    private var iTunesItems : [ITunesTopTen] = []
    
    // Reach to destinated Tag Here i.e item in feed
    private var currentElement = ""
    private var parseTitle = ""
    private var parseDescription = ""
    private var parseLink = ""
    private var parsePubDate = ""
    
    //Create Completion Handler
    private var parseCompletionHandler :(([ITunesTopTen])->Void)?
    
    //Func To download and Parse XML
    func parserFeed(url : String, completionHandler : (([ITunesTopTen])-> Void)?){
        self.parseCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            // Check data is !nil
            guard let data = data else{
                if let error = error{
                    print(error.localizedDescription)
                }
                return
            }
            
            // Parse XML Data
            let parser = XMLParser(data:data)
            parser.delegate = self
            parser.parse()
            
        }
        
        task.resume()
    }
    
    //MARK: - XMLParser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            parseTitle = ""
            parseLink = ""
            parseDescription = ""
            parsePubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": parseTitle += string
        case "link": parseLink += string
        case "description" : parseDescription += string
        case "pubDate" : parsePubDate += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let iTunes = ITunesTopTen(title: parseTitle, link: parseLink, description: parseDescription, pubDate: parsePubDate)
            
            iTunesItems.append(iTunes)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parseCompletionHandler?(iTunesItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}









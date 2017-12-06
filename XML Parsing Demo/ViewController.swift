//
//  ViewController.swift
//  XML Parsing Demo
//
//  Created by Guest User on 12/6/17.
//  Copyright © 2017 Peakaeriest Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iTunesTableView: UITableView!
    private var rssItems: [ITunesTopTen]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        iTunesTableView.estimatedRowHeight = 200
        iTunesTableView.rowHeight = UITableViewAutomaticDimension
        
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let feedParser = FeedParser()
        
        feedParser.parserFeed(url: "http://ax.itunes.apple.com/WebObjects/MZStore.woa/wpa/MRSS/justadded/limit=10/rss.xml") { (rssItems) in
            self.rssItems = rssItems

            
            OperationQueue.main.addOperation {
                self.iTunesTableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        
        // rssItems
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ITunesTableViewCell
        if let item = rssItems?[indexPath.item] {
            cell.items = item
            cell.selectionStyle = .none
        }
        return cell
    }

}



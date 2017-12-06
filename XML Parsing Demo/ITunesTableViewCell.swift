//
//  ITunesTableViewCell.swift
//  XML Parsing Demo
//
//  Created by Guest User on 12/6/17.
//  Copyright © 2017 Peakaeriest Technologies. All rights reserved.
//

import UIKit

class ITunesTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var pubDate: UILabel!
    
    @IBOutlet weak var link: UILabel!
    
    @IBOutlet weak var desc: UILabel!{
        didSet{
            desc.numberOfLines = 4
        }
    }
    
    
    var items : ITunesTopTen!{
        didSet{
            title.text = items.title
            link.text = items.link
            pubDate.text = items.pubDate
            desc.text  = items.description
        }
    }
    
}

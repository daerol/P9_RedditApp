//
//  News.swift
//  P9_NewsApp
//
//  Created by ITP312 on 23/5/17.
//  Copyright © 2017 ITP312. All rights reserved.
//

import UIKit

class News: NSObject {
    
    var contentSnippet : String
    var link : String
    var title : String
    var url : String
    
    init(content: String, link: String, title: String, url: String) {
        self.contentSnippet = content
        self.link = link
        self.title = title
        self.url = url
        
        super.init()
    }

}

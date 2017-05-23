//
//  DetailsViewController.swift
//  P9_NewsApp
//
//  Created by ITP312 on 23/5/17.
//  Copyright © 2017 ITP312. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var webView : UIWebView!
    @IBOutlet weak var msgLabel : UILabel!
    
    
    var newsURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.isHidden = true
        msgLabel.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(newsURL != nil)
        {
            // If the newsURL is set by the first view controller
            // then ask the webView to load and display that URL.
            let req = URLRequest(url: newsURL!)
            webView.loadRequest(req)
            
            webView.isHidden = false
            msgLabel.isHidden = true
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

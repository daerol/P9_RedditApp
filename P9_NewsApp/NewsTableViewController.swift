//
//  NewsTableViewController.swift
//  P9_NewsApp
//
//  Created by ITP312 on 23/5/17.
//  Copyright © 2017 ITP312. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var newsList : [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeed("iphone")
    }
    
    func loadFeed(_ subreddit: String)
    {
        // Queue an asynchronous task on the background thread,
        // so that viewDidLoad will end immediately, while the
        // task programmed inside the dispatch will run at a
        // later time.
        //
        NewsDataManager.loadNews(subreddit: subreddit, onComplete:
            {
                newsListDownloadedFromReddit in
                // Set the news list downloaded from Reddit
                // to our own newsList variable.
                //
                self.newsList = newsListDownloadedFromReddit
                
                DispatchQueue.main.async {
                    // Tells the tableView to refresh itself.
                    //
                    // Since we are updating the user interface,
                    // we use DispatchQueue.main.async to
                    // instruct iOS to call reloadData in the // main worker thread.
                    //
                    self.tableView.reloadData()
                }
        })
    }

    
    // One of the functions for UITableViewDataSource.
    // Tells the table view how mamy sections there are.
    // In our case, there's only 1 section
    
    override func numberOfSections(in tableView: UITableView)
        -> Int
    {
        return 1;
    }
    
    // One of the functions for UITableViewDataSource.
    // Tells the table view how many items in the given section.
    // Since we have only 1 section, this function will only be
    // called once by the tableView where the section = 1.
    // So we just return the number of items in the newsList array.
    //
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return self.newsList.count;
    }
    // One of the functions for UITableViewDataSource.
    // Creates or reuses a UITableViewCell with the data at the
    // row position and returns it.
    //
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(
                withIdentifier: "Cell",
                for: indexPath)
        let news = newsList[indexPath.row]
        cell.textLabel!.text = news.title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the news at the selected row
        let selectedNews = newsList[indexPath.row]
        
        // we load an instance of the view controller
        // from the storyboard with the id "idDetailsViewController"
        //
        
        let detailsViewController = UIStoryboard(name: "Main",
                                                 bundle: nil) .instantiateViewController(withIdentifier:
                                                    "idDetailsViewController")
            as! DetailsViewController
        
        // Set the newsURL.
        
        detailsViewController.newsURL =
            URL(string: selectedNews.link)
        
        // Show the view controller of the detail screen.
        self.showDetailViewController(detailsViewController, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    


}

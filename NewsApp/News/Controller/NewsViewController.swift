//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [Article]()
    var networkNewsManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkNewsManager.performRequest(with: NewsEndpoint.getNews) { (newsData) in
            self.news = newsData.articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let new = news[indexPath.row]
        cell.configure(with: new)
        
        return cell
    }
}


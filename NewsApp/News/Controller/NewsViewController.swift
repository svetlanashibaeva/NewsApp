//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var news = [Article]()
    var networkNewsManager = NetworkManager()
    var page = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        loadData()
    }
    
    @objc func refresh() {
        guard !isLoading else { return }
        page = 1
        loadData()
    }
    
    func loadData() {
        isLoading = true
        
        networkNewsManager.performRequest(with: NewsEndpoint.getNews(page: page)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(newsData):
                self.news += newsData.articles
                self.page += 1
                
            case let .failure(error):
                DispatchQueue.main.async {
                    self.showError(error: error.localizedDescription)
                }
            }
            
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    self.isLoading = false
                }
        }
    }
    
    func showError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        
        alertController.addAction(errorAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isLoading else { return }
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - scrollView.contentOffset.y <= 0 {
            loadData()
        }
    }
    
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


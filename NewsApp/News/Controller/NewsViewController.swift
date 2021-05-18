//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import UIKit
import SafariServices

// нажатие на ячейку, открытие новости в сафари через Safari services; сохранение новостей в кордату; привести юай в порядок

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var news = [Article]()
    private var networkNewsManager = NetworkManager()
    private var page = 1
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = activityIndicator
        
        loadData()
    }
    
    @objc private func refresh() {
        guard !isLoading else { return }
        page = 1
        loadData()
    }
    
    private func loadData() {
        isLoading = true
        activityIndicator.startAnimating()
        
        networkNewsManager.performRequest(with: NewsEndpoint.getNews(page: page)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(articles):
                if self.page == 1 {
                    self.news = articles
                } else {
                    self.news += articles
                }
                self.page += 1
                
            case let .failure(error):
                DispatchQueue.main.async {
                    self.showError(error: error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.isLoading = false
            }
        }
    }
    
    private func showError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(errorAction)
        
        present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pth = news[indexPath.row].url else { return }
        guard let url = URL(string: pth) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
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
        let article = news[indexPath.row]
        cell.configure(with: article)
    
        return cell
    }
}


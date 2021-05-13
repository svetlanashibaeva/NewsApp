//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var apiKey = "b987156c920e4c88a5e02b4f4892b34c"
    
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        news.append(News(title: "new2", description: "kkfkgjkfjkgjfkjgkfjgkjfkjgk"))
        news.append(News(title: "new3", description: "kkfkgjfdfdfdfdfdfdfdfkfjkgjfkjgkfjgkjfkjgk"))
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


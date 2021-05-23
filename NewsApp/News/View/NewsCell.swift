//
//  NewsCell.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(with news: News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.descr
        setImage(urlToImage: news.urlToImage)
    }
    
    private func setImage(urlToImage: String?) {
        guard let urlToImage = urlToImage else {
            return
        }
        let url = URL(string: urlToImage)
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: url)
        newsImage.kf.setImage(with: url,
                              placeholder: UIImage(named: "default-image.jpg"))
    }
}

//
//  NewsCell.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(with new: Article) {
        titleLabel.text = new.title
        descriptionLabel.text = new.description
        loadImage(urlString: new.urlToImage)
    }
    
    private func loadImage(urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.newsImage.image = image
                    }
                }
            }
        }
    }
}

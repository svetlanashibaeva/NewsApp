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
    
    func configure(with new: Article) {
        titleLabel.text = new.title
        descriptionLabel.text = new.description
    }
    
}

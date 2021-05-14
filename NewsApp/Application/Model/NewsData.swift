//
//  NewsData.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import Foundation

struct NewsData: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
}


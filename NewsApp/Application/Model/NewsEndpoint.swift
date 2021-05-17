//
//  NewsEndpoint.swift
//  NewsApp
//
//  Created by Света Шибаева on 14.05.2021.
//

import Foundation

enum NewsEndpoint: EndpointProtocol {
    case getNews(page: Int)
    
    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        return "/v2/everything"
    }
    
    var params: [String : String] {
        switch self {
        case let .getNews(page):
            return ["q": "tesla",
                    "page": "\(page)",
                    "apiKey":"009bf23be7fa455095ae15b261ac5e0a"]
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}

//
//  NewsEndpoint.swift
//  NewsApp
//
//  Created by Света Шибаева on 14.05.2021.
//

import Foundation

enum NewsEndpoint: EndpointProtocol {
    case getNews
    
    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        return "/v2/everything"
    }
    
    var params: [String : String] {
        return ["q": "tesla",
                "apiKey":"b987156c920e4c88a5e02b4f4892b34c"]
    }
    
    var headers: [String : String] {
        return [:]
    }
}

//
//  EndpointProtocol.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import Foundation

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [String: String] { get }
    var headers: [String: String] { get }
}

extension EndpointProtocol {
    var scheme: String {
        return "https"
    }
}

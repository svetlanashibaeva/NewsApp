//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import Foundation

class NetworkManager {

    func performRequest(with endpoint: EndpointProtocol, completion: @escaping ((NewsData) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = urlComponents.url else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let newsData = self.parseJSON(withData: data) {
                    completion(newsData)
                }
            }
        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> NewsData? {
        let decoder = JSONDecoder()
        
        do {
            let newsData = try decoder.decode(NewsData.self, from: data)
            return newsData
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return nil
    }
}





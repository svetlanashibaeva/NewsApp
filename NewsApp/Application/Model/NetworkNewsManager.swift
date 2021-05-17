//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Света Шибаева on 13.05.2021.
//

import Foundation

class NetworkManager {

    func performRequest(with endpoint: EndpointProtocol, completion: @escaping ((Result<NewsData, Error>) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        guard let url = urlComponents.url else { return completion(Result.failure(MyError.urlError)) }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let newsData = self.parseJSON(withData: data) {
                    completion(Result.success(newsData))
                } else {
                    completion(Result.failure(MyError.parseError))
                }
            } else if let error = error {
                completion(Result.failure(error))
            } else {
                completion(Result.failure(MyError.unkmownError))
            }
        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> NewsData? {
        let decoder = JSONDecoder()
            return try? decoder.decode(NewsData.self, from: data)
    }
}





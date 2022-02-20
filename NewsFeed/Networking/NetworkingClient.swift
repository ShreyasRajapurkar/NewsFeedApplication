//
//  NetworkingClient.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 01/01/22.
//

import Foundation

protocol Resource {
    var scheme: String { get }
    var relativePath: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: String { get }
}

class NewsArticlesResource: Resource {
    var scheme: String = "https"
    var relativePath: String = "/newsapi.org/v2/top-headlines"
    var queryItems: [URLQueryItem]
    var httpMethod: String = "GET"
    
    init(queryItems: [URLQueryItem]) {
        self.queryItems = queryItems
    }
}

class NewsChannelsResource: Resource {
    var scheme: String = "https"
    var relativePath: String = "/newsapi.org/v2/top-headlines/sources"
    var queryItems: [URLQueryItem]
    var httpMethod: String = "GET"
    
    init(queryItems: [URLQueryItem]) {
        self.queryItems = queryItems
    }
}

class NetworkingClient {
    // Storing the API key like this is unsecure, only doing this temporarily for the sake of the assignment
    static let APIKey = "dbb372a6a28d4a44a569002574f8fb2a"

    public static func performRequest<T: Decodable>(resource: Resource, completion: @escaping (Result<T, Error>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = resource.scheme
        urlComponents.path = resource.relativePath
        urlComponents.queryItems = resource.queryItems

        guard let url = urlComponents.url else {
            print("Unable to construct URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod
    
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}

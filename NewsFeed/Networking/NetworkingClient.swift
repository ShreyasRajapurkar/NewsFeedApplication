//
//  NetworkingClient.swift
//  Assignment
//
//  Created by Shreyas Rajapurkar on 01/01/22.
//

import Foundation

class NetworkingClient {
    public static func fetchNewsFeed(page: Int,
                                     country: String = "in",
                                     completion: @escaping ([NewsArticle]) -> Void) {
        let pageNumberString = String(page)
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=dbb372a6a28d4a44a569002574f8fb2a&page=\(pageNumberString)&pageSize=10") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return
            }

            if let data = data {
                if let articles = parseNewsArticleData(data: data) {
                    completion(articles)
                }
            }
        }
        dataTask.resume()
    }

    private static func parseNewsArticleData(data: Data) -> [NewsArticle]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsArticleCollection.self, from: data)
            return decodedData.articles
        } catch {
            print(error)
        }

        return nil
    }
}


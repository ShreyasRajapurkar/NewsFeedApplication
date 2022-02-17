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
    
    public static func fetchArticles(page: Int,
                                     country: String = "in",
                                     channel: String? = nil,
                                     completion: @escaping ([NewsArticle]) -> Void) {
        let pageNumberString = String(page)
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&channel=\(channel!)&apiKey=dbb372a6a28d4a44a569002574f8fb2a") else {
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
    
    public static func fetchChannels(country: String = "in",
                                     completion: @escaping ([NewsChannel]) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines/sources?country=\(country)&apiKey=dbb372a6a28d4a44a569002574f8fb2a") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return
            }

            if let data = data {
                if let channels = parseNewsChannelData(data: data) {
                    completion(channels)
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
    
    private static func parseNewsChannelData(data: Data) -> [NewsChannel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsChannelCollection.self, from: data)
            return decodedData.sources
        } catch {
            print(error)
        }

        return nil
    }
}


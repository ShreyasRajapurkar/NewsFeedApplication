//
//  NewsArticleCollection.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

class NewsArticleCollection: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]

    init(status: String, totalResults: Int, articles: [NewsArticle]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

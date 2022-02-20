//
//  NewsArticleCollection.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

struct NewsArticleCollection: Decodable {
    let status: String
    let articles: [NewsArticle]

    init(status: String, articles: [NewsArticle]) {
        self.status = status
        self.articles = articles
    }
}

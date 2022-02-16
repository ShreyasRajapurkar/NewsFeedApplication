//
//  NewsArticle.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

class NewsArticle: Decodable {
    let title: String
    let description: String?

    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
}

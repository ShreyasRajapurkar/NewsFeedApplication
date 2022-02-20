//
//  NewsArticle.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

struct NewsArticle: Decodable {
    let title: String
    let description: String?
    let url: String

    init(title: String, description: String?, url: String) {
        self.title = title
        self.description = description
        self.url = url
    }
}

//
//  NewsArticle.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

struct NewsChannel: Decodable {
    let name: String
    let description: String
    let id: String

    init(name: String, description: String, id: String) {
        self.name = name
        self.description = description
        self.id = id
    }
}

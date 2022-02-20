//
//  NewsArticleCollection.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

struct NewsChannelCollection: Decodable {
    let status: String
    let sources: [NewsChannel]

    init(status: String, sources: [NewsChannel]) {
        self.status = status
        self.sources = sources
    }
}

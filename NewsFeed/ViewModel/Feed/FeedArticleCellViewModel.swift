//
//  FeedArticleCellViewModel.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

class FeedArticleCellViewModel {
    let title: String
    let description: String
    let newsURL: String

    init(title: String, description: String, newsURL: String) {
        self.title = title
        self.description = description
        self.newsURL = newsURL
    }
}

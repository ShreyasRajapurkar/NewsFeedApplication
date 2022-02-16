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
    let isExpanded: Bool

    init(title: String, description: String, isExpanded: Bool) {
        self.title = title
        self.description = description
        self.isExpanded = isExpanded
    }
}

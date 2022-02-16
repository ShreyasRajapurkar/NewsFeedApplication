//
//  FeedViewModel.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

protocol NewsFeedViewProtocol: NSObject {
    func didFetchNewsFeed()
}

class FeedViewModel {
    weak var delegate: NewsFeedViewProtocol?
    var articles: [NewsArticle]? {
        didSet {
            delegate?.didFetchNewsFeed()
        }
    }

    public func fetchNewsFeed(page: Int) {
        NetworkingClient.fetchNewsFeed(page: page, completion: { [weak self] articles in
            if articles.count == 0 {
                return
            }

            if var existingArticles = self?.articles {
                self?.articles?.append(contentsOf: articles)
            } else {
                self?.articles = articles
            }
        })
    }
}

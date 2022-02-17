//
//  FeedViewModel.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation

enum FeedListItemType {
    case article
    case channel
}

protocol NewsFeedViewProtocol: NSObject {
    func didFetchNewsFeed()
}

class FeedViewModel {
    let itemType: FeedListItemType
    let channel: String?
    weak var delegate: NewsFeedViewProtocol?
    var feedCellViewModels: [FeedArticleCellViewModel]? {
        didSet {
            delegate?.didFetchNewsFeed()
        }
    }
    
    init(itemType: FeedListItemType, channel: String? = nil) {
        self.itemType = itemType
        self.channel = channel
    }

    public func fetchNewsFeed(page: Int) {
        if itemType == .article {
            fetchArticles(page: page)
        } else {
            fetchChannels()
        }
    }
    
    private func fetchArticles(page: Int) {
        NetworkingClient.fetchArticles(page: page,
                                       channel: channel,
                                       completion: { [weak self] articles in
            if articles.count == 0 {
                return
            }

            let newModels = articles.map { article in
                FeedArticleCellViewModel(
                    itemType: .article,
                    id: nil,
                    title: article.title,
                    description: article.description ?? "",
                    url: article.url)
            }
            if var existingArticles = self?.feedCellViewModels {
                self?.feedCellViewModels?.append(contentsOf: newModels)
            } else {
                self?.feedCellViewModels = newModels
            }
        })
    }
    
    private func fetchChannels() {
        NetworkingClient.fetchChannels(completion: { [weak self] channels in
            if channels.count == 0 {
                return
            }

            self?.feedCellViewModels = channels.map({ channel in
                return FeedArticleCellViewModel(
                    itemType: .channel,
                    id: channel.id,
                    title: channel.name,
                    description: channel.description,
                    url: nil)
            })
        })
    }
}

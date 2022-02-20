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
    func handleFetchFailure(failure: String)
    func updatePaginationState(shouldPaginate: Bool)
}

class FeedViewModel {
    let country = "in"
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

    public func fetchNewsFeed(page: Int, searchQuery: String? = nil, isLoadMore: Bool = false) {
        if itemType == .article {
            fetchArticles(page: page, searchQuery: searchQuery, isLoadMore: isLoadMore)
        } else {
            fetchChannels()
        }
    }

    private func fetchArticles(page: Int,
                               searchQuery: String?,
                               isLoadMore: Bool) {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        if searchQuery != nil {
            queryItems.append(URLQueryItem(name: "q", value: searchQuery))
        } else if channel != nil {
            queryItems.append(URLQueryItem(name: "sources", value: channel))
        } else {
            queryItems.append(URLQueryItem(name: "country", value: country))
        }
        queryItems.append(URLQueryItem(name: "apiKey", value: NetworkingClient.APIKey))
        queryItems.append(URLQueryItem(name: "pageSize", value: "10"))

        let newsArticlesResource = NewsArticlesResource(queryItems: queryItems)
        NetworkingClient.performRequest(resource: newsArticlesResource) { [weak self] (result: Result<NewsArticleCollection, Error>)  in
            switch result {
            case .success(let success):
                let articles = success.articles
                let newModels = articles.map { article in
                    FeedArticleCellViewModel(
                        itemType: .article,
                        id: nil,
                        title: article.title,
                        description: article.description ?? "",
                        url: article.url)
                }

                self?.delegate?.updatePaginationState(shouldPaginate: newModels.count == 10 ? true : false)
                if isLoadMore {
                    self?.feedCellViewModels?.append(contentsOf: newModels)
                } else {
                    self?.feedCellViewModels = newModels
                }
            case .failure(let failure):
                self?.delegate?.handleFetchFailure(failure: failure.localizedDescription)
            }
        }
    }
    
    private func fetchChannels() {
        let newsChannelsResource = NewsChannelsResource(
            queryItems: [URLQueryItem(name: "country", value: "in"),
                         URLQueryItem(name: "apiKey", value: NetworkingClient.APIKey)])
        NetworkingClient.performRequest(resource: newsChannelsResource, completion: { [weak self] (result: Result<NewsChannelCollection, Error>)  in
            switch result {
            case .success(let success):
                let channels = success.sources
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
            case .failure(let failure):
                self?.delegate?.handleFetchFailure(failure: failure.localizedDescription)
            }
        })
    }
}

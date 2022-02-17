//
//  FeedArticleCellViewModel.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation
import UIKit

class FeedArticleCellViewModel {
    let itemType: FeedListItemType
    let id: String?
    let title: String
    let description: String
    let url: String?

    init(itemType: FeedListItemType, id: String?, title: String, description: String, url: String?) {
        self.itemType = itemType
        self.id = id
        self.title = title
        self.description = description
        self.url = url
    }

    public func handleTap(navigationController: UINavigationController) {
        if itemType == .article {
            if let url = url,
            let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if itemType == .channel {
            let feedViewController = FeedViewController(viewModel: FeedViewModel(itemType: .article, channel: self.id))
            feedViewController.modalPresentationStyle = .fullScreen
            navigationController.pushViewController(feedViewController, animated: true)
        }
    }
}

//
//  SearchViewController.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 17/02/22.
//

import Foundation
import UIKit

class SearchViewController: FeedViewController, UISearchBarDelegate {
    let searchBar = UISearchBar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.placeholder = "Search for news"
        searchBar.backgroundColor = UIColor.white
        searchBar.delegate = self
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.topItem?.titleView = nil
    }
    
    override func fetchNewsFeed() {
        // No - op: We do not want to pre-fetch any news feed until the user has explicitly searched for something
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        emptyStateLabel.text = "Loading"
        emptyStateLabel.isHidden = false
        tableView.isHidden = true
        viewModel.fetchNewsFeed(page: 1, searchQuery: searchBar.text)
    }
}

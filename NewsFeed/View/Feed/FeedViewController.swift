//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation
import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsFeedViewProtocol {
    let emptyStateLabel = UILabel()
    let viewModel: FeedViewModel
    var cellViewModels: [FeedArticleCellViewModel]?
    let tableView = UITableView()
    var shouldPaginate: Bool

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel

        // Only add pagination for news articles
        self.shouldPaginate = viewModel.itemType == .article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        setupTableView()
        setupEmptyState()
        viewModel.delegate = self
        fetchNewsFeed()
        setupConstraints()
    }
    
    func fetchNewsFeed() {
        viewModel.fetchNewsFeed(page: 1)
    }
    
    private func setupEmptyState() {
        view.addSubview(emptyStateLabel)
        emptyStateLabel.text = "No results"
        emptyStateLabel.isHidden = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(FeedArticleCell.self, forCellReuseIdentifier: "FeedArticleCell")
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedArticleCell", for: indexPath)
        if let cellViewModel = cellViewModels?[indexPath.row] {
            (cell as? FeedArticleCell)?.setup(cellViewModel: cellViewModel)
        }

        return cell
    }

    func didFetchNewsFeed() {
        cellViewModels = viewModel.feedCellViewModels
        if cellViewModels?.count == 0 {
            DispatchQueue.main.async { [weak self] in
                self?.emptyStateLabel.text = "No results"
                self?.emptyStateLabel.isHidden = false
                self?.tableView.isHidden = true
            }
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.emptyStateLabel.isHidden = true
            self?.tableView.isHidden = false
        }
    }
    
    func updatePaginationState(shouldPaginate: Bool) {
        self.shouldPaginate = shouldPaginate
    }
    
    func handleFetchFailure(failure: String) {
        self.emptyStateLabel.isHidden = false
        self.tableView.isHidden = true
        self.emptyStateLabel.text = failure
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellViewModels!.count - 1 && shouldPaginate {
            let page = ((indexPath.row + 1) / 10) + 1

            // Load more call
            viewModel.fetchNewsFeed(page: page, isLoadMore: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = cellViewModels?[indexPath.row]
        cellViewModel?.handleTap(navigationController: navigationController!)
    }
}

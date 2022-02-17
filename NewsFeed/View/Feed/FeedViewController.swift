//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation
import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsFeedViewProtocol {
    let viewModel: FeedViewModel
    var cellViewModels: [FeedArticleCellViewModel]?
    let tableView = UITableView()

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.delegate = self
        viewModel.fetchNewsFeed(page: 1)
    }
    
    func setupCollectionView() {
        view.addSubview(tableView)
        
        tableView.register(FeedArticleCell.self, forCellReuseIdentifier: "FeedArticleCell")
        tableView.backgroundColor = UIColor.darkGray
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))

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
        cellViewModels = viewModel.articles?.map({ article in
            return FeedArticleCellViewModel(
                title: article.title,
                description: article.description ?? "",
                newsURL: article.url)
        })

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func didTapOnNewsArticleInFeed(cellViewModel: FeedArticleCellViewModel?) {
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellViewModels!.count - 1 {
            let page = (indexPath.row / 10) + 1

            // Load more call
            viewModel.fetchNewsFeed(page: page)
        }
    }
}

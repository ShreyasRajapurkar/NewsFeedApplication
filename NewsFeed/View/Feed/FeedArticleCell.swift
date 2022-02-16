//
//  FeedArticleCell.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation
import UIKit

protocol NewsArticleExpansionProtocol: NSObject {
    func didTapOnNewsArticleInFeed(cellViewModel: FeedArticleCellViewModel?)
}

class FeedArticleCell: UITableViewCell {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    var cellViewModel: FeedArticleCellViewModel?
    let descriptionHeightConstraint: NSLayoutConstraint
    weak var expansionDelegate: NewsArticleExpansionProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        descriptionHeightConstraint = descriptionLabel.heightAnchor.constraint(equalToConstant: 0)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        setupLayout()
        setupInteractions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20))
        constraints.append(titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20))
        
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20))
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20))
        constraints.append(descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
        NSLayoutConstraint.activate(constraints)
    }
    
    public func setup(cellViewModel: FeedArticleCellViewModel, expansionDelegate: NewsArticleExpansionProtocol) {
        titleLabel.text = cellViewModel.title
        descriptionLabel.text = cellViewModel.description
        descriptionLabel.isHidden = !cellViewModel.isExpanded

        if !cellViewModel.isExpanded {
            NSLayoutConstraint.activate([descriptionHeightConstraint])
        } else {
            NSLayoutConstraint.deactivate([descriptionHeightConstraint])
        }

        self.cellViewModel = cellViewModel
        self.expansionDelegate = expansionDelegate
    }
    
    func setupInteractions() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnNewsArticle))
        contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupLayout() {
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor.gray
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc
    func didTapOnNewsArticle() {
        expansionDelegate?.didTapOnNewsArticleInFeed(cellViewModel: cellViewModel)
    }
}

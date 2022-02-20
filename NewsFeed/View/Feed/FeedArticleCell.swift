//
//  FeedArticleCell.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import Foundation
import UIKit

class FeedArticleCell: UITableViewCell {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    var cellViewModel: FeedArticleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        setupLayout()
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
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10))
        constraints.append(descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
        NSLayoutConstraint.activate(constraints)
    }
    
    public func setup(cellViewModel: FeedArticleCellViewModel) {
        titleLabel.text = cellViewModel.title
        descriptionLabel.text = cellViewModel.description
        self.cellViewModel = cellViewModel
    }
    
    func setupLayout() {
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        descriptionLabel.numberOfLines = 5
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor.gray
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

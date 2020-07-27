//
//  NewsOverviewTableViewCell.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

class NewsOverviewTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "NewsOverviewCellIdentifier"
    
    private lazy var newsImageView: UIImageView = createNewsImageView()
    private lazy var newsTitleLabel: UILabel = createNewsTitleLabel()
    
    private var viewModel: NewsOverviewTableViewCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(newsImageView)
        addSubview(newsTitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        viewModel?.cancelFetchImage()
    }
    
    func configure(with viewModel: NewsOverviewTableViewCellViewModel, indexPath: IndexPath) {
        self.viewModel = viewModel
        viewModel.imageClosure = { [weak self] image in
            self?.newsImageView.image = image
        }
        newsTitleLabel.accessibilityIdentifier
            = AccessibilityIdenitifers
                .NewsOverview
                .articleItem(at: indexPath.row, in: indexPath.section)
        newsTitleLabel.text = viewModel.article.title
        viewModel.fetchImage()
    }
    
}

// MARK: - UI
extension NewsOverviewTableViewCell {
    
    private func createNewsImageView() -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func createNewsTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }
    
}

// MARK: - Constraints
extension NewsOverviewTableViewCell {
 
    private func setupConstraints() {
        
        // NewsImageView constraints
        NSLayoutConstraint.activate([
            newsImageView.widthAnchor.constraint(equalToConstant: 60),
            newsImageView.heightAnchor.constraint(equalToConstant: 60),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16),
            newsImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ])
        
        // NewsTitleLabel Constraints
        NSLayoutConstraint.activate([
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 16),
            newsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            newsTitleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16),
            newsTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ])
    }
    
}

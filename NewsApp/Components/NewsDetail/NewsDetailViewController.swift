//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import NewsAPIKit
import NewsUIKit

class NewsDetailViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = createScrollView()
    private lazy var contentView: UIView = createContentView()
    private lazy var stackView: UIStackView = createStackView()
    // StackView components
    private lazy var headerView: NewsDetailHeaderView = createHeaderView(with: viewModel.article)
    private lazy var titleLabel: UILabel = createDefaultLabel(text: viewModel.article.title)
    private lazy var separator: UIView = createSeparatorView()
    private lazy var authorLabel: UILabel = createDefaultLabel(
        text: Localized.authorTitle(viewModel.article.author ?? "-"))
    private lazy var dateLabel: UILabel = createDefaultLabel(
        text: Localized.dateTitle(viewModel.publishedDateString ?? "-"))
    private lazy var contentLabel: UILabel = createContentLabel(text: viewModel.article.content)
    private lazy var openArticleButton: UIButton = createOpenArticleButton()
    
    private let viewModel: NewsDetailViewModel
    
    init(with viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not beem implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.article.title
        view.backgroundColor = viewModel.backgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        // StackView components
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(separator)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(contentLabel)
        stackView.addArrangedSubview(openArticleButton)
        
        setupConstraints()
    }
    
    @objc private func openArticleButtonTapped(_ sender: UIButton) {
        guard let url = viewModel.article.url else {
            return
        }
        let browser = BrowserViewController()
        browser.load(with: url)
        navigationController?.present(browser, animated: true)
    }
    
}

// MARK: - UI
extension NewsDetailViewController {
    
    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    private func createContentView() -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }
    
    private func createHeaderView(with article: Article) -> NewsDetailHeaderView {
        let viewModel = NewsDetailHeaderViewModel(with: article)
        let headerView = NewsDetailHeaderView(with: viewModel)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .red
        return headerView
    }
    
    private func createDefaultLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = text
        return label
    }
    
    private func createSeparatorView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NewsColor.Primary.Separators.mainColor
        return view
    }
    
    private func createContentLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = text
        return label
    }
    
    private func createOpenArticleButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Localized.openArticleButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = NewsColor.Primary.greenLight
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(openArticleButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
}

// MARK: - Constraints
extension NewsDetailViewController {
 
    // swiftlint:disable function_body_length
    private func setupConstraints() {
        // Scrollview constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Contentview constraints
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        // Stackview constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // TitleLabel constraint
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        ])
        
        // SeparatorView constraint
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        // AuthorLabel constraint
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        ])
        
        // DateLabel constraint
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        ])
        
        // ContentLabel constraint
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            contentLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16)
        ])
        
        // OpenArticleButton constraint
        NSLayoutConstraint.activate([
            openArticleButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
            openArticleButton.widthAnchor.constraint(equalToConstant: 150),
            openArticleButton.heightAnchor.constraint(equalToConstant: 50),
            openArticleButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    
    }
    
}

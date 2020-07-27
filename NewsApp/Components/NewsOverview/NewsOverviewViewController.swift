//
//  NewsOverviewViewController.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit
import NewsAPIKit
import NewsUIKit

class NewsOverviewViewController: UIViewController {
    
    private lazy var headerView: NewsOverviewHeaderView = createHeaderView()
    private lazy var errorView: ErrorView = createErrorView()
    private lazy var tableView: NewsOverviewTableView = createTableView(with: tableViewViewModel)
    private lazy var loader: UIActivityIndicatorView = createActivityIndicatorView()
    
    private let viewModel: NewsOverviewViewModel
    private let tableViewViewModel: NewsOverviewTableViewViewModel
    
    init(with viewModel: NewsOverviewViewModel) {
        self.viewModel = viewModel
        self.tableViewViewModel = .init(with: viewModel.data)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = AccessibilityIdenitifers.NewsOverview.rootViewId
        view.backgroundColor = viewModel.backgroundColor
        title = viewModel.title
        
        view.addSubview(headerView)
        view.addSubview(errorView)
        view.addSubview(tableView)
        view.addSubview(loader)
        
        setupConstraints()
        
        viewModel.dataChangedHandler = { [weak self] state in
            self?.updateView(for: state)
        }
    }
    
    private func updateView(for state: NewsOverviewViewModel.State) {
        switch state {
        case .loading:
            startLoading()
        case .error:
            showError()
        case .data(let data):
            showData(data)
        }
    }
    
    private func startLoading() {
        loader.startAnimating()
        errorView.isHidden = true
        tableView.isHidden = true
    }
    
    private func showError() {
        loader.stopAnimating()
        errorView.isHidden = false
        tableView.isHidden = true
    }
    
    private func showData(_ data: AggregatedArticles) {
        loader.stopAnimating()
        errorView.isHidden = true
        tableView.isHidden = false
        
        tableView.setContentOffset(.zero, animated: true)
        tableViewViewModel.updateData(data: data)
    }
    
}

// MARK: - NewsOverviewHeaderViewDelegate
extension NewsOverviewViewController: NewsOverviewHeaderViewDelegate {
    
    func newsOverviewHeaderView(didStartSearch query: String, category: NewsHeadlineCategory) {
        viewModel.fetchNews(query: query, in: category)
    }
    
}

// MARK: - ErrorViewDelegate
extension NewsOverviewViewController: ErrorViewDelegate {
    
    func errorViewDidTapRetry() {
        viewModel.retryLastSearchAttempt()
    }
        
}

// MARK: - NewsOverviewTableViewSelectionDelegate
extension NewsOverviewViewController: NewsOverviewTableViewSelectionDelegate {
    
    func didSelectedNewsArticle(_ article: Article) {
        let detailViewModel = NewsDetailViewModel(with: article)
        let detailViewController = NewsDetailViewController(with: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - UI
extension NewsOverviewViewController {
    
    private func createHeaderView() -> NewsOverviewHeaderView {
        let header = NewsOverviewHeaderView(with: .init(categories: viewModel.headlineCategories))
        header.translatesAutoresizingMaskIntoConstraints = false
        header.delegate = self
        return header
    }
    
    private func createErrorView() -> ErrorView {
        let viewModel = ErrorViewViewModel(retryButtonTitle: Localized.retryTitle,
                                           errorImage: Assets.ErrorIcons.iconGeneralError.image)
        let errorView = ErrorView(with: viewModel)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.delegate = self
        errorView.isHidden = true
        return errorView
    }
    
    private func createActivityIndicatorView() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(style: .gray)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }
    
    private func createTableView(with viewModel: NewsOverviewTableViewViewModel) -> NewsOverviewTableView {
        let tableView = NewsOverviewTableView(with: viewModel)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.selectionDelegate = self
        tableView.accessibilityIdentifier = AccessibilityIdenitifers.NewsOverview.articlesTableView
        return tableView
    }
    
}

// MARK: - Constraints
extension NewsOverviewViewController {
    
    private func setupConstraints() {
        // header view constraints
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
        
        // error view constraints
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16)
        ])
        
        // tableView constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // loader constraints
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

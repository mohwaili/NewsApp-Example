//
//  NewsOverviewViewModel.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsOverviewViewModel {
    
    private let newsRepository: NewsRepositoryProtocol
    
    var backgroundColor: UIColor {
        .white
    }
    
    var title: String {
        "News"
    }
    
    var headlineCategories: [NewsHeadlineCategory] {
        newsRepository.headlineCategories
    }
    
    private var lastQueryUsed: String?
    private var lastCategorySelected: NewsHeadlineCategory?
    
    enum State: Equatable {
        case loading
        case error(RequestError)
        case data(AggregatedArticles)
        
        static func == (lhs: NewsOverviewViewModel.State, rhs: NewsOverviewViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.error(let lhsError), .error(let rhsError)):
                return lhsError == rhsError
            case (.data(let lhsResult), .data(let rhsResult)):
                return lhsResult == rhsResult
            default:
                return false
            }
        }
    }
    
    var data: AggregatedArticles? {
        guard case .data(let data) = currentState else {
            return nil
        }
        return data
    }
    
    private var currentState: State? {
        didSet {
            guard let state = currentState else { return }
            dataChangedHandler?(state)
        }
    }
    var dataChangedHandler: ((State) -> Void)?
    
    init(newsRepository: NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepository = newsRepository
    }
    
    func fetchNews(query: String, in category: NewsHeadlineCategory) {
        lastQueryUsed = query
        lastCategorySelected = category
        currentState = .loading
        self.newsRepository.fetchArticlesWithHeadlines(for: query, category: category) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.currentState = .error(error)
            case .success(let aggregatedResults):
                self?.currentState = .data(aggregatedResults)
            }
        }
    }
    
    func retryLastSearchAttempt() {
        guard
            let query = lastQueryUsed,
            let category = lastCategorySelected else {
                return
        }
        fetchNews(query: query, in: category)
    }
    
}

//
//  FetchHeadlinesOperation.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class FetchHeadlinesOperation: AsyncResultOperation<[Article], RequestError> {
    
    private let fetcher: NewsFetcherProtocol
    private let query: String
    private let category: NewsHeadlineCategory
    
    init(fetcher: NewsFetcherProtocol, query: String, category: NewsHeadlineCategory) {
        self.fetcher = fetcher
        self.query = query
        self.category = category
    }
    
    override func workItem() {
        fetcher.fetchHeadlines(for: query, in: category) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.workItemFinished(with: .failure(error))
            case .success(let articles):
                self?.workItemFinished(with: .success(articles))
            }
        }
    }
    
}

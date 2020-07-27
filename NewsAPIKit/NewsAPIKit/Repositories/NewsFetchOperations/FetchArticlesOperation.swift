//
//  FetchArticlesOperation.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class FetchArticlesOperation: AsyncResultOperation<[Article], RequestError> {
    
    private let fetcher: NewsFetcherProtocol
    private let query: String
    
    init(fetcher: NewsFetcherProtocol, query: String) {
        self.fetcher = fetcher
        self.query = query
    }
    
    override func workItem() {
        fetcher.fetchAllArticles(query: query) { [weak self] result in
            switch result {
            case.failure(let error):
                self?.workItemFinished(with: .failure(error))
            case .success(let articles):
                self?.workItemFinished(with: .success(articles))
            }
        }
    }
    
}

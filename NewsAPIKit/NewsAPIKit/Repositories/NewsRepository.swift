//
//  NewsRepository.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

public protocol NewsRepositoryProtocol: AutoMockable {
    
    /**
     All available categories to choose from
     */
    var headlineCategories: [NewsHeadlineCategory] { get }
    
    init(newsFetcher: NewsFetcherProtocol, categories: [NewsHeadlineCategory])
    
    /**
     Sets the headlines categories in repository
     */
    func setCategories(_ categories: [NewsHeadlineCategory])
    
    /**
     Fetches all headlines for the given category
     
     - parameters:
        - category: the category for the headline articles
        - completion: completion closure for the result
     */
    func fetchHeadlines(for query: String,
                        in category: NewsHeadlineCategory,
                        completion: @escaping (Result<[Article], RequestError>) -> Void)
    
    /**
    Fetches all articles for the given query
    
    - parameters:
       - query: the query for the articles to search for
       - completion: completion closure for the result
    */
    func fetchArticles(for query: String, completion: @escaping (Result<[Article], RequestError>) -> Void)
    
    /**
    Fetches all headlines for the given category
    
    - parameters:
        - query: the query for the articles to search for
        - category: the category for the headline articles
        - completion: completion closure for the aggregated result
    */
    func fetchArticlesWithHeadlines(for query: String,
                                    category: NewsHeadlineCategory,
                                    completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void)
}

public class NewsRepository: NewsRepositoryProtocol {
    
    public var headlineCategories: [NewsHeadlineCategory]
    
    private let newsFetcher: NewsFetcherProtocol
    private let newsFetchQueue = DispatchQueue(label: "fetchArticlesWithHeadlinesQueue",
                                               qos: .userInitiated,
                                               attributes: .concurrent)
    
    public required init(newsFetcher: NewsFetcherProtocol = NewsFetcher(with: NetworkClient()),
         categories: [NewsHeadlineCategory] = NewsHeadlineCategory.allCases) {
        self.newsFetcher = newsFetcher
        self.headlineCategories = categories
    }
    
    public func setCategories(_ categories: [NewsHeadlineCategory]) {
        headlineCategories = categories
    }
    
    public func fetchHeadlines(for query: String,
                        in category: NewsHeadlineCategory,
                        completion: @escaping (Result<[Article], RequestError>) -> Void) {
        newsFetcher.fetchHeadlines(for: query, in: category, completion: completion)
    }

    public func fetchArticles(for query: String, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        newsFetcher.fetchAllArticles(query: query, completion: completion)
    }
    
    public func fetchArticlesWithHeadlines(for query: String,
                                    category: NewsHeadlineCategory,
                                    completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void) {
        let queue = OperationQueue()
        queue.underlyingQueue = newsFetchQueue
        
        let headlinesOperation = FetchHeadlinesOperation(fetcher: newsFetcher, query: query, category: category)
        let articlesOperation = FetchArticlesOperation(fetcher: newsFetcher, query: query)
        
        var headlineArticles: [Article]?
        var allArticles: [Article]?
        
        headlinesOperation.onResult = { result in
            switch result {
            case .failure(let error):
                queue.cancelAllOperations()
                completion(.failure(error))
            case .success(let articles):
                headlineArticles = articles
            }
        }
        
        articlesOperation.onResult = { result in
            switch result {
            case .failure(let error):
                queue.cancelAllOperations()
                completion(.failure(error))
            case .success(let articles):
                allArticles = articles
            }
        }
        
        let completionOperation = BlockOperation {
            guard
                let headlineArticles = headlineArticles,
                let allArticles = allArticles else {
                    return completion(.failure(.noData))
            }
            let aggregatedArticles = AggregatedArticles(headlines: headlineArticles, articles: allArticles)
            DispatchQueue.main.async {
                completion(.success(aggregatedArticles))
            }
        }
        completionOperation.addDependency(headlinesOperation)
        completionOperation.addDependency(articlesOperation)
        
        queue.addOperations([headlinesOperation, articlesOperation, completionOperation], waitUntilFinished: false)
    }
    
}

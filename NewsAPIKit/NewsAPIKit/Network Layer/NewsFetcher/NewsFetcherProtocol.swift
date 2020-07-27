//
//  File.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

public enum NewsHeadlineCategory: String, CaseIterable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

public protocol NewsFetcherProtocol: AutoMockable {
    
    init(with client: NetworkClientProtocol)
    
    /**
    Fetches all articles for the given topic
    
    - parameters:
       - topic: the topic for the articles
       - completion: completion closure for the result
    */
    func fetchAllArticles(query: String, completion: @escaping (Result<[Article], RequestError>) -> Void)
    
    /**
    Fetches all headline articles for the given category
    
    - parameters:
       - topic: the topic for the articles
       - completion: completion closure for the result
    */
    func fetchHeadlines(for query: String,
                        in category: NewsHeadlineCategory,
                        completion: @escaping (Result<[Article], RequestError>) -> Void)
    
}

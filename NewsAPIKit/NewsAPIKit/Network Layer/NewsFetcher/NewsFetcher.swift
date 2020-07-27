//
//  NewsFetcher.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 24/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

public class NewsFetcher: NewsFetcherProtocol {
    
    private let client: NetworkClientProtocol
    
    public required init(with client: NetworkClientProtocol) {
        self.client = client
    }
    
    public func fetchAllArticles(query: String, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        guard let request = NewsRequestBuilder(baseURL: client.baseURL.absoluteString)?
            .setHTTPMethod(.get)
            .setEndpoint(NewsEndpoint.everything.rawValue)
            .setParameters([
                QueryParameter(name: "q", value: query)
            ])
            .build() else { return completion(.failure(.invalidRequest)) }
        
        client.performRequest(request) { (result: Result<ArticlesResponse, RequestError>) in
            switch result {
            case .success(let articlesResponse):
                completion(.success(articlesResponse.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchHeadlines(for query: String,
                               in category: NewsHeadlineCategory,
                               completion: @escaping (Result<[Article], RequestError>) -> Void) {
        guard let request = NewsRequestBuilder(baseURL: client.baseURL.absoluteString)?
            .setHTTPMethod(.get)
            .setEndpoint(NewsEndpoint.headlines.rawValue)
            .setParameters([
                QueryParameter(name: "country", value: "nl"),
                QueryParameter(name: "q", value: query),
                QueryParameter(name: "category", value: category.rawValue)
            ])
            .build() else { return completion(.failure(.invalidRequest)) }
        client.performRequest(request) { (result: Result<ArticlesResponse, RequestError>) in
            switch result {
            case .success(let articlesResponse):
                completion(.success(articlesResponse.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

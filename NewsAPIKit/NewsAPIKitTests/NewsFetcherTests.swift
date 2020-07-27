//
//  NewsFetcherTests.swift
//  NewsAPIKitTests
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import XCTest
@testable import NewsAPIKit

class FakeNetworkClient: NetworkClientProtocol {
    
    var baseURL: URL {
        URL(string: "https://www.google.com")!
    }
    
    required init() { }
    
    func performRequest(_ request: URLRequest,
                        completion: @escaping (Result<Data, RequestError>) -> Void) -> URLSessionDataTask? {
        nil
    }
    
    func performRequest<R>(_ request: URLRequest,
                           completion: @escaping (Result<R, RequestError>) -> Void)
        -> URLSessionDataTask? where R: Decodable {
            nil
    }
    
    func downloadImage(_ request: URLRequest,
                       completion: @escaping (Result<UIImage, RequestError>) -> Void) -> URLSessionDataTask? {
        nil
    }
    
}

class NewsFetcherTests: XCTestCase {
    
    private var sut: NewsFetcherProtocolMock!
    private var client: NetworkClientProtocol!
    
    override func setUp() {
        let client = FakeNetworkClient()
        sut = NewsFetcherProtocolMock(with: client)
    }
    
    func testNewsFetcher_handlesInvalidRequest() {
        // Given
        sut.fetchHeadlinesForInCompletionClosure = { (query: String,
            category: NewsHeadlineCategory,
            completion: @escaping (Result<[Article], RequestError>) -> Void) in
            completion(.failure(.invalidRequest))
        }
        
        // When
        var expectedResponse: [Article]?
        var expectedError: RequestError?
        sut.fetchHeadlines(for: "test", in: .business) { result in
            switch result {
            case .failure(let error):
                expectedError = error
            case .success(let articles):
                expectedResponse = articles
            }
        }
        
        // Then
        XCTAssertNil(expectedResponse)
        XCTAssert(expectedError == .some(.invalidRequest))
    }
    
    func testNewsFetcher_handlesInvalidResponse() {
        // Given
        sut.fetchHeadlinesForInCompletionClosure = {
            (query: String,
            category: NewsHeadlineCategory,
            completion: @escaping (Result<[Article], RequestError>) -> Void) in
            completion(.failure(.invalidResponse))
        }
        
        // When
        var expectedResponse: [Article]?
        var expectedError: RequestError?
        sut.fetchHeadlines(for: "test", in: .business) { result in
            switch result {
            case .failure(let error):
                expectedError = error
            case .success(let articles):
                expectedResponse = articles
            }
        }
        
        // Then
        XCTAssertNil(expectedResponse)
        XCTAssert(expectedError == .some(.invalidResponse))
    }
    
    func testNewsFetcher_handlesNoData() {
        // Given
        sut.fetchHeadlinesForInCompletionClosure = {
            (query: String,
            category: NewsHeadlineCategory,
            completion: @escaping (Result<[Article], RequestError>) -> Void) in
            completion(.failure(.noData))
        }
        
        // When
        var expectedResponse: [Article]?
        var expectedError: RequestError?
        sut.fetchHeadlines(for: "test", in: .business) { result in
            switch result {
            case .failure(let error):
                expectedError = error
            case .success(let articles):
                expectedResponse = articles
            }
        }
        
        // Then
        XCTAssertNil(expectedResponse)
        XCTAssert(expectedError == .some(.noData))
    }
    
    func testNewsFetcher_handlesRequestError() {
        // Given
        sut.fetchHeadlinesForInCompletionClosure = {
            (query: String,
            category: NewsHeadlineCategory,
            completion: @escaping (Result<[Article], RequestError>) -> Void) in
            completion(.failure(.requestError))
        }
        
        // When
        var expectedResponse: [Article]?
        var expectedError: RequestError?
        sut.fetchHeadlines(for: "test", in: .business) { result in
            switch result {
            case .failure(let error):
                expectedError = error
            case .success(let articles):
                expectedResponse = articles
            }
        }
        
        // Then
        XCTAssertNil(expectedResponse)
        XCTAssert(expectedError == .some(.requestError))
    }
    // test
    func testNewsFetcher_handlesServerError() {
        // Given
        sut.fetchHeadlinesForInCompletionClosure = {
            (query: String,
            category: NewsHeadlineCategory,
            completion: @escaping (Result<[Article], RequestError>) -> Void) in
            completion(.failure(.serverError))
        }
        
        // When
        var expectedResponse: [Article]?
        var expectedError: RequestError?
        sut.fetchHeadlines(for: "test", in: .business) { result in
            switch result {
            case .failure(let error):
                expectedError = error
            case .success(let articles):
                expectedResponse = articles
            }
        }
        
        // Then
        XCTAssertNil(expectedResponse)
        XCTAssert(expectedError == .some(.serverError))
    }
    
    func testNewsFetcher_handlesValidResponse() {
        // Given
        let articles: [Article] = [
            .init(source: nil,
                  author: "Mohammed Al Waili",
                  title: "Fake Title",
                  description: "Fake Description",
                  urlString: nil,
                  imageURLString: nil,
                  publishedDateString: nil,
                  content: nil)
        ]
        sut.fetchHeadlinesForInCompletionClosure = {
            (query: String,
            category: NewsHeadlineCategory,
            completion: @escaping (Result<[Article], RequestError>) -> Void) in
            completion(.success(articles))
        }
        
        // When
        var expectedResponse: [Article]?
        var expectedError: RequestError?
        sut.fetchHeadlines(for: "test", in: .business) { result in
            switch result {
            case .failure(let error):
                expectedError = error
            case .success(let articles):
                expectedResponse = articles
            }
        }
        
        // Then
        XCTAssertNil(expectedError)
        XCTAssertNotNil(expectedResponse)
        XCTAssert(expectedResponse?.count == 1)
        XCTAssertEqual(expectedResponse?.first?.author, "Mohammed Al Waili")
        XCTAssertEqual(expectedResponse?.first?.title, "Fake Title")
    }
    
}

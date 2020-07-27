//
//  NewsOverviewViewModelTests.swift
//  NewsAppTests
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import XCTest
import NewsAPIKit
@testable import NewsApp

class NewsOverviewViewModelTests: XCTestCase {
    
    private var fakeRepository: NewsRepositoryProtocolMock!
    private var sut: NewsOverviewViewModel!
    
    override func setUp() {
        let fetcher = NewsFetcherProtocolMock(with: NetworkClientMock())
        fakeRepository = NewsRepositoryProtocolMock(newsFetcher: fetcher, categories: [])
        sut = NewsOverviewViewModel(newsRepository: fakeRepository)
    }
    
    func testNewsOverviewViewModel_loadingState() {
        // Given
        fakeRepository
            .fetchArticlesWithHeadlinesForCategoryCompletionClosure = { (query: String,
                category: NewsHeadlineCategory,
                completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void) in
        }
        
        var expectedState: NewsOverviewViewModel.State?
        // When
        sut.dataChangedHandler = { state in
            expectedState = state
        }
        sut.fetchNews(query: "Test", in: .business)
        
        // Then
        XCTAssertEqual(expectedState, NewsOverviewViewModel.State.loading)
        
    }
    
    func testNewsOverviewViewModel_errorState() {
        // Given
        fakeRepository
            .fetchArticlesWithHeadlinesForCategoryCompletionClosure = { (query: String,
                category: NewsHeadlineCategory,
                completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void) in
            completion(.failure(.noData))
        }
        
        var expectedState: NewsOverviewViewModel.State?
        // When
        sut.dataChangedHandler = { state in
            expectedState = state
        }
        sut.fetchNews(query: "Test", in: .business)
        
        // Then
        XCTAssertEqual(expectedState, NewsOverviewViewModel.State.error(.noData))
        
    }
    
    func testNewsOverviewViewModel_dataState() {
        // Given
        let result = AggregatedArticles(headlines: [], articles: [])
        fakeRepository
            .fetchArticlesWithHeadlinesForCategoryCompletionClosure = { (query: String,
                category: NewsHeadlineCategory,
                completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void) in
            completion(.success(result))
        }
        
        var expectedState: NewsOverviewViewModel.State?
        // When
        sut.dataChangedHandler = { state in
            expectedState = state
        }
        sut.fetchNews(query: "Test", in: .business)
        
        // Then
        XCTAssertEqual(expectedState, NewsOverviewViewModel.State.data(result))
        
    }
    
    func testNewsOverviewViewModel_dataIsSet() {
        // Given
        let fakeArticle = Article(source: nil,
                                  author: "Mohammed Al Waili",
                                  title: "Fake Title",
                                  description: "Fake Description",
                                  urlString: nil,
                                  imageURLString: nil,
                                  publishedDateString: nil,
                                  content: nil)
        let result = AggregatedArticles(headlines: [fakeArticle], articles: [])
        fakeRepository
            .fetchArticlesWithHeadlinesForCategoryCompletionClosure = { (query: String,
                category: NewsHeadlineCategory,
                completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void) in
            completion(.success(result))
        }
        
        var expectedState: NewsOverviewViewModel.State?
        // When
        sut.dataChangedHandler = { state in
            expectedState = state
        }
        sut.fetchNews(query: "Test", in: .business)
        
        // Then
        XCTAssertTrue(fakeRepository.fetchArticlesWithHeadlinesForCategoryCompletionCalled)
        XCTAssertEqual(fakeRepository.fetchArticlesWithHeadlinesForCategoryCompletionCallsCount, 1)
        
        XCTAssertEqual(expectedState, NewsOverviewViewModel.State.data(result))
        let firstHeadlineArticle = sut.data?.headlines.first
        XCTAssertEqual(firstHeadlineArticle?.author, "Mohammed Al Waili")
        XCTAssertEqual(firstHeadlineArticle?.title, "Fake Title")
        XCTAssertEqual(firstHeadlineArticle?.description, "Fake Description")
        
    }
    
}

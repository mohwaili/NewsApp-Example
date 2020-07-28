//
//  NewsOverviewViewControllerTests.swift
//  NewsAppUITests
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import EarlGrey
import NewsAPIKit
@testable import NewsApp

class NewsOverviewViewControllerTests: NewsTestCase {
    
    var newsRepositoryMock: NewsRepositoryProtocol!
    private lazy var viewModel: NewsOverviewViewModel = .init(newsRepository: newsRepositoryMock)
    
    override func setUp() {
        let fetcher = NewsFetcherProtocolMock(with: NetworkClientMock())
        newsRepositoryMock = NewsRepositoryProtocolMock(newsFetcher: fetcher, categories: NewsHeadlineCategory.allCases)
    }
    
    func testNewsOverviewViewController_exists() {
        // Given
        let viewController = NewsOverviewViewController(with: viewModel)
        
        // When
        open(viewController: viewController)
        
        // Then
        Page.on(NewsOverviewPage.self)
            .verify()
    }
    
    func testNewsOverviewViewController_searchInputfieldIsVisible() {
        // Given
        let viewController = NewsOverviewViewController(with: viewModel)
        
        // When
        open(viewController: viewController)
        
        // Then
        Page.on(NewsOverviewPage.self)
            .assertSearchBarVisible()
    }
    
    func testNewsOverviewViewController_headlineCategoriesExists() {
        // Given
        let fetcherMock = NewsFetcherProtocolMock(with: NetworkClientMock())
        let newsRepository = NewsRepositoryProtocolMock(newsFetcher: fetcherMock, categories: [])
        newsRepository.setCategoriesClosure = { categories in
            newsRepository.headlineCategories = categories
        }
        newsRepository.setCategories([
            .business,
            .entertainment,
            .health,
            .general,
            .technology
        ])
        
        let viewModel = NewsOverviewViewModel(newsRepository: newsRepository)
        let viewController = NewsOverviewViewController(with: viewModel)
        
        // When
        open(viewController: viewController)
        
        // Then
        Page.on(NewsOverviewPage.self)
            .assertCategoriesAreVisible()
            .scrollCategories()
            .assertCategoryTitle("general", atIndex: 3)
    }
    
    func testNewsOverviewViewController_headlineCategoriesHaveCorrectData() {
        // Given
        let fetcherMock = NewsFetcherProtocolMock(with: NetworkClientMock())
        let newsRepository = NewsRepositoryProtocolMock(newsFetcher: fetcherMock, categories: [])
        newsRepository.setCategoriesClosure = { categories in
            newsRepository.headlineCategories = categories
        }
        newsRepository.fetchArticlesWithHeadlinesForCategoryCompletionClosure
            = { (query: String,
                category: NewsHeadlineCategory,
                completion: (Result<AggregatedArticles, RequestError>) -> Void) in
            let results = AggregatedArticles(headlines: self.createFakeArticles(amount: 4),
                                             articles: self.createFakeArticles(amount: 20))
            completion(.success(results))
        }
        newsRepository.setCategories([
            .business,
            .entertainment,
            .health,
            .general,
            .technology
        ])
        
        let viewModel = NewsOverviewViewModel(newsRepository: newsRepository)
        let viewController = NewsOverviewViewController(with: viewModel)
        
        // When
        open(viewController: viewController)
        
        // Then
        Page.on(NewsOverviewPage.self)
            .enterQuery("test")
            .tapSearch()
            .scrollThroughArticles()
            .assertArticleTitle("Title: 2", index: 2, section: 0)
            .assertArticleTitle("Title: 0", index: 0, section: 1)
            .tapArticle(at: 0, in: 1)
            .scrollThroughArticles()
    }
    
}

// MARK: - Fake Data
extension NewsOverviewViewControllerTests {
    
    private func createFakeArticles(amount: Int) -> [Article] {
        var articles: [Article] = []
        // swiftlint:disable identifier_name
        for i in 0..<amount {
            let article = Article(source: nil,
                                  author: "Author: \(i)",
                title: "Title: \(i)",
                description: "Description: \(i)",
                urlString: nil,
                imageURLString: nil,
                publishedDateString: nil,
                content: nil)
            articles.append(article)
        }
        return articles
        
    }
    
}

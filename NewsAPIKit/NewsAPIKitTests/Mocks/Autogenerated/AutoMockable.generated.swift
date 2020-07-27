// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name
// swiftlint:disable vertical_whitespace
// swiftlint:disable mark
// swiftlint:disable large_tuple
// swiftlint:disable comma

import Foundation
@testable import NewsAPIKit














class NewsFetcherProtocolMock: NewsFetcherProtocol {

    //MARK: - init

    var initWithReceivedClient: NetworkClientProtocol?
    var initWithReceivedInvocations: [NetworkClientProtocol] = []
    var initWithClosure: ((NetworkClientProtocol) -> Void)?

    required init(with client: NetworkClientProtocol) {
        initWithReceivedClient = client
        initWithReceivedInvocations.append(client)
        initWithClosure?(client)
    }
    //MARK: - fetchAllArticles

    var fetchAllArticlesQueryCompletionCallsCount = 0
    var fetchAllArticlesQueryCompletionCalled: Bool {
        return fetchAllArticlesQueryCompletionCallsCount > 0
    }
    var fetchAllArticlesQueryCompletionReceivedArguments: (query: String, completion: (Result<[Article], RequestError>) -> Void)?
    var fetchAllArticlesQueryCompletionReceivedInvocations: [(query: String, completion: (Result<[Article], RequestError>) -> Void)] = []
    var fetchAllArticlesQueryCompletionClosure: ((String, @escaping (Result<[Article], RequestError>) -> Void) -> Void)?

    func fetchAllArticles(query: String, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        fetchAllArticlesQueryCompletionCallsCount += 1
        fetchAllArticlesQueryCompletionReceivedArguments = (query: query, completion: completion)
        fetchAllArticlesQueryCompletionReceivedInvocations.append((query: query, completion: completion))
        fetchAllArticlesQueryCompletionClosure?(query, completion)
    }

    //MARK: - fetchHeadlines

    var fetchHeadlinesForInCompletionCallsCount = 0
    var fetchHeadlinesForInCompletionCalled: Bool {
        return fetchHeadlinesForInCompletionCallsCount > 0
    }
    var fetchHeadlinesForInCompletionReceivedArguments: (query: String, category: NewsHeadlineCategory, completion: (Result<[Article], RequestError>) -> Void)?
    var fetchHeadlinesForInCompletionReceivedInvocations: [(query: String, category: NewsHeadlineCategory, completion: (Result<[Article], RequestError>) -> Void)] = []
    var fetchHeadlinesForInCompletionClosure: ((String, NewsHeadlineCategory, @escaping (Result<[Article], RequestError>) -> Void) -> Void)?

    func fetchHeadlines(for query: String,                        in category: NewsHeadlineCategory,                        completion: @escaping (Result<[Article], RequestError>) -> Void) {
        fetchHeadlinesForInCompletionCallsCount += 1
        fetchHeadlinesForInCompletionReceivedArguments = (query: query, category: category, completion: completion)
        fetchHeadlinesForInCompletionReceivedInvocations.append((query: query, category: category, completion: completion))
        fetchHeadlinesForInCompletionClosure?(query, category, completion)
    }


}
class NewsRepositoryProtocolMock: NewsRepositoryProtocol {
    var headlineCategories: [NewsHeadlineCategory] = []

    //MARK: - init

    var initNewsFetcherCategoriesReceivedArguments: (newsFetcher: NewsFetcherProtocol, categories: [NewsHeadlineCategory])?
    var initNewsFetcherCategoriesReceivedInvocations: [(newsFetcher: NewsFetcherProtocol, categories: [NewsHeadlineCategory])] = []
    var initNewsFetcherCategoriesClosure: ((NewsFetcherProtocol, [NewsHeadlineCategory]) -> Void)?

    required init(newsFetcher: NewsFetcherProtocol, categories: [NewsHeadlineCategory]) {
        initNewsFetcherCategoriesReceivedArguments = (newsFetcher: newsFetcher, categories: categories)
        initNewsFetcherCategoriesReceivedInvocations.append((newsFetcher: newsFetcher, categories: categories))
        initNewsFetcherCategoriesClosure?(newsFetcher, categories)
    }
    //MARK: - setCategories

    var setCategoriesCallsCount = 0
    var setCategoriesCalled: Bool {
        return setCategoriesCallsCount > 0
    }
    var setCategoriesReceivedCategories: [NewsHeadlineCategory]?
    var setCategoriesReceivedInvocations: [[NewsHeadlineCategory]] = []
    var setCategoriesClosure: (([NewsHeadlineCategory]) -> Void)?

    func setCategories(_ categories: [NewsHeadlineCategory]) {
        setCategoriesCallsCount += 1
        setCategoriesReceivedCategories = categories
        setCategoriesReceivedInvocations.append(categories)
        setCategoriesClosure?(categories)
    }

    //MARK: - fetchHeadlines

    var fetchHeadlinesForInCompletionCallsCount = 0
    var fetchHeadlinesForInCompletionCalled: Bool {
        return fetchHeadlinesForInCompletionCallsCount > 0
    }
    var fetchHeadlinesForInCompletionReceivedArguments: (query: String, category: NewsHeadlineCategory, completion: (Result<[Article], RequestError>) -> Void)?
    var fetchHeadlinesForInCompletionReceivedInvocations: [(query: String, category: NewsHeadlineCategory, completion: (Result<[Article], RequestError>) -> Void)] = []
    var fetchHeadlinesForInCompletionClosure: ((String, NewsHeadlineCategory, @escaping (Result<[Article], RequestError>) -> Void) -> Void)?

    func fetchHeadlines(for query: String, in category: NewsHeadlineCategory, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        fetchHeadlinesForInCompletionCallsCount += 1
        fetchHeadlinesForInCompletionReceivedArguments = (query: query, category: category, completion: completion)
        fetchHeadlinesForInCompletionReceivedInvocations.append((query: query, category: category, completion: completion))
        fetchHeadlinesForInCompletionClosure?(query, category, completion)
    }

    //MARK: - fetchArticles

    var fetchArticlesForCompletionCallsCount = 0
    var fetchArticlesForCompletionCalled: Bool {
        return fetchArticlesForCompletionCallsCount > 0
    }
    var fetchArticlesForCompletionReceivedArguments: (query: String, completion: (Result<[Article], RequestError>) -> Void)?
    var fetchArticlesForCompletionReceivedInvocations: [(query: String, completion: (Result<[Article], RequestError>) -> Void)] = []
    var fetchArticlesForCompletionClosure: ((String, @escaping (Result<[Article], RequestError>) -> Void) -> Void)?

    func fetchArticles(for query: String, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        fetchArticlesForCompletionCallsCount += 1
        fetchArticlesForCompletionReceivedArguments = (query: query, completion: completion)
        fetchArticlesForCompletionReceivedInvocations.append((query: query, completion: completion))
        fetchArticlesForCompletionClosure?(query, completion)
    }

    //MARK: - fetchArticlesWithHeadlines

    var fetchArticlesWithHeadlinesForCategoryCompletionCallsCount = 0
    var fetchArticlesWithHeadlinesForCategoryCompletionCalled: Bool {
        return fetchArticlesWithHeadlinesForCategoryCompletionCallsCount > 0
    }
    var fetchArticlesWithHeadlinesForCategoryCompletionReceivedArguments: (query: String, category: NewsHeadlineCategory, completion: (Result<AggregatedArticles, RequestError>) -> Void)?
    var fetchArticlesWithHeadlinesForCategoryCompletionReceivedInvocations: [(query: String, category: NewsHeadlineCategory, completion: (Result<AggregatedArticles, RequestError>) -> Void)] = []
    var fetchArticlesWithHeadlinesForCategoryCompletionClosure: ((String, NewsHeadlineCategory, @escaping (Result<AggregatedArticles, RequestError>) -> Void) -> Void)?

    func fetchArticlesWithHeadlines(for query: String, category: NewsHeadlineCategory, completion: @escaping (Result<AggregatedArticles, RequestError>) -> Void) {
        fetchArticlesWithHeadlinesForCategoryCompletionCallsCount += 1
        fetchArticlesWithHeadlinesForCategoryCompletionReceivedArguments = (query: query, category: category, completion: completion)
        fetchArticlesWithHeadlinesForCategoryCompletionReceivedInvocations.append((query: query, category: category, completion: completion))
        fetchArticlesWithHeadlinesForCategoryCompletionClosure?(query, category, completion)
    }


}

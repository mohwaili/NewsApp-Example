//
//  File.swift
//  NewsAppUITests
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import EarlGrey

class NewsOverviewPage: Page {
    
    override func verify() {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.rootViewId))
            .assert(grey_notNil())
    }
    
}

// MARK: - Actions
extension NewsOverviewPage {
    
    @discardableResult
    func scrollCategories() -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.categories))
            .perform(grey_scrollInDirection(.right, 170))
        return self
    }
    
    @discardableResult
    func enterQuery(_ query: String) -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.searchBar))
            .perform(grey_typeText(query))
        return self
    }
    
    @discardableResult
    func tapSearch() -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityLabel("zoek"))
            .perform(grey_tap())
        return self
    }
    
    @discardableResult
    func scrollThroughArticles() -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.articlesTableView))
            .perform(grey_scrollInDirection(.down, 250))
        return self
    }
    
    @discardableResult
    func tapArticle(at index: Int, in section: Int) -> Self {
        EarlGrey
            .selectElement(
                with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.articleItem(at: index, in: section)))
            .perform(grey_tap())
        return self
    }
    
}

// MARK: - Assertions
extension NewsOverviewPage {
    
    @discardableResult
    func assertSearchBarVisible() -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.searchBar))
            .assert(grey_sufficientlyVisible())
        return self
    }
    
    @discardableResult
    func assertCategoriesAreVisible() -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.categories))
            .assert(grey_sufficientlyVisible())
        return self
    }
    
    @discardableResult
    func assertCategoryTitle(_ title: String, atIndex: Int) -> Self {
        EarlGrey
            .selectElement(with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.categoryItem(at: atIndex)))
            .assert(grey_text(title))
        return self
    }
    
    @discardableResult
    func assertArticleTitle(_ title: String, index: Int, section: Int) -> Self {
        EarlGrey
            .selectElement(
                with: grey_accessibilityID(AccessibilityIdenitifers.NewsOverview.articleItem(at: index, in: section)))
            .assert(grey_text(title))
        return self
    }
    
}

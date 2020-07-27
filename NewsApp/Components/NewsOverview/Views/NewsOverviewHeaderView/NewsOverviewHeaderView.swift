//
//  NewsOverviewHeaderView.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit
import NewsAPIKit
import NewsUIKit

protocol NewsOverviewHeaderViewDelegate: class {
    func newsOverviewHeaderView(didStartSearch query: String, category: NewsHeadlineCategory)
}

class NewsOverviewHeaderView: UIView {

    private let viewModel: NewsOverviewHeaderViewModel
    
    private lazy var searchBar: UISearchBar = createSearchBar()
    private lazy var categoriesCollectionView: NewsCategoriesCollectionView = createNewsCategoriesCollectionView()
    
    private var selectedCategory: NewsHeadlineCategory?
    
    weak var delegate: NewsOverviewHeaderViewDelegate?
    
    init(with viewModel: NewsOverviewHeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(searchBar)
        addSubview(categoriesCollectionView)
        
        // SearchBar constraints
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // categories collectionView constraints
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        categoriesCollectionView.reloadData()
    }

}

// MARK: - NewsCategoriesCollectionViewSelectionDelegate
extension NewsOverviewHeaderView: NewsCategoriesCollectionViewSelectionDelegate {
    
    func newsCategoriesCollectionView(didSelected category: NewsHeadlineCategory) {
        selectedCategory = category
    }
    
}

// MARK: - UISearchBarDelegate
extension NewsOverviewHeaderView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let category = selectedCategory ?? viewModel.defaultCategory
        guard let query = searchBar.text else {
            return
        }
        searchBar.resignFirstResponder()
        delegate?.newsOverviewHeaderView(didStartSearch: query, category: category)
    }
    
}

// MARK: - UI
extension NewsOverviewHeaderView {
    
    private func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = Localized.searchFieldPlaceholder
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    private func createNewsCategoriesCollectionView() -> NewsCategoriesCollectionView {
        let collectionView = NewsCategoriesCollectionView(with: viewModel.categories)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.selectionDelegate = self
        collectionView.accessibilityIdentifier = AccessibilityIdenitifers.NewsOverview.categories
        return collectionView
    }
    
}

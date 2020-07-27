//
//  NewsCategoriesCollectionView.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

protocol NewsCategoriesCollectionViewSelectionDelegate: class {
    func newsCategoriesCollectionView(didSelected category: NewsHeadlineCategory)
}

class NewsCategoriesCollectionView: UICollectionView {
    
    struct Constants {
        static let reusableCellIdentifier = "CategoryCollectionViewCell"
    }
    
    private let categories: [NewsHeadlineCategory]
    private lazy var categoriesCollectionViewDataSource = NewsCategoriesCollectionViewDataSource(categories: categories)
    // swiftlint:disable weak_delegate
    private lazy var categoriesCollectionViewDelegate =
        NewsCategoriesCollectionViewDelegate(categories: categories) { (selectedCategory) in
        self.setCategorySelected(selectedCategory)
    }
    
    weak var selectionDelegate: NewsCategoriesCollectionViewSelectionDelegate?
    
    init(with categories: [NewsHeadlineCategory]) {
        self.categories = categories
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.dataSource = categoriesCollectionViewDataSource
        self.delegate = categoriesCollectionViewDelegate
        
        self.register(NewsCategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reusableCellIdentifier)
        setCategorySelected(.business)
    }
    
    private func setCategorySelected(_ category: NewsHeadlineCategory) {
        categoriesCollectionViewDataSource.setCategorySelected(category)
        selectionDelegate?.newsCategoriesCollectionView(didSelected: category)
        visibleCells.forEach { ($0 as? NewsCategoryCollectionViewCell)?.setSelected(false) }
        let cell = visibleCells
            .first(where: { ($0 as? NewsCategoryCollectionViewCell)?.category == category })
            as? NewsCategoryCollectionViewCell
        cell?.setSelected(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

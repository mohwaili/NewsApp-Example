//
//  NewsCategoriesCollectionViewDataSource.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsCategoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private let categories: [NewsHeadlineCategory]
    private var selectedCategory: NewsHeadlineCategory = .business // Default
    
    init(categories: [NewsHeadlineCategory]) {
        self.categories = categories
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: NewsCategoriesCollectionView.Constants.reusableCellIdentifier,
                for: indexPath) as? NewsCategoryCollectionViewCell else {
            fatalError("Wrong configuration")
        }
        let category = categories[indexPath.row]
        cell.configure(with: category, at: indexPath, isSelected: category == selectedCategory)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func setCategorySelected(_ category: NewsHeadlineCategory) {
        selectedCategory = category
    }
    
}

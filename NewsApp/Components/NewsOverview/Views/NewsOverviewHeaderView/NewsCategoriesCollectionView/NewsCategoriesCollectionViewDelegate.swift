//
//  NewsCategoriesCollectionViewDelegate.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsCategoriesCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private let categories: [NewsHeadlineCategory]
    private var categorySelectedClosure: ((NewsHeadlineCategory) -> Void)?
    
    init(categories: [NewsHeadlineCategory], categorySelectedClosure: ((NewsHeadlineCategory) -> Void)? = nil) {
        self.categories = categories
        self.categorySelectedClosure = categorySelectedClosure
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorySelectedClosure?(categories[indexPath.row])
    }
    
}

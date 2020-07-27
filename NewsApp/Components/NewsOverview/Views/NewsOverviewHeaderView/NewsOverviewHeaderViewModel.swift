//
//  NewsOverviewHeaderViewModel.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 25/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import NewsAPIKit

class NewsOverviewHeaderViewModel {
    let defaultCategory: NewsHeadlineCategory = .business
    let categories: [NewsHeadlineCategory]
    
    init(categories: [NewsHeadlineCategory]) {
        self.categories = categories
    }
}

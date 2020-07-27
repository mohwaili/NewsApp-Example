//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import NewsAPIKit

class NewsDetailViewModel {
    
    let article: Article
    
    private let formatter: DateFormatter
    
    var publishedDateString: String? {
        guard let date = article.publishedDate else {
            return nil
        }
        return formatter.string(from: date)
    }
    
    var backgroundColor: UIColor {
        .white
    }
    
    init(with article: Article) {
        self.article = article
        formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
    }
    
}

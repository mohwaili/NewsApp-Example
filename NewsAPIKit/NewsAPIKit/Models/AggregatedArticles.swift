//
//  AggregatedArticles.swift
//  NewsAPIKit
//
//  Created by Mohammed Al Waili on 27/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

public struct AggregatedArticles: Equatable {
   
    public let headlines: [Article]
    public let articles: [Article]
    
    public init(headlines: [Article], articles: [Article], headlinesLimit: Int = 3) {
        self.headlines = Array(headlines.prefix(headlinesLimit))
        self.articles = articles
    }
    
    public static func == (lhs: AggregatedArticles, rhs: AggregatedArticles) -> Bool {
        return lhs.headlines == rhs.headlines && lhs.articles == rhs.articles
    }
    
}
